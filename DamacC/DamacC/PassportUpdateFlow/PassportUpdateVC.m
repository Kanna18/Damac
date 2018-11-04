//
//  PassportUpdateVC.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportUpdateVC.h"
#import "PassportCell1.h"
#import "PassportCell2.h"
#import "PassportCell3.h"
#import "PassportHeader.h"
#import "PassportFooter.h"
#import "PassportObject.h"

@interface PassportUpdateVC ()<UITableViewDelegate,UITableViewDataSource,WYPopoverControllerDelegate,POPDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseSuperView;

@end

@implementation PassportUpdateVC{
    
     CGFloat heightTV,numberOfCells,sections;
    CGFloat sec1,sec2,sec3;
    NSArray *sectionHeaders;
    NSArray *dropItems;
    WYPopoverController* popoverController;
    ServerAPIManager *serverAPI;
    NSMutableArray *buyersInfoArr,*dropitems;
    
    NSArray *tvDataValues;
    int countoFImagestoUplaod,countoFImagesUploaded;
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    COCDTF *dateTFref;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    sec1 = 0;
    sec2 = 0;
    sec3 = 0;
    sectionHeaders = @[@"Existing Details",@"New Details",@"Upload Documents"];
    serverAPI = [ServerAPIManager sharedinstance];
    buyersInfoArr = [[NSMutableArray alloc]init];
    dropitems = [[NSMutableArray alloc]init];
//    [self dropMenun];
    self.view.clipsToBounds = NO;
    [self webServicetoGetUnitSFIds];
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    tvDataValues = @[@{@"key":@"Passport Number/CR Number",
                       @"value":self.passportObj.previousPPNumber,
                       @"newValue":self.passportObj.passportNo},
                     @{@"key":@"Passport Issue Place/City of Incorporation",
                       @"value":self.passportObj.previousPassPlace,
                       @"newValue":self.passportObj.PassportIssuedPlace},
                     @{@"key":@"Passport/CR Expiry Date",
                       @"value":self.passportObj.previousExpiryDate,
                       @"newValue":self.passportObj.PassportIssuedDate}];
    
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    countoFImagestoUplaod = 0 ;
    countoFImagesUploaded = 0 ;
    
    _tableView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webServicetoGetUnitSFIds{
    
    [serverAPI postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSArray *idsArr = [arr valueForKey:@"Booking__c"];
            [self getBuyersInfoBasedonUnitIDS:idsArr];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(void)setCalendarInit{
    
    calendarView = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarView.tappedDayBackgroundColor=[UIColor blackColor];
    calendarView.calendarStyle = WSCalendarStyleDialog;
    calendarView.isShowEvent=false;
    [calendarView setupAppearance];
    [self.view addSubview:calendarView];
    calendarView.delegate=self;
    
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
    [calendarViewEvent reloadCalendar];
    
    NSLog(@"%@",[eventArray description]);
}

#pragma mark WSCalendarViewDelegate

-(NSArray *)setupEventForDate{
    return eventArray;
}

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    
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
    
    if(result == -1 ){
        dateTFref.text =str;
    }
//    else if(dateComponent.weekday == 6 || dateComponent.weekday == 7){
//        [FTIndicator showErrorWithMessage:@"Friday and Saturday are weekoff"];
//        [calendarView ActiveCalendar:self.view];
//    }
    else{
        [FTIndicator showErrorWithMessage:@"Selected date should be future date"];
        [calendarView ActiveCalendar:self.view];
    }
    self.passportObj.PassportIssuedDate = str;
    
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
                    for (int i = 0; i<buyersInfoArr.count ; i++ ) {
                        [dropitems addObject:(NSString*)[buyersInfoArr[i] valueForKey:@"First_Name__c"]];
                    }
                    [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                }
                Count++;
            }
        } errorBlock:^(NSError *error) {
        }];
    }
}

-(void)showpopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = dropitems;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, 100);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

