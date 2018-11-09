//
//  RentalPoolViewCellViewController.m
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "RentalPoolViewCellViewController.h"
#import "JointView1.h"
#import "JointBuyerCell.h"
#import "JointBuyerObject.h"


@interface RentalPoolViewCellViewController ()<KPDropMenuDelegate,WYPopoverControllerDelegate,POPDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>

@end

@implementation RentalPoolViewCellViewController{
    
    WYPopoverController* popoverController;
    WYPopoverController* popoverBuyers;
    
    KPDropMenu *dropNew;
    StepperView *sterView;
//    JointBView2 *jbView ;
    JointView1 *jbView1;
    CGRect frame2 , frame3;
    ServerAPIManager *serverAPI;
    NSMutableArray *buyersInfoArr;
    NSMutableArray *dropitems;
    NSArray *headingLabels ,*dataLabels;
    NSArray *countriesArray;
    int countoFImagestoUplaod,countoFImagesUploaded;
    COCDTF *currentTextFieldRef;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self initialiseSecondViewThirdView];
    
    serverAPI =[ServerAPIManager sharedinstance];
    buyersInfoArr = [[NSMutableArray alloc]init];
    [self webServicetoGetUnitSFIds];
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    dropitems = [[NSMutableArray alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self roundCorners:_dropDownCountriesBtn];
    
    [self getCountriesList];
    countoFImagestoUplaod = 0;
    countoFImagesUploaded = 0;
//    _scrollView.scrollEnabled = NO;
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    _scrollView.delegate = self;
    _tableView.scrollEnabled = NO;
    
    [self adjustImageEdgeInsetsOfButton:_buyersNewBtn];
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
//    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.layer.borderWidth = 2.0f;
    sender.clipsToBounds = YES;
    [self adjustImageEdgeInsetsOfButton:sender];
}

-(void)webServicetoGetUnitSFIds{
    
    [serverAPI postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSArray *idsArr = [arr valueForKey:@"Booking__c"];
            [self getBuyersInfoBasedonUnitIDS:idsArr];
        }
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
    
}

-(void)adjustImageEdgeInsetsOfButton:(UIButton*)sender{
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-30-sender.titleLabel.intrinsicContentSize.width, 0, 0);
}


-(void)jointBuyerEditFormDetails{
    if(_srdRental){
        for (NSDictionary *dic in buyersInfoArr) {
            if([dic[@"Account__c"] isEqualToString:_srdRental.AccountId]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_buyersNewBtn setTitle:dic[@"First_Name__c"] forState:UIControlStateNormal];
                    _heightConstraint.constant = 5;
                    _detailView.hidden = NO;
                    [self fillLabelsforJointBuyer:-1];
                });
                return;
            }
        }
        
    }
}

