//
//  ProofOfPaymentNewVC.m
//  DamacC
//
//  Created by Gaian on 05/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ProofOfPaymentNewVC.h"
#import "POPTableCell.h"

#define bottomPaddingSpace 10.0
#define textFieldTag 10000

@interface ProofOfPaymentNewVC ()

@end

@implementation ProofOfPaymentNewVC{
    
    NSMutableArray *unitsDropDown;
    int unitsIndex;
    NSArray *unitsSFIdsArray;
    WYPopoverController* unitsPopoverController;
    
    
    WYPopoverController* paymentsPopoverController;
    
    NSArray *tvItems;
    WSCalendarView *calendarView;
    NSArray *dropItems;
    NSMutableArray *eventArray;
    UIView *superView;
    UITextField *textF;
    CGRect tableViewRect,contentviewRect;
    NSMutableDictionary *dictionaryTf;
    NSString *paymentMode;
    NSString *paymentDate;
    
    
    CameraView *camView;
    int countoFImagestoUplaod,countoFImagesUploaded;
    int clickedImage;
    BOOL attachingDocumentsBool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    attachingDocumentsBool = NO;
    // Do any additional setup after loading the view.
    [self hideAttachmentsView:YES];
    [self webServicetoGetUnitSFIds];
    unitsDropDown = [[NSMutableArray alloc]init];
    for (ResponseLine *res in [DamacSharedClass sharedInstance].unitsArray) {
        [unitsDropDown addObject:res.unitNumber];
    }
    unitsIndex = 0 ;
    _popObj = [[popObject alloc]init];
    dropItems = @[@"Bank Transfer",@"Cash",@"Cheque",@"Credit Card"];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    tvItems = @[@"Payment Date*",@"Payment Allocation remarks",@"Total Amount*",@"Sender Name",@"Bank Name",@"Swift Code"];
    [self setCalendarInit];
    superView= DamacSharedClass.sharedInstance.currentVC.view;
    tableViewRect = _tableView.frame;
    contentviewRect = self.tableView.frame;
    dictionaryTf = [[NSMutableDictionary alloc]init];
    

    
    CGRect fra = [UIScreen mainScreen].bounds;
    camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:[DamacSharedClass sharedInstance].currentVC];
    [self.view addSubview:camView];
    camView.delegate = self;
    countoFImagestoUplaod =0 ;
    countoFImagesUploaded = 0;
    clickedImage = 0;
    
    
    [self roundCorners:_buttonSubmit];
    [self roundCorners:_getUnitsButtonDetail];
    [self roundCorners:_buttonDocument];
//    [self roundCorners:_attach1Btn];
//    [self roundCorners:_attach2Btn];

}
-(void)roundCorners:(UIButton*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = goldColor.CGColor;
    sender.layer.borderWidth = 2.0f;
    sender.clipsToBounds = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Proof of payment"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)adjustImageEdgeInsetsOfButton:(UIButton*)sender{
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-30-sender.titleLabel.intrinsicContentSize.width, 0, 0);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self contentViewScroll];
    [self adjustImageEdgeInsetsOfButton:_buttonUnits];
    [self adjustImageEdgeInsetsOfButton:_selectPaymentModeBtn];
    [self adjustImageEdgeInsetsOfButton:_attach1Btn];
    [self adjustImageEdgeInsetsOfButton:_attach2Btn];
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}

-(void)webServicetoGetUnitSFIds{
    ServerAPIManager *serverAPI = [ServerAPIManager sharedinstance];
    [serverAPI postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            unitsSFIdsArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        }
    }  errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];

}
-(void)hideAttachmentsView:(BOOL)bo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(bo){
            _attachDocsBaseView.hidden =YES;
            _attachDocsViewHeighgt.constant = 0;
        }else{
            _attachDocsBaseView.hidden =NO;
            _attachDocsViewHeighgt.constant = 104;
        }
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width,_buttonSubmit.frame.origin.y+_attachDocsViewHeighgt.constant+40+20);
    });
    
}


