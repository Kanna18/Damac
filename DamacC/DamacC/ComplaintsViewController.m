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
    
    [_selectUnitsButton setTitle:@"Select Units" forState:UIControlStateNormal];
    [self.complaintsTF setValue:goldColor
                    forKeyPath:@"_placeholderLabel.textColor"];

    
    [self adjustImageEdgeInsetsOfButton:_selectSubBtn];
    [self adjustImageEdgeInsetsOfButton:_selectComplaintBtn];
    [self adjustImageEdgeInsetsOfButton:_selectUnitsButton];
    
    if(_srdRental){
        [self complaintsEditForm];
        [_complaintsObj  fillValuesWithServiceDetails:_srdRental];
    }
}

-(void)complaintsEditForm{
    [_selectUnitsButton setTitle:_srdRental.Booking_Unit_Name__c forState:UIControlStateNormal];
    [_selectComplaintBtn setTitle:_srdRental.Complaint_Type__c forState:UIControlStateNormal];
    [_selectSubBtn setTitle:_srdRental.Complaint_Sub_Type__c forState:UIControlStateNormal];
    _complaintsTF.text = _srdRental.Description;
}

-(void)adjustImageEdgeInsetsOfButton:(UIButton*)sender{
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-100, 0, 0);
}
-(void)fillLabelsWithSRDValues{
    [_selectUnitsButton setTitle:@"Select Units" forState:UIControlStateNormal];
    [_selectComplaintBtn setTitle:@"Select Complaint Type*" forState:UIControlStateNormal];
    [_selectSubBtn setTitle:@"Select Complaint Sub-Type" forState:UIControlStateNormal];
    _complaintsTF.text = _complaintsObj.Description;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[DamacSharedClass sharedInstance].navigationCustomBar setPageTite:@"My complaints"];
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
    
    if([self validationsForSubmitComplaint]){
        
    }else{
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
        _complaintsObj.Status = @"Submitted";
        [self uploadImagesToServer];
    }
    
}

- (IBAction)saveDraftClick:(id)sender {
    
    if([self validationsForSubmitComplaint]){
        
    }
    else{
    _complaintsObj.Status = @"Draft Request";
    if(_complaintsObj.attactment1||_complaintsObj.attactment2){
        [self uploadImagesToServer];
    }else{
        [_complaintsObj sendDraftStatusToServer];
        
    }
     [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    }
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
        if(tag >0){
        _complaintsObj.ComplaintType = str;
        }else{
            _complaintsObj.ComplaintType = @"";
        }
        _complaintsObj.ComplaintSubType = @"";
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
    if(currentImagebtn == 1&&image){
        _complaintsObj.attactment1 = image;
        _attachment1Label.text = @"cacheJPEG1.jpg";
    }
    if(currentImagebtn == 2&&image){
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
    
    if(!_complaintsObj.attactment2&&!_complaintsObj.attactment2){
        [_complaintsObj sendDraftStatusToServer];
    }
   
    
}


-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    countoFImagesUploaded ++;
    
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    
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

-(BOOL)validationsForSubmitComplaint{
    
    if(isEmpty(_complaintsObj.BookingUnit)){
        [FTIndicator showToastMessage:@"Please Select UnitType"];
        return YES;
    }
    if(isEmpty(_complaintsObj.ComplaintType)){
        [FTIndicator showToastMessage:@"Please select complaint type"];
        return YES;
    }
    if(isEmpty(_complaintsObj.Description)){
        [FTIndicator showToastMessage:@"Complaint Description is mandatory"];
        return YES;
    }
    return NO;
    
    
}

@end