-(void)getBuyersInfoBasedonUnitIDS:(NSArray*)arr{
    
    __block int Count = 0;
    for (int i = 0; i<arr.count; i++) {
        [serverAPI postRequestwithUrl:jointBuyersUrl withParameters:@{@"bookingId":arr[i]} successBlock:^(id responseObj) {
            if(responseObj){
                NSArray *myarr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
                NSArray *arrSam = [[NSArray alloc]initWithArray:myarr];
                for (NSDictionary *dict in arrSam) {
                    [buyersInfoArr addObject:dict];
                }
                if(Count == arr.count-1){
                    [self performSelectorOnMainThread:@selector(fillBuyersArray) withObject:nil waitUntilDone:YES];
                    [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                    [self jointBuyerEditFormDetails];
                }
                Count++;
            }
        }  errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];

    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Joint buyer info"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)initialiseSecondViewThirdView{
    
//    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width+3, _firstView.frame.size.height);
    
    frame2 = _firstView.frame;
    frame2.size.height = 500    ;
    frame2.origin.x = [UIScreen mainScreen].bounds.size.width+3;
    
    jbView1 = [[JointView1 alloc]initWithFrame:frame2];
    [jbView1.downloadFormBtn addTarget:self action:@selector(downloadFormDetails) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:jbView1];
    
    [jbView1.saveDraftBtn addTarget:self action:@selector(saveDraftJointBuyers) forControlEvents:UIControlEventTouchUpInside];
    [jbView1.NextButton addTarget:self action:@selector(loadThirdView) forControlEvents:UIControlEventTouchUpInside];
    [jbView1.previousBtn addTarget:self action:@selector(loadFirstView) forControlEvents:UIControlEventTouchUpInside];
    
    [jbView1.saveDraftBtn2 addTarget:self action:@selector(saveDraftJointBuyers) forControlEvents:UIControlEventTouchUpInside];
    [jbView1.previousBtn2 addTarget:self action:@selector(loadFirstView) forControlEvents:UIControlEventTouchUpInside];
    [jbView1.submitSR addTarget:self action:@selector(subJointBuyersResponse) forControlEvents:UIControlEventTouchUpInside];
    
    
    frame3 = _firstView.frame;
    frame3.size.height = 380    ;
    frame3.origin.x = 2*[UIScreen mainScreen].bounds.size.width+3;

//    jbView = [[JointBView2 alloc]initWithFrame:frame3];
//    [_scrollView addSubview:jbView];
//    [jbView.previous addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
//    [jbView.saveDraftBtn addTarget:self action:@selector(saveDraftJointBuyers) forControlEvents:UIControlEventTouchUpInside];
//    [jbView.saveDraftBtn addTarget:self action:@selector(saveDraftJointBuyers) forControlEvents:UIControlEventTouchUpInside];
//    [jbView.submitSR addTarget:self action:@selector(subJointBuyersResponse) forControlEvents:UIControlEventTouchUpInside];
}




-(void)dropMenu{
    
    CGRect fram = [_dropDownView convertRect:_dropDownView.bounds toView:_scrollView];
    _dropDownView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i<buyersInfoArr.count ; i++ ) {
        [dropitems addObject:(NSString*)[buyersInfoArr[i] valueForKey:@"First_Name__c"]];
    }
//    [dropitems addObject:kUserProfile.partyName];
    dropNew = [[KPDropMenu alloc] initWithFrame:fram];
    dropNew.layer.cornerRadius = 10.0f;
    dropNew.layer.borderColor = [UIColor yellowColor].CGColor;
    dropNew.layer.borderWidth = 1.0f;
    dropNew.backgroundColor = [UIColor clearColor];
    dropNew.delegate = self;
    dropNew.items = dropitems;
    dropNew.title = @"Select Buyer";
    dropNew.titleColor = goldColor;
    dropNew.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    dropNew.titleTextAlignment = NSTextAlignmentLeft;
    dropNew.DirectionDown = YES;
    [self.scrollView addSubview:dropNew];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)countriesCLick:(id)sender {
     [self showpopover:_dropDownCountriesBtn];
}

- (IBAction)nextClick:(id)sender {
    
    if([self validationSetForJointBuyer])
    {
        [_scrollView setContentOffset:frame2.origin animated:YES];
        dropNew.hidden = YES;
        sterView.line1Animation = YES;
    }
}
-(void)getCountriesList{
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server getRequestwithUrl:kgetCountriesList withParameters:nil successBlock:^(id responseObj) {
        if(responseObj){
            countriesArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        }
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
}

-(void)showpopover:(UIButton*)drop{

    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData =countriesArray;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, 600);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}
-(void)fillBuyersArray{
    for (int i = 0; i<buyersInfoArr.count ; i++ ) {
        [dropitems addObject:(NSString*)[buyersInfoArr[i] valueForKey:@"First_Name__c"]];
    }
    NSLog(@"%@",kUserProfile);
//    [dropitems addObject:handleNull(kUserProfile.partyName)];
}
-(void)showpBuyersopover:(UIButton*)drop{
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = dropitems;
    
    popoverBuyers = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverBuyers.delegate = self;
    popoverBuyers.popoverContentSize=CGSizeMake(drop.frame.size.width, dropitems.count*50);
    popoverBuyers.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverBuyers presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if(popoverController){
        popoverController.delegate = nil;
        popoverController = nil;
    }
    if(popoverBuyers){
        popoverBuyers.delegate = nil;
        popoverBuyers = nil;
    }
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    
    if(popoverBuyers){
        [_buyersNewBtn setTitle:dropitems[tag] forState:UIControlStateNormal];
        _heightConstraint.constant = 5;
        _detailView.hidden = NO;
        [self fillLabelsforJointBuyer:tag];
        [popoverBuyers dismissPopoverAnimated:YES];
        
//        CGRect fram = _tableView.frame;
//        fram.size.height = headingLabels.count *50;
//        _tableView.frame = fram;
//        _scrollView.contentSize = CGSizeMake(0, fram.size.height+fram.origin.y+250);
        
        popoverBuyers.delegate = nil;
        popoverBuyers = nil;
    }
    if(popoverController){
        self.jointObj.country = str;
        [_dropDownCountriesBtn setTitle:self.jointObj.country forState:UIControlStateNormal];
        [self.tableView reloadData];
        [popoverController dismissPopoverAnimated:YES];
        popoverController.delegate = nil;
        popoverController = nil;
        [self adjustImageEdgeInsetsOfButton:_dropDownCountriesBtn];

    }
    
}


-(void)loadThirdView{
    [_scrollView setContentOffset:frame3.origin animated:YES];
    sterView.line2Animation = YES;
}
-(void)loadFirstView{
    [_scrollView setContentOffset:_firstView.frame.origin animated:YES];
    dropNew.hidden = NO;
    [sterView nolineColor];
}

//#pragma mark DropMenu Delegates
//-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
//{
//    dropMenu.title = dropitems[atIntedex];
//    _heightConstraint.constant = -50;
//    _detailView.hidden = NO;
//    [self fillLabelsforJointBuyer:atIntedex];
//
//
//}
//-(void)didShow : (KPDropMenu *)dropMenu{
//
//}
//-(void)didHide : (KPDropMenu *)dropMenu{
//
//}
//- (IBAction)selectCountryClick:(id)sender {
//}

#pragma mark TableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return headingLabels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JointBuyerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jointBuyerCell" forIndexPath:indexPath];
    cell.headingLabel.text = headingLabels[indexPath.row][@"key"];
    cell.textField.text = headingLabels[indexPath.row][@"value"];
    cell.textField.delegate = self;
    cell.textField.tfIndexPath = indexPath;
    cell.textField.tag = [headingLabels[indexPath.row][@"tag"] intValue];
    if(indexPath.row == 8){
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
    }else{
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"jadbcks");
}