-(void)setCalendarInit{
    
    calendarView = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    //calendarView.dayColor=[UIColor blackColor];
    //calendarView.weekDayNameColor=[UIColor purpleColor];
    //calendarView.barDateColor=[UIColor purpleColor];
    //calendarView.todayBackgroundColor=[UIColor blackColor];
    calendarView.tappedDayBackgroundColor=[UIColor blackColor];
    calendarView.calendarStyle = WSCalendarStyleDialog;
    calendarView.isShowEvent=false;
    [calendarView setupAppearance];
    [self.view addSubview:calendarView];
    calendarView.delegate=self;
    
    //    calendarViewEvent = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    //    calendarViewEvent.calendarStyle = WSCalendarStyleView;
    //    calendarViewEvent.isShowEvent=true;
    //    calendarViewEvent.tappedDayBackgroundColor=[UIColor blackColor];
    ////    calendarViewEvent.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    //    calendarViewEvent.frame = CGRectMake(0,0 , self.view.frame.size.width-10, self.view.frame.size.height/3);
    //    calendarViewEvent.center = self.baseView.center;
    //    [calendarViewEvent setupAppearance];
    //    calendarViewEvent.delegate=self;
    //    [self.baseView addSubview:calendarViewEvent];
    
    
    eventArray=[[NSMutableArray alloc] init];
    NSDate *lastDate;
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    for (int i=0; i<10; i++) {
        
        if (!lastDate) {
            lastDate=[NSDate date];
        }
        else{
            [dateComponent setDay:1];
        }
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:lastDate options:0];
        lastDate=datein;
        [eventArray addObject:datein];
    }
    //    [calendarViewEvent reloadCalendar];
    
    NSLog(@"%@",[eventArray description]);
}

- (IBAction)UnitsClick:(id)sender{
    [self showpopoverUnits:_buttonUnits];
}

-(void)showpopoverUnits:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = unitsDropDown;
    unitsPopoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    unitsPopoverController.delegate = self;
    unitsPopoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, unitsDropDown.count*44);
    unitsPopoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [unitsPopoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

-(void)showpaymentList:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = dropItems;
    paymentsPopoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    paymentsPopoverController.delegate = self;
    paymentsPopoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, dropItems.count*50);
    paymentsPopoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [paymentsPopoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectPaymentClick:(id)sender {
    [self showpaymentList:_selectPaymentModeBtn];
}

- (IBAction)getUnitsDetailClick:(id)sender{
    
    DetailMyUnitsViewController *dm = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"detailMyUnitsVC"];
    if(DamacSharedClass.sharedInstance.unitsArray.count>0){
        ResponseLine *responseUnit = DamacSharedClass.sharedInstance.unitsArray[unitsIndex];
        dm.responseUnit = responseUnit;
        [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:dm animated:YES];
    }
}



#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if(unitsPopoverController){
        unitsPopoverController.delegate = nil;
        unitsPopoverController = nil;
    }
    if(paymentsPopoverController){
        unitsPopoverController.delegate = nil;
        unitsPopoverController = nil;
    }
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    [self.tableView reloadData];
    if(unitsPopoverController)
    {
        [_buttonUnits setTitle:unitsDropDown[tag] forState:UIControlStateNormal];
        unitsIndex = tag;
        _popObj.selectedUnit = [DamacSharedClass sharedInstance].unitsArray[tag];
        _popObj.AccountID = unitsSFIdsArray[tag][@"Booking__c"];
        NSLog(@"ID Selected");
        
        [unitsPopoverController dismissPopoverAnimated:YES];
        unitsPopoverController.delegate = nil;
        unitsPopoverController = nil;
        [self adjustImageEdgeInsetsOfButton:_buttonUnits];
    }
    if(paymentsPopoverController)
    {
        [_selectPaymentModeBtn setTitle:dropItems[tag] forState:UIControlStateNormal];
        paymentMode = dropItems[tag];
        [paymentsPopoverController dismissPopoverAnimated:YES];
        [_selectPaymentModeBtn setTitle:str forState:UIControlStateNormal];
        paymentsPopoverController.delegate = nil;
        paymentsPopoverController = nil;
        [self adjustImageEdgeInsetsOfButton:_selectPaymentModeBtn];
    }
    
    
    //    self.passportObj.AccountID = buyersInfoArr[tag][@"Id"];

    
    
}

