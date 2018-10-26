//
//  ComplaintsViewController.m
//  DamacC
//
//  Created by Gaian on 14/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ComplaintsViewController.h"

@interface ComplaintsViewController ()<UITextFieldDelegate,ImagePickedProtocol,UITextFieldDelegate>

@end

@implementation ComplaintsViewController{
    
    WYPopoverController *popoverController;
    CameraView *camView;
    NSArray *unitsArray,*complaintsArray,*subComplaintsArray,*commonArray,*localJSONFileArray;
    
    UIButton *currentButton;
    int countoFImagestoUplaod,countoFImagesUploaded,currentImagebtn;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self roundCorners:_selectUnitsButton];
    [self roundCorners:_selectComplaintBtn];
    [self roundCorners:_selectSubBtn];
    [self roundCorners:_attachDocButton];
    [self roundCorners:_submitSRButton];
    [self roundCorners:_saveDraftNumber];
    [DamacSharedClass sharedInstance].currentVC = self;
    camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:self];
    camView.delegate = self;
    [self.view addSubview:camView];
    _complaintsTF.delegate = self;
    localJSONFileArray= [self JSONFromFile];
    complaintsArray = [localJSONFileArray valueForKey:@"key"];
    subComplaintsArray = [localJSONFileArray[0] valueForKey:@"value"];
    [self fillUnitsArray];
    _submitSRButton.layer.borderColor = goldColor.CGColor;
    _submitSRButton.layer.borderWidth = 1.5f;

    currentImagebtn = 0;
    _selectUnitsButton.tag = 1000;
    _selectComplaintBtn.tag = 2000;
    _selectSubBtn.tag = 3000;
    
    _complaintsTF.delegate = self;
    
    
    [self fillLabelsWithSRDValues];
}
-(void)fillLabelsWithSRDValues{
    [_selectUnitsButton setTitle:_complaintsObj.BookingUnit forState:UIControlStateNormal];
    [_selectComplaintBtn setTitle:_complaintsObj.ComplaintType forState:UIControlStateNormal];
    [_selectSubBtn setTitle:_complaintsObj.ComplaintSubType forState:UIControlStateNormal];
    _complaintsTF.text = _complaintsObj.Description;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectUnits:(id)sender {
    
    [self showpopover:(UIButton*)sender withArrar:unitsArray onButton:(UIButton*)sender];
}

- (IBAction)selectCompleintClick:(id)sender {
    [self showpopover:(UIButton*)sender withArrar:complaintsArray onButton:(UIButton*)sender];
}

- (IBAction)selectSubComplaint:(id)sender {
    [self showpopover:(UIButton*)sender withArrar:subComplaintsArray onButton:(UIButton*)sender];
}
- (IBAction)attachmentClick1:(id)sender {
    currentImagebtn = 1;
    [camView frameChangeCameraView];
}

- (IBAction)attachmentClick2:(id)sender {
    currentImagebtn = 2;
    [camView frameChangeCameraView];
}

- (IBAction)attachDocument:(id)sender {
}

- (IBAction)submitSRClick:(id)sender {
    
    if(!(_complaintsObj.BookingUnit.length>0)){
        [FTIndicator showToastMessage:@"Please Select UnitType"];
        return;
    }
    if(!(_complaintsObj.ComplaintType.length>0)){
        [FTIndicator showToastMessage:@"Please select complaint type"];
        return;
    }

    _complaintsObj.Status = @"Submitted";
    [self uploadImagesToServer];
    
}

- (IBAction)saveDraftClick:(id)sender {
    
    if(!(_complaintsObj.BookingUnit.length>0)){
        [FTIndicator showToastMessage:@"Please Select UnitType"];
        return;
    }
    if(!(_complaintsObj.ComplaintType.length>0)){
        [FTIndicator showToastMessage:@"Please select complaint type"];
        return;
    }
    _complaintsObj.Status = @"Draft Request";
    if(_complaintsObj.attactment1||_complaintsObj.attactment2){
        [self uploadImagesToServer];
    }else{
        [_complaintsObj sendDraftStatusToServer];
        
    }
     [FTIndicator showProgressWithMessage:@"Please Wait"];
}

-(void)roundCorners:(UIButton*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
}

-(void)showpopover:(UIButton*)drop withArrar:(NSArray*)arr onButton:(UIButton*)cBtn{
    
    currentButton = cBtn;
    commonArray = arr;
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = arr;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, arr.count*50);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}


#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
 
    [currentButton setTitle:commonArray[tag] forState:UIControlStateNormal];
    [popoverController dismissPopoverAnimated:YES];
    
    if(currentButton.tag == 1000){
        _complaintsObj.BookingUnit = str;
    }
    if(currentButton.tag == 2000){
        subComplaintsArray = [localJSONFileArray[tag] valueForKey:@"value"];
        [_selectSubBtn setTitle:@"Select Complaint Sub-Type" forState:UIControlStateNormal];
        _complaintsObj.ComplaintType = str;
    }
    if(currentButton.tag == 3000){
        _complaintsObj.ComplaintSubType = str;
    }
}

-(void)fillUnitsArray{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (ResponseLine *rs in [DamacSharedClass sharedInstance].unitsArray) {
        NSString *str = [NSString stringWithFormat:@"%@",rs.unitNumber];
        [arr addObject:str];
    }
    unitsArray = (NSArray*)arr;
}
-(void)getComplaintsListArray{
    
}

- (NSArray*)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Complaints" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma Mark camView Delegate

-(void)imagePickerSelectedImage:(UIImage *)image{
    if(currentImagebtn == 1){
        _complaintsObj.attactment1 = image;
        _attachment1Label.text = @"cacheJPEG1.jpg";
    }
    if(currentImagebtn == 2){
        _complaintsObj.attactment2 = image;
        _attachment2Label.text = @"cacheJPEG2.jpg";
    }
}

-(void)uploadImagesToServer{
    
    _soap= [[SaopServices alloc]init];
    _soap.delegate = self;
    if(_complaintsObj.attactment1){
        NSString *str = @"ComplaintsAttachment1";
        [_soap uploadDocumentTo:_complaintsObj.attactment1 P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    _soap2 = [[SaopServices alloc]init];
    _soap2.delegate = self;
    if(_complaintsObj.attactment2){
        NSString *str = @"ComplaintsAttachment2";
        [_soap2 uploadDocumentTo:_complaintsObj.attactment2 P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
   
    
}


-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    countoFImagesUploaded ++;
    
    [FTIndicator showProgressWithMessage:@"Please Wait"];
    
    if ([path rangeOfString:@"ComplaintsAttachment1"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _complaintsObj.attactment1Path = path;
    }
    
    if ([path rangeOfString:@"ComplaintsAttachment2"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _complaintsObj.attactment2Path = path;
    }
    
    if(countoFImagestoUplaod == countoFImagesUploaded){
        [_complaintsObj sendDraftStatusToServer];
    }
}

#pragma Mark TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    _complaintsObj.Description = textField.text;
}

@end