//-(void)dropMenun{
//
//    dropItems = @[@"Existing Details",@"New Details",@"Upload Documents"];
//    _dropBaseView.backgroundColor = [UIColor clearColor];
//    _dropBaseView.layer.cornerRadius = 10.0f;
//    _dropBaseView.layer.borderColor = [UIColor yellowColor].CGColor;
//    _dropBaseView.layer.borderWidth = 1.0f;
//    _dropBaseView.backgroundColor = [UIColor clearColor];
//    _dropBaseView.delegate = self;
//    _dropBaseView.items = dropItems;
//    _dropBaseView.title = dropItems[0];
//    _dropBaseView.titleColor = goldColor;
//    _dropBaseView.titleTextAlignment = NSTextAlignmentLeft;
//    _dropBaseView.DirectionDown = YES;
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sectionHeaders.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
            PassportCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"passportCell1" forIndexPath:indexPath];
        cell1.topLabel.text =tvDataValues[indexPath.row][@"key"];
        cell1.textField.text = tvDataValues[indexPath.row][@"value"];
        cell1.textField.userInteractionEnabled = NO;
        cell1.textField.tfIndexPath = indexPath;
        return cell1;
    }
    if (indexPath.section == 1){
            PassportCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"passportCell2" forIndexPath:indexPath];
        cell2.topLabel.text =tvDataValues[indexPath.row][@"key"];
        cell2.textField.text = tvDataValues[indexPath.row][@"newValue"];
        NSLog(@"%@---%@",tvDataValues[indexPath.row][@"newValue"],_passportObj);
        cell2.textField.tag = 1000+indexPath.row;
        cell2.textField.delegate = self;
        cell2.textField.tfIndexPath = indexPath;
        return cell2;
    }
    if (indexPath.section == 2){
            PassportCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"passportCell3" forIndexPath:indexPath];
        cell3.passObj = self.passportObj;
            return cell3;
    }
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 2:
            return 172;
            break;
    }
    return 60;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return sec1;
            break;
        case 1:
            return sec2;
            break;
        case 2:
            return sec3;
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 2:
            return 60;
            break;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    PassportCellHeader *headerCell = [tableView dequeueReusableCellWithIdentifier:@"passportCellHeader"];
