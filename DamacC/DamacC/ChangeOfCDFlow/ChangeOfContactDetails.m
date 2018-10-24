//
//  ChangeOfContactDetails.m
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ChangeOfContactDetails.h"
#import "ChangeofContactCell2.h"
#import "PassportHeader.h"
#import "JointBView2.h"

#define butonTitleSubmitSR @"Submit SR"
#define buttonTitleNext @"Next"


@interface ChangeOfContactDetails ()<KPDropMenuDelegate,UITextFieldDelegate,WYPopoverControllerDelegate,POPDelegate,SoapImageuploaded>

@end

@implementation ChangeOfContactDetails{
    
    StepperView *sterView;
    CGFloat heightTV,numberOfCells,sections;
    NSArray *tvArr,*section2Array ;
    UIColor *selectedColor;
    NSArray *dropItems;
    WYPopoverController* popoverController;
    
    NSInteger *section2Cells;
    UITextField *currentTF;
    NSArray *countriesArray;
    JointBView2 *jbView;
    CGRect frame3;
    CGRect originalBoundsoFScrollView;
    
    BOOL uploadDocsPageVisible;
    int countoFImagestoUplaod,countoFImagesUploaded;

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DamacSharedClass.sharedInstance.currentVC = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _stepperBaseView.backgroundColor = [UIColor clearColor];
    heightTV = 50;
    numberOfCells = 3;
    sections = 1;
    section2Cells = 0;
    _tableViewHeight.constant = heightTV;
    countoFImagestoUplaod = 0;
    countoFImagesUploaded = 0;
    
    selectedColor = _view1.backgroundColor;
    [self mobileClick:nil];
    
    [self layerRadius:_view1];
    [self layerRadius:_view2];
    [self layerRadius:_view3];
    
    _downloadBtn.layer.cornerRadius = 5;
    _downloadBtn.layer.borderWidth =1.0f;
    _downloadBtn.layer.borderColor = rgb(191, 154, 88).CGColor;
    
    [self getCountriesList];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)getCountriesList{
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server getRequestwithUrl:kgetCountriesList withParameters:nil successBlock:^(id responseObj) {
        if(responseObj){
            countriesArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    sterView = [[StepperView alloc]initWithFrame:_stepperBaseView.frame];
    [self.view addSubview:sterView];
    originalBoundsoFScrollView = self.scrollView.bounds;
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showpopover:(UIButton*)button{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = countriesArray;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(button.frame.size.width, UIScreen.mainScreen.bounds.size.height-30);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark PopOverDelegates

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
    _cocdOBj.Country = str;
    [self.tableView reloadData];
    [popoverController dismissPopoverAnimated:YES];
    
}
#pragma mark UiTableViewDelegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sections;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0){
        return tvArr.count;
    }if(section ==1){
        return  section2Cells;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        ChangeofContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changeofContactCell" forIndexPath:indexPath];
        cell.subLabel.text = tvArr[indexPath.row][@"key"];
        cell.textField.text = tvArr[indexPath.row][@"value"];
        cell.textField.tag = [tvArr[indexPath.row][@"tag"] intValue];
        cell.textField.delegate = self;
        cell.cocdOBj = _cocdOBj;
        cell.clipsToBounds = NO;
        [cell.selectCountryButtton addTarget:self action:@selector(showpopover:) forControlEvents:UIControlEventTouchUpInside];
        [cell.selectCountryButtton setTitle:_cocdOBj.Country forState:UIControlStateNormal];
        return cell;
    }
    if(indexPath.section ==1){
        ChangeofContactCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"changeofContactCell2" forIndexPath:indexPath];
        cell.subLabel.text = section2Array[indexPath.row][@"key"];
        cell.textField.text = section2Array[indexPath.row][@"value"];
        cell.textField.delegate = self;
        cell.textField.tag = [section2Array[indexPath.row][@"tag"] intValue];
        cell.clipsToBounds = NO;
        cell.cocdOBj = _cocdOBj;
        return cell;
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        ChangeofContactCell *cell1 = (ChangeofContactCell*)cell ;
        if(indexPath.row==5){
            cell1.borderView.hidden = YES;
            cell1.selectCountryButtton.hidden =NO;
        }else{
            cell1.selectCountryButtton.hidden =YES;
            cell1.borderView.hidden = NO;
        }
    }
}
-(void)layerRadius:(UIView*)vw{
    vw.layer.cornerRadius = 5.0f;
    vw.layer.borderWidth = 1.0f;
    vw.layer.borderColor = selectedColor.CGColor;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return heightTV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    if(section == 1){
        return 60;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
    PassportHeader *vi = [[PassportHeader alloc]initWithFrame:CGRectZero];
    vi.headerLabel.text = @"Address in Arabic";
    vi.headerButton.tag = section;
    [vi.headerButton addTarget:self action:@selector(hideSectioncells:) forControlEvents:UIControlEventTouchUpInside];
    return vi;
    }
    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"";
    }
    if(section == 1){
        return @"Address in Arabic";
    }
    return @"";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)hideSectioncells:(UIButton*)sender{
    if(section2Cells == (NSInteger*)section2Array.count){
        section2Cells = 0;
    }else{
       section2Cells = (NSInteger*)section2Array.count;
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.tag];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];    
    if(section2Cells > 0){
        [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}
- (IBAction)mobileClick:(id)sender {
    [currentTF resignFirstResponder];
        sections = 1;
        numberOfCells = 1;
        _tableViewHeight.constant = heightTV;
    NSLog(@"%@",[DamacSharedClass sharedInstance].userProileModel);
    tvArr = @[@{@"key":@"Mobile No.",
                @"value":_cocdOBj.Mobile,
                @"tag" : [NSNumber numberWithInt:Mobile]
                }
              ];
    [_tableView reloadData];
    [self setColorsForSelectedButton:_view1];
}


-(void)setColorsForSelectedButton:(UIView*)v{
    _view1.backgroundColor = [UIColor clearColor];
    _view2.backgroundColor = [UIColor clearColor];
    _view3.backgroundColor = [UIColor clearColor];
    
    v.backgroundColor = selectedColor;
    
}

- (IBAction)emailClick:(id)sender {
    [currentTF resignFirstResponder];
        sections = 1;
        numberOfCells = 1;
        _tableViewHeight.constant = heightTV;
    tvArr = @[@{@"key":@"Email",
                @"value":_cocdOBj.Email,
                @"tag" : [NSNumber numberWithInt:Email]
                }];
    [_tableView reloadData];
    [self setColorsForSelectedButton:_view2];
}

- (IBAction)addressClick:(id)sender {
    [currentTF resignFirstResponder];
        sections = 2;
        numberOfCells = 3;
        _tableViewHeight.constant = 280;
    tvArr = @[@{@"key":@"Address1",
                @"value":_cocdOBj.AddressLine1,
                @"tag" : [NSNumber numberWithInt:Address1]},
              @{@"key":@"Address2",
                @"value":_cocdOBj.AddressLine2,
                @"tag" : [NSNumber numberWithInt:Address2]},
              @{@"key":@"Address3",
                @"value":_cocdOBj.AddressLine3,
                @"tag" : [NSNumber numberWithInt:Address3]},
              @{@"key":@"Address4",
                @"value":_cocdOBj.AddressLine4,
                @"tag" : [NSNumber numberWithInt:Address4]},
              @{@"key":@"City",
                @"value":_cocdOBj.City,
                @"tag" : [NSNumber numberWithInt:City]},
              @{@"key":@"Country",
                @"value":@"",
                @"tag" : [NSNumber numberWithInt:4]},//[NSString stringWithFormat:@"%@",udm.countryOfResidence]},
              @{@"key":@"State",
                @"value":_cocdOBj.State,
                @"tag" : [NSNumber numberWithInt:State]},
              @{@"key":@"Postal Code",
                @"value":_cocdOBj.PostalCode,
                @"tag" : [NSNumber numberWithInt:PostalCode]}
              ];
    section2Array = @[@{@"key":@"Address1\n(in Arabic) ",
                        @"value":_cocdOBj.AddressLine1Arabic,
                        @"tag" : [NSNumber numberWithInt:Address1Arabic]
                        },
                      @{@"key":@"City\n(in Arabic)",
                        @"value":_cocdOBj.AddressLine2Arabic,
                        @"tag" : [NSNumber numberWithInt:CityArabic]
                        },
                      @{@"key":@"Country\n(in Arabic)",
                        @"value":_cocdOBj.AddressLine3Arabic,
                        @"tag" : [NSNumber numberWithInt:CountryArabic]
                        },
                      @{@"key":@"State(in Arabic)",
                        @"value":_cocdOBj.AddressLine4Arabic,
                        @"tag" : [NSNumber numberWithInt:StateInArabic]
                        }];
    [self setColorsForSelectedButton:_view3];
    [_tableView reloadData];
}
-(void)addJointView2{
    
    _tableViewHeight.constant = 320;
    frame3 = _scrollView.bounds;
    frame3.origin.x = frame3.size.width+10;
    frame3.size.height = 320;
    _buttonsViewHeight.constant = 0;
    
    jbView = [[JointBView2 alloc]initWithFrame:frame3];
    [_scrollView addSubview:jbView];
    jbView.saveDraftBtn.hidden =YES;
    jbView.submitSR.hidden =YES;
    jbView.cocdObj = _cocdOBj;
    [jbView.previous addTarget:self action:@selector(previousClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)nextClick:(id)sender{
    UIButton *btn = (UIButton*)sender;
    if([btn.titleLabel.text isEqualToString:butonTitleSubmitSR])
    {
        if(_cocdOBj.cocdImage == nil){
            [FTIndicator showToastMessage:@"COCD Document not selected"];
        }
        else if(![_cocdOBj.Email validateEmailWithString]){
            [FTIndicator showToastMessage:@"Enter Valid Email Id"];
            [self previousClick:nil];
            [self emailClick:nil];
            [_tableView reloadData];
            return;
        }
        else
        {
            _cocdOBj.Status = @"Submitted";
            [self saveOrSubmitDraftRequestWithImages];
        }
    }
    else
    {
        [self addJointView2];
        _downloadBtn.hidden = YES;
        _buttonsView.hidden = YES;
        uploadDocsPageVisible = YES;
        [_nextbtn setTitle:butonTitleSubmitSR forState:UIControlStateNormal];
        
        [_scrollView setContentOffset:frame3.origin animated:YES];
        sterView.line1Animation = YES;
    }
    
}
- (IBAction)previousClick:(id)sender{
    
    _cocdOBj.cocdImage = [UIImage imageNamed:@""];
    _cocdOBj.primaryPassportImage = [UIImage imageNamed:@""];
    _cocdOBj.additionalDocumentImage = [UIImage imageNamed:@""];
    [currentTF resignFirstResponder];
    
    _scrollView.bounds = originalBoundsoFScrollView;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [jbView removeFromSuperview];
    [_nextbtn setTitle:buttonTitleNext forState:UIControlStateNormal];
    _downloadBtn.hidden = NO;
    _buttonsView.hidden = NO;
    _tableViewHeight.constant = 70;
    _buttonsViewHeight.constant =50;
    
    
    
}
- (IBAction)saveDraftClick:(id)sender {
    
    //    case1: whenEver Clicked on SaveDraft Button Need to check Email Valdiation
    [currentTF resignFirstResponder];
    _cocdOBj.Status = @"Draft Request";
    if(![_cocdOBj.Email validateEmailWithString]&&uploadDocsPageVisible){
        [self previousClick:nil];
        [self emailClick:nil];
        [FTIndicator showToastMessage:@"Plaease enter a valid Email"];
        return;
    }
    //    case2:Whenever Button title "SubmitSR" title appeared and Images are available
    else if([_nextbtn.titleLabel.text isEqualToString:butonTitleSubmitSR]&&(_cocdOBj.cocdImage||_cocdOBj.additionalDocumentImage||_cocdOBj.primaryPassportImage))
    {
        [self saveOrSubmitDraftRequestWithImages];
    }
    else{
        
        [self saveDraftRequest];
    }
}
-(void)saveOrSubmitDraftRequestWithImages{
    [FTIndicator showProgressWithMessage:[NSString stringWithFormat:@"%@ SR",_cocdOBj.Status]];
    [self uploadImagesToServer];
    
}
-(void)uploadImagesToServer{
    
    SaopServices *soap= [[SaopServices alloc]init];
    soap.delegate = self;
    if(_cocdOBj.cocdImage){
    [soap uploadDocumentTo:_cocdOBj.cocdImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"COCD" fileId:@"COCD" fileName:@"COCD" registrationId:nil sourceFileName:@"COCD" sourceId:@"COCD"];
        countoFImagestoUplaod++;
    }
    SaopServices *soap2 = [[SaopServices alloc]init];
    soap2.delegate = self;
    if(_cocdOBj.additionalDocumentImage){
        NSString *str = @"AdditionalDoc";
        [soap2 uploadDocumentTo:_cocdOBj.additionalDocumentImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    SaopServices *soap3 = [[SaopServices alloc]init];
    soap3.delegate = self;
    if(_cocdOBj.primaryPassportImage){
        NSString *str = @"PassportOfBuyer";
        [soap3 uploadDocumentTo:_cocdOBj.primaryPassportImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
}

#pragma mark Soap Image uploaded Delegate

-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    countoFImagesUploaded ++;
    
    if ([path rangeOfString:@"COCD"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _cocdOBj.cocdUploadedImagePath = path;
    }
    
    if ([path rangeOfString:@"AdditionalDoc"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _cocdOBj.additionalImageUploadedImagePath = path;
    }
    
    if ([path rangeOfString:@"PassportOfBuyer"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _cocdOBj.primaryPassportUploadedImagePath = path;
    }
    
    if(countoFImagestoUplaod == countoFImagesUploaded){
        [_cocdOBj sendDraftStatusToServer];
    }
}

-(void)saveDraftRequest{
    if([_cocdOBj.Email validateEmailWithString]){
        _cocdOBj.Status = @"Draft Request";
        [_cocdOBj sendDraftStatusToServer];
        [FTIndicator showProgressWithMessage:@"Saving Draft"];
    }else{
        [FTIndicator showToastMessage:@"Plaease enter a valid Email"];
        [self emailClick:nil];
    }
}

- (IBAction)downloadFormClick:(id)sender {
}

#pragma mark TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTF = textField;
    NSLog(@"%@",textField.placeholder);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [_cocdOBj changeValueBasedonTag:textField withValue:textField.text];
    NSLog(@"%@",_cocdOBj);
}

-(void)uploadImagesIfAny{
//    Pragma Mark Uploading Images based on a condition that Button Name changed to SUBMIT SR and
//     and cocdImag or PasportImage or AddiditionalImage is available
    if([_nextbtn.titleLabel.text isEqualToString:butonTitleSubmitSR])
    {
        
    }
    
}


@end