-(void)fillLabelsforJointBuyer:(int)indexVal{
    
    //This condition applies only when fresh SR is Modifying
    if(!self.jointObj){
        JointBuyerObject *jobj = [[JointBuyerObject alloc]init];
        _jointObj.AccountID = @"";
//        jbView.joObj = jobj;
        self.jointObj = jobj;
        jbView1.joObj = jobj;
    }
    //This condition applies while Editing SR
    else{
//        jbView.joObj = self.jointObj;
            jbView1.joObj = self.jointObj;
    }
    
    //Showing Details for the first time edit
    if(indexVal == -1){
        [self.jointObj fillObjectWIthSerViceRequestDetail:_srdRental];
    }
    else{
        //If Edit form is available then
        NSDictionary *dict = buyersInfoArr[indexVal];
        if([dict[@"Account__c"] isEqualToString:_srdRental.AccountId]){
            [self.jointObj fillObjectWIthSerViceRequestDetail:_srdRental];
        }else{
            [self.jointObj fillObjectWithParticularBuyerDict:buyersInfoArr[indexVal]];
        }
    }
    
    //This condition For Showing Primary Buyer info
//    if(indexVal == dropitems.count-1){
//        [self.jointObj fillObjectWithPrimaryBuyerInfo];
//    }else{
//        [self.jointObj fillObjectWithParticularBuyerDict:buyersInfoArr[indexVal]];
//    }
    [self fillLabels];
}