#pragma mark TvDelegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    POPTableCell *cell = (POPTableCell*)[tableView dequeueReusableCellWithIdentifier:@"pOPTableCell" forIndexPath:indexPath];
    cell.popTF.placeholder = tvItems[indexPath.row];
    cell.popTF.tag =  indexPath.row+textFieldTag;
    cell.popTF.delegate = self;
    [cell.popTF setValue:rgb(191, 154, 88) forKeyPath:@"_placeholderLabel.textColor"];
    if(indexPath.row == 0){
        cell.buttonTop.hidden = NO;
        [cell.buttonTop addTarget:self action:@selector(activateCalen) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.buttonTop.hidden = YES;
    }
    
    if(indexPath.row == 2){
        cell.popTF.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        cell.popTF.keyboardType = UIKeyboardTypeDefault;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tvItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)activateCalen{
    [calendarView ActiveCalendar:superView];
}


#pragma mark WSCalendarViewDelegate
-(NSArray *)setupEventForDate{
    return eventArray;
}

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate{
    
}
-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSDateFormatter *todaysDate = [[NSDateFormatter alloc]init];
    //    [todaysDate setDateFormat:@"dd MMM yyyy"];
    NSDate *tdaysDate = [NSDate date];
    NSComparisonResult result = [tdaysDate compare:selectedDate];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
    NSLog(@"%ld",(long)result);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:(NSWeekOfYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitWeekday) fromDate:selectedDate];
    
    if(result == NSOrderedAscending ){
        [FTIndicator showToastMessage:@"Selected Date Cannot be future dated"];
        [calendarView ActiveCalendar:superView];
    }else{
        paymentDate = str;
        UITextField *tf = [_tableView viewWithTag:textFieldTag];
        tf.text = str;
    }
    
}

#pragma mark TextField Delegates
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self changetoNextField:textField];
    textF = textField;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    return NO; // We do not want UITextField to insert line-breaks.
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0){
        [dictionaryTf setValue:textField.text forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textField.tag]]];
    }
}


-(void)changetoNextField:(UITextField*)tf{
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnClick)];
    
    
    keyboardToolbar.items = @[flexBarButton, nextBarButton];
    tf.inputAccessoryView = keyboardToolbar;
    
}