//
//    if (headerCell ==nil)
//    {
//        [_tableView registerClass:[PassportCellHeader class] forCellReuseIdentifier:@"passportCellHeader"];
//        headerCell = [tableView dequeueReusableCellWithIdentifier:@"passportCellHeader"];
//    }
//    headerCell.headerButton.tag = section;
//    [headerCell.headerButton addTarget:self action:@selector(tappedOnSection:) forControlEvents:UIControlEventTouchUpInside];
//    headerCell.headerTitle.text = sectionHeaders[section];
    
    PassportHeader *headerView = [[PassportHeader alloc]initWithFrame:CGRectZero];
    headerView.headerLabel.text = sectionHeaders[section];
    headerView.headerButton.tag = section;
    [headerView.headerButton addTarget:self action:@selector(tappedOnSection:) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

-(void)tappedOnSection:(UIButton *)sender{
    
    CGFloat customSec;
    switch (sender.tag) {
        case 0:
            sec1 = sec1 ==  3 ? 0 : 3;
            customSec =sec1;
            break;
        case 1:
            sec2 = sec2 ==  3 ? 0 : 3;
            customSec =sec2;
            break;
        case 2:
            sec3 = sec3 ==  1 ? 0 : 1;
            customSec =sec3;
            break;
            
        default:
            break;
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.tag];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
//    [_tableView reloadData];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    PassportCellFooter *footer = [tableView dequeueReusableCellWithIdentifier:@"passportCellFooter"];
    if(section == 2){
        PassportFooter *footer = [[PassportFooter alloc]initWithFrame:CGRectZero];
        [footer.saveDraftButton addTarget:self action:@selector(saveDraftClickPassport) forControlEvents:UIControlEventTouchUpInside];
        [footer.submitbutton addTarget:self action:@selector(submitbuttonClickPassport) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }else{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    [self.view bringSubviewToFront:_baseSuperView];
    [_baseSuperView setNeedsDisplay];
    [self setCalendarInit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)saveDraftClickPassport{
    self.passportObj.status = @"Draft Request";
    [self responsePassport];
}

-(void)responsePassport{
        
    if(self.passportObj.AccountID.length<1){
        [FTIndicator showToastMessage:@"Please Select Buyer"];
        return;
    }
    if(self.passportObj.passportNo.length<1){
        [FTIndicator showToastMessage:@"Passport No should not be empty"];
        return;
    }
    if(self.passportObj.PassportIssuedPlace.length<1){
        [FTIndicator showToastMessage:@"Passport Issued place should not be empty"];
        return;
    }
    
    if(self.passportObj.passportImage == nil&&[self.passportObj.status isEqualToString:@"Submitted"]){
        [FTIndicator showToastMessage:@"Passport of Primary buyer is not attached"];
        return;
    }
    [self uploadImagesToServer];
}



-(void)submitbuttonClickPassport{
    self.passportObj.status = @"Submitted";
    [self responsePassport];
    
}
#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    _dropBaseView.title = dropItems[atIntedex];
    
    
}

-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}


- (IBAction)buyersClick:(id)sender {
    [self showpopover:(UIButton*)sender];
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
    [self.tableView reloadData];
    [popoverController dismissPopoverAnimated:YES];
    [_buyersButton setTitle:str forState:UIControlStateNormal];
//    self.passportObj.AccountID = buyersInfoArr[tag][@"Id"];
    [_passportObj fillDefaultValuesForParticularBuyer:buyersInfoArr[tag]];
    
    tvDataValues = @[@{@"key":@"Passport Number/CR Number",
                       @"value":self.passportObj.previousPPNumber,
                       @"newValue":self.passportObj.passportNo},
                     @{@"key":@"Passport Issue Place/City of Incorporation",
                       @"value":self.passportObj.previousPassPlace,
                       @"newValue":self.passportObj.PassportIssuedPlace},
                     @{@"key":@"Passport/CR Expiry Date",
                       @"value":self.passportObj.previousExpiryDate,
                       @"newValue":self.passportObj.PassportIssuedDate}];
    [self.tableView reloadData];
    
}

-(void)tvDataHeadigLabel{
    
}

#pragma mark TextFieldDelegates

-(void)textFieldDidBeginEditing:(COCDTF *)textField{
    if(textField.tag == 1002){
        [[UIApplication sharedApplication] resignFirstResponder];
        [calendarView ActiveCalendar:self.view];
        dateTFref = textField;
    }
    self.editingIndexPath = textField.tfIndexPath;
}
-(BOOL)textFieldShouldReturn:(COCDTF *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(COCDTF *)textField{
    [self SetValuesbasedonTag:textField];
    [textField resignFirstResponder];
}


-(void)SetValuesbasedonTag:(COCDTF*)tf{
    
    
    if(tf.tag == 1000){
        self.passportObj.passportNo = tf.text;
    }
    if(tf.tag == 1001){
        self.passportObj.PassportIssuedPlace = tf.text;
    }
    if(tf.tag == 1002){
        self.passportObj.PassportIssuedDate = tf.text;
    }
    
    tvDataValues = @[@{@"key":@"Passport Number/CR Number",
                       @"value":self.passportObj.previousPPNumber,
                       @"newValue":self.passportObj.passportNo},
                     @{@"key":@"Passport Issue Place/City of Incorporation",
                       @"value":self.passportObj.previousPassPlace,
                       @"newValue":self.passportObj.PassportIssuedPlace},
                     @{@"key":@"Passport/CR Expiry Date",
                       @"value":self.passportObj.previousExpiryDate,
                       @"newValue":self.passportObj.PassportIssuedDate}];
    [_tableView reloadData];
}


-(void)uploadImagesToServer{
    
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    _soap= [[SaopServices alloc]init];
    _soap.delegate = self;
    if(self.passportObj.passportImage){
        [_soap uploadDocumentTo:self.passportObj.passportImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"NewPassport" fileId:@"NewPassport" fileName:@"NewPassport" registrationId:nil sourceFileName:@"NewPassport" sourceId:@"NewPassport"];
        countoFImagestoUplaod++;
    }
    _soap2 = [[SaopServices alloc]init];
    _soap2.delegate = self;
    if(self.passportObj.additionalImage){
        NSString *str = @"AdditionalDoc";
        [_soap2 uploadDocumentTo:self.passportObj.additionalImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    
    if(countoFImagestoUplaod==0){//If there are noImages To upload while saving
        
        [self.passportObj sendPassportResponsetoServer];
    }

}


-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    countoFImagesUploaded ++;
    
    if ([path rangeOfString:@"NewPassport"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        self.passportObj.passportImagePath = path;
    }
    
    if ([path rangeOfString:@"AdditionalDoc"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        self.passportObj.additionalImagePath = path;
    }

    if(countoFImagestoUplaod == countoFImagesUploaded){
        
        [self.passportObj sendPassportResponsetoServer];
    }
}




#pragma Mark Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
        [self.tableView scrollToRowAtIndexPath:self.editingIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    if(dateTFref.tag == 1002){
        [dateTFref resignFirstResponder];
    }
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.tableView.contentInset = UIEdgeInsetsZero;
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
    
    
}
@end