-(void)fillLabels{
    
    [self adjustImageEdgeInsetsOfButton:_dropDownCountriesBtn];
    [_dropDownCountriesBtn setTitle:self.jointObj.country.length>0?self.jointObj.country:@"Select Country" forState:UIControlStateNormal];
    headingLabels = @[@{@"key":@"Address1",
                        @"value":handleNull(self.jointObj.address1),
                        @"tag" : [NSNumber numberWithInt:Address1J]},
                      @{@"key":@"Address2",
                        @"value":handleNull(self.jointObj.address2),
                        @"tag" : [NSNumber numberWithInt:Address2J]},
                      @{@"key":@"Address3",
                        @"value":handleNull(self.jointObj.address3),
                        @"tag" : [NSNumber numberWithInt:Address3J]},
                      @{@"key":@"Address4",
                        @"value":handleNull(self.jointObj.address4),
                        @"tag" : [NSNumber numberWithInt:Address4J]},
                      @{@"key":@"City",
                        @"value":handleNull(self.jointObj.city),
                        @"tag" : [NSNumber numberWithInt:CityJ]},
                      @{@"key":@"State",
                        @"value":handleNull(self.jointObj.state),
                        @"tag" : [NSNumber numberWithInt:StateJ]},
                      @{@"key":@"PostalCode",
                        @"value":handleNull(self.jointObj.postalCode),
                        @"tag" : [NSNumber numberWithInt:PostalCodeJ]},
                      @{@"key":@"Email",
                        @"value":handleNull(self.jointObj.email),
                        @"tag" : [NSNumber numberWithInt:EmailJ]},
                      @{@"key":@"Mobile",
                        @"value":handleNull(self.jointObj.phone),
                        @"tag" : [NSNumber numberWithInt:MobileJ]}];
    
    [_tableView reloadData];
}