-(void)nextBtnClick{
    if(textF){
        [textF resignFirstResponder];
    }
    UITextField *nextTxtField=(UITextField*)[self.tableView viewWithTag:textF.tag+1];
    if(nextTxtField){
        [nextTxtField becomeFirstResponder];
    }
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


- (IBAction)uploadProofClick1:(id)sender {
    [camView frameChangeCameraView];
    clickedImage =100;
}
- (IBAction)uploadProofClick2:(id)sender {
    [camView frameChangeCameraView];
    clickedImage =200;
}


-(void)imagePickerSelectedImage:(UIImage *)image{
    if(image&&clickedImage ==100){
        _uploadDocLabel.text = @"cahceJPEG1.jpg";
        _popObj.popImage = image;
    }
    if(image&&clickedImage ==200){
        _otherDocLAbel.text = @"cahceJPEG2.jpg";
        _popObj.otherImage = image;
    }
}

-(void)uploadAttachments{
    countoFImagestoUplaod = 0;
    attachingDocumentsBool = YES;
    _soap = [[SaopServices alloc]init];
    _soap.delegate = self;
    if(_popObj.popImage){
        [_soap uploadDocumentTo:_popObj.popImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"POP" fileId:@"POP" fileName:@"POP" registrationId:nil sourceFileName:@"POP" sourceId:@"POP"];
        countoFImagestoUplaod++;
    }
    _soap2 = [[SaopServices alloc]init];
    _soap2.delegate = self;
    if(_popObj.otherImage){
        NSString *str = @"POP1";
        [_soap2 uploadDocumentTo:_popObj.otherImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    
}


-(void)uploadImagesToServer{
    
    attachingDocumentsBool = NO;
    countoFImagestoUplaod = 0;
    _soap = [[SaopServices alloc]init];
    _soap.delegate = self;
    if(_popObj.popImage){
        [_soap uploadDocumentTo:_popObj.popImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"POP" fileId:@"POP" fileName:@"POP" registrationId:nil sourceFileName:@"POP" sourceId:@"POP"];
        countoFImagestoUplaod++;
    }
    _soap2 = [[SaopServices alloc]init];
    _soap2.delegate = self;
    if(_popObj.otherImage){
        NSString *str = @"POP1";
        [_soap2 uploadDocumentTo:_popObj.otherImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    
    if(countoFImagestoUplaod == 0){
        [_popObj subMitPOPfromServicesSRDetails];
    }
}


#pragma mark Soap Image uploaded Delegate

-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    
    if(attachingDocumentsBool){
        
        if ([path rangeOfString:@"POP"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            _popObj.popImagePath = path;
            [_attach1Btn setTitle:path forState:UIControlStateNormal];
            
        }
        
        if ([path rangeOfString:@"POP1"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            _popObj.otherImagePath = path;
            [_attach2Btn setTitle:path forState:UIControlStateNormal];
        }
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [self hideAttachmentsView:NO];
    }else{
        
        countoFImagesUploaded ++;
        
        if ([path rangeOfString:@"POP"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            _popObj.popImagePath = path;
            
        }
        
        if ([path rangeOfString:@"POP1"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            _popObj.otherImagePath = path;
        }
        
        if(countoFImagestoUplaod == countoFImagesUploaded){
            [_popObj subMitPOPfromServicesSRDetails];
        }
    
    }
}



- (IBAction)submitClick:(id)sender {
    
    [textF endEditing:YES];
    
    if(paymentDate.length<1){
        [FTIndicator showToastMessage:@"please select payment date"];
        return;
    }
    NSString *amount = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+2]]];
    if(amount.length <= 1){
        [FTIndicator showToastMessage:@"Amount field should not be empty"];
        return;
    }
    NSString *senderName = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+3]]];
    if(senderName.length<1){
        [FTIndicator showToastMessage:@"please enter sender name"];
        return;
    }
    if(paymentDate.length<1){
        [FTIndicator showToastMessage:@"please select payment date"];
        return;
    }
    NSString *bankName = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+4]]];
    if(bankName.length<1){
        [FTIndicator showToastMessage:@"please enter bank name"];
        return;
    }
    NSString *swiftCode = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+5]]];
    if(swiftCode.length<1){
        [FTIndicator showToastMessage:@"please bank swift code"];
        return;
    }
    _popObj.Totalamount = amount;
    _popObj.PaymentMode = paymentMode;
    _popObj.PARemark = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+1]]];
    _popObj.PaymentDate = paymentDate;
    _popObj.SenderName = senderName;
    _popObj.BankName = bankName;
    _popObj.SwiftCode = swiftCode;
    
    
    if(_popObj.popImage == nil){
        [FTIndicator showToastMessage:@"Proof Document not attached"];
    }else{
        
        _popObj.status = @"Submitted";
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
        [self uploadImagesToServer];
    }
}

- (IBAction)atatchDocClick:(id)sender {
    
    if(_popObj.popImage||_popObj.otherImage){
        [FTIndicator showProgressWithMessage:@"Please wait"];
        [self uploadAttachments];
    }else{
        [FTIndicator showToastMessage:@"Please select Attachment"];
    }
    
    
}
-(void)contentViewScroll{
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _buttonSubmit.frame.origin.y+60);
    
}

- (IBAction)attach1Click:(id)sender {
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_attach1Btn.currentTitle]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_attach1Btn.currentTitle] options:nil completionHandler:nil];
    }
}

- (IBAction)attach2Click:(id)sender {
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_attach2Btn.currentTitle]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_attach2Btn.currentTitle] options:nil completionHandler:nil];
    }
}

@end