#pragma mark: Textfield Delegates
-(void)textFieldDidBeginEditing:(COCDTF *)textField{
    
    currentTextFieldRef = textField;
    self.editingIndexPath = textField.tfIndexPath;
    
}
-(BOOL)textFieldShouldReturn:(COCDTF *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(COCDTF *)textField{
    [self.jointObj changeValueBasedonTag:textField withValue:textField.text];
    [self fillLabels];
    NSLog(@"%@",self.jointObj);
}


-(void)uploadImagesToServer{
    _soap= [[SaopServices alloc]init];
    _soap.delegate = self;
    if(self.jointObj.cocdImage){
        [_soap uploadDocumentTo:self.jointObj.cocdImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"COCD" fileId:@"COCD" fileName:@"COCD" registrationId:nil sourceFileName:@"COCD" sourceId:@"COCD"];
        countoFImagestoUplaod++;
    }
    _soap2 = [[SaopServices alloc]init];
    _soap2.delegate = self;
    if(self.jointObj.additionalDocumentImage){
        NSString *str = @"AdditionalDoc";
        [_soap2 uploadDocumentTo:self.jointObj.additionalDocumentImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    _soap3 = [[SaopServices alloc]init];
    _soap3.delegate = self;
    if(self.jointObj.primaryPassportImage){
        NSString *str = @"PassportOfBuyer";
        [_soap3 uploadDocumentTo:self.jointObj.primaryPassportImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
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
        self.jointObj.UploadSignedChangeofDetails = path;
    }
    
    if ([path rangeOfString:@"AdditionalDoc"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        self.jointObj.AdditionalDocFileUrl = path;
    }
    
    if ([path rangeOfString:@"PassportOfBuyer"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        self.jointObj.PassportFileUrl = path;
    }
    
    if(countoFImagestoUplaod == countoFImagesUploaded){
        
        [self.jointObj sendJointBuyerResponsetoserver];
    }
}
-(void)subJointBuyersResponse{
    
    if(self.jointObj.cocdImage == nil){
        [FTIndicator showToastMessage:@"COCD document is not attached"];
    }else{
        self.jointObj.status = @"Submitted";
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
        [self uploadImagesToServer];
    }
    
}
-(void)saveDraftJointBuyers{
    
    if([self validationSetForJointBuyer]){
        self.jointObj.status = @"Draft Request";
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
        
        if(self.jointObj.cocdImage||self.jointObj.additionalDocumentImage||self.jointObj.primaryPassportImage){
            [self subJointBuyersResponse];
        }else{
            [self.jointObj sendJointBuyerResponsetoserver];
        }
    }
}

- (IBAction)saveDraftCLickView:(id)sender {
    
    [currentTextFieldRef resignFirstResponder];
    [self saveDraftJointBuyers];
}
- (IBAction)buyersNewDropDownClick:(id)sender {
    [self showpBuyersopover:(UIButton*)sender];
}


#pragma Mark Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height)+100, 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width)+100, 0.0);
    }
    
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
//        [self.tableView scrollToRowAtIndexPath:self.editingIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
    
    
}
-(void)enableViewsAfterDownloadForm{
    jbView1.previous1height.constant = 0;
    jbView1.previousBtn.hidden = YES;
    jbView1.bottomButtomsView.hidden = NO;
    jbView1.uploadsView.hidden = NO;
    jbView1.downloadImage.highlighted = YES;
    jbView1.downloadText.text = @"Download\nCompleted";
}

-(void)downloadFormDetails{
    
    [self enableViewsAfterDownloadForm];
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    NSDictionary * dict = @{
                            @"buyersInfoWrapper":
                                @{
                                    @"AccountID":_jointObj.AccountID,
                                    @"city":handleNull(_jointObj.city),
                                    @"country":handleNull(_jointObj.country),
                                    @"phone":handleNull(_jointObj.phone),
                                    @"state":handleNull(_jointObj.state),
                                    @"postalCode":handleNull(_jointObj.postalCode),
                                    @"email":handleNull(_jointObj.email),
                                    @"mobileCountryCode":handleNull(_jointObj.mobileCountryCode),
                                    @"address1":handleNull(_jointObj.address1),
                                    @"address2":handleNull(_jointObj.address2),
                                    @"address3":handleNull(_jointObj.address3),
                                    @"address4":handleNull(_jointObj.address4),
                                    }
                            };
    
    ServerAPIManager *srvr = [ServerAPIManager sharedinstance];
    [srvr postRequestwithUrl:downloadFormUrl withParameters:dict successBlock:^(id responseObj) {
        if(responseObj){
            //            NSString *str = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            
            NSString *str = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            [self openReceiptinSafari:[str stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [FTIndicator showToastMessage:error.localizedDescription];
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
    }];
}

-(void)openReceiptinSafari:(NSString*)url{
    dispatch_async(dispatch_get_main_queue(), ^{
        [FTIndicator dismissProgress];
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
        }
    });
}


-(BOOL)validationSetForJointBuyer{
    
    if(isEmpty(_jointObj.AccountID)){
        [FTIndicator showToastMessage:@"Please Select Buyer"];
        return NO;
    }
    if(isEmpty(_jointObj.country)){
        [FTIndicator showToastMessage:@"Please enter Country"];
        return NO;
    }
    if(isEmpty(_jointObj.city)){
        [FTIndicator showToastMessage:@"Please enter City"];
        return NO;
    }
    if(isEmpty(_jointObj.state)){
        [FTIndicator showToastMessage:@"Please enter State"];
        return NO;
    }
    if(isEmpty(_jointObj.postalCode)){
        [FTIndicator showToastMessage:@"Please enter postal code"];
        return NO;
    }
    if(![_jointObj.email validateEmailWithString]){
        [FTIndicator showToastMessage:@"Please enter valid e-mail"];
        return NO;
    }
    if(![_jointObj.phone validatewithPhoneNumber]){
        [FTIndicator showToastMessage:@"Please enter valid phone Number"];
    return NO;
    }

    return YES;
}
@end
