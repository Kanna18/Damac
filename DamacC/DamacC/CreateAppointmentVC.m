//
//  CreateAppointmentVC.m
//  DamacC
//
//  Created by Gaian on 25/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CreateAppointmentVC.h"
#import "AppointmentsSlotsViewController.h"

@interface CreateAppointmentVC ()<WYPopoverControllerDelegate,POPDelegate>

@end

@implementation CreateAppointmentVC{
    
    NSArray *pusrposeArray, *subPurposeArray,*dtarr,*unitsArray,*slotsArray,*unitsWholeArray;
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    WYPopoverController* popoverPurpose;
    WYPopoverController* popoverSubPurpose;
    WYPopoverController* popoverUnit;
    BOOL validationBool;
    
    int selectedUnitTag;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    slotsArray = @[@"09:00 - 10:00",
//                   @"10:00 - 11:00",
//                   @"11:00 - 12:00",
//                   @"12:00 - 13:00",
//                   @"13:00 - 14:00",
//                   @"14:00 - 15:00",
//                   @"15:00 - 16:00",
//                   @"16:00 - 17:00",
//                   @"17:00 - 18:00"];
    [self loadingDropDownsList];
    _appointObj = [[AppointmentObject alloc]init];
    [FTIndicator showProgressWithMessage:@"Loading please wait" userInteractionEnable:NO];
    [self webServicetoGetUnitSFIds];
    selectedUnitTag = -1;
    
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"Book an Appointment - Start"],
                                     kFIRParameterItemName:@"Book an Appointment - Start",
                                     kFIRParameterContentType:@"Button Clicks"
                                     }];

}
-(void)webServicetoGetUnitSFIds{
    ServerAPIManager *serverAPI = [ServerAPIManager sharedinstance];
    [serverAPI postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            unitsWholeArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            unitsArray = [unitsWholeArray valueForKey:@"Unit_Name__c"];
            [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        }
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
    
    [self adjustImageEdgeInsetsOfButton:_selectPurposeBtn];
    [self adjustImageEdgeInsetsOfButton:_selectSubPurposeBtn];
    [self adjustImageEdgeInsetsOfButton:_selectUnitBtn];
    [self adjustImageEdgeInsetsOfButton:_calendarBtn];
}

-(void)loadingDropDownsList{
    
    dtarr = [self JSONFromFile:@"Appointments"];
    pusrposeArray = [dtarr valueForKey:@"key"];
    subPurposeArray = [dtarr[0] valueForKey:@"value"];
//    [self dropMenu];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
//    [self setCalendarInit];
    [self roundCorners:_selectUnitBtn];
    [self roundCorners:_selectPurposeBtn];
    [self roundCorners:_selectSubPurposeBtn];
    
    if(isEmpty(_appointObj.AppointmentDate)){
        [_calendarBtn setTitle:@"Select Appointment slot" forState:UIControlStateNormal];
    }else{
        [_calendarBtn setTitle:_appointObj.AppointmentDate forState:UIControlStateNormal];
    }
    if(isEmpty(_appointObj.TimeSlot)){
        _slotLabel.text = @"Select Slot";
    }else{
        _slotLabel.text = _appointObj.TimeSlot;
    }
    [self adjustImageEdgeInsetsOfButton:_selectPurposeBtn];
    [self adjustImageEdgeInsetsOfButton:_selectSubPurposeBtn];
    [self adjustImageEdgeInsetsOfButton:_selectUnitBtn];
    [self adjustImageEdgeInsetsOfButton:_calendarBtn];
}

-(void)adjustImageEdgeInsetsOfButton:(UIButton*)sender{
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-30-sender.titleLabel.intrinsicContentSize.width, 0, 0);
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
//    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.layer.borderWidth = 2.0f;
    sender.clipsToBounds = YES;
    
}
#pragma mark: PopOver allocation
-(void)showpopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData =pusrposeArray;
    popoverPurpose = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverPurpose.delegate = self;
    popoverPurpose.popoverContentSize=CGSizeMake(drop.frame.size.width, pusrposeArray.count*50);
    popoverPurpose.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverPurpose presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}
-(void)showSubpopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
        popVC.tvData =subPurposeArray;
    popoverSubPurpose = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverSubPurpose.delegate = self;
    popoverSubPurpose.popoverContentSize=CGSizeMake(drop.frame.size.width, subPurposeArray.count*50);
    popoverSubPurpose.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverSubPurpose presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

-(BOOL)handOverNotificationsValidation:(int)indexofUnit{
    
    if([_appointObj.ServiceType isEqualToString:@"01-Handover"]&&([_appointObj.SubProcessName isEqualToString:@"Key Handover"]||[_appointObj.SubProcessName isEqualToString:@"Unit Viewing"]||[_appointObj.SubProcessName isEqualToString:@"Documentation"])){
        
        NSDictionary *dict = unitsWholeArray[indexofUnit];
        
        NSNumber* boolean1 = dict[@"Early_Handover__c"];
        NSNumber* boolean2 = dict[@"Handover_Flag__c"];
        NSNumber* boolean3 = dict[@"Handover_Notice_Sent__c"];
                      
        if(boolean1.boolValue||boolean2.boolValue){
              [FTIndicator showToastMessage:@"Unit already handed over"];
              return NO;
          }
        else if(boolean3.boolValue){
            [FTIndicator showToastMessage:@"No handover notice available"];
            return NO;
            }
        else{
              return YES;
          }
//        Early_Handover__c
//        Handover_Flag__c
//        Handover_Notice_Sent__c
    }
    return NO;
}
-(void)showUnitspopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData =unitsArray;
    popoverUnit = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverUnit.delegate = self;
    popoverUnit.popoverContentSize=CGSizeMake(drop.frame.size.width, unitsArray.count*50);
    popoverUnit.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverUnit presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if(popoverPurpose){
        popoverPurpose.delegate = nil;
        popoverPurpose = nil;
    }
    if(popoverSubPurpose){
        popoverSubPurpose.delegate = nil;
        popoverSubPurpose = nil;
    }
    if(popoverUnit){
        popoverUnit.delegate = nil;
        popoverUnit = nil;
    }
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    
    if(popoverPurpose){
        [_selectPurposeBtn setTitle:pusrposeArray[tag] forState:UIControlStateNormal];
        subPurposeArray = [dtarr[tag] valueForKey:@"value"];
        [_selectSubPurposeBtn setTitle:subPurposeArray[0] forState:UIControlStateNormal];
        popoverPurpose.delegate = nil;
        popoverPurpose = nil;
        [popoverPurpose dismissPopoverAnimated:YES];
        _appointObj.ServiceType = pusrposeArray[tag];
        if(!(isEmpty(_appointObj.TimeSlot))){
            [self setToNormalValuesWhenSelectionChanged:YES];
        }
        if(selectedUnitTag>=0){
            validationBool = [self handOverNotificationsValidation:selectedUnitTag];
        }
        [self adjustImageEdgeInsetsOfButton:_selectPurposeBtn];
    }
    
    if(popoverSubPurpose){
       [_selectSubPurposeBtn setTitle:subPurposeArray[tag] forState:UIControlStateNormal];
        popoverSubPurpose.delegate = nil;
        popoverSubPurpose = nil;
        [popoverSubPurpose dismissPopoverAnimated:YES];
        _appointObj.SubProcessName = subPurposeArray[tag];
        if(!(isEmpty(_appointObj.TimeSlot))){
            [self setToNormalValuesWhenSelectionChanged:NO];
        }
        if(selectedUnitTag>=0){
            validationBool = [self handOverNotificationsValidation:selectedUnitTag];
        }
        [self adjustImageEdgeInsetsOfButton:_selectSubPurposeBtn];
    }
    if(popoverUnit){
        [_selectUnitBtn setTitle:unitsArray[tag] forState:UIControlStateNormal];
        popoverUnit.delegate = nil;
        popoverUnit = nil;
        [popoverUnit dismissPopoverAnimated:YES];
        _appointObj.BookingUnit = unitsArray[tag];
        validationBool = [self handOverNotificationsValidation:tag];
        selectedUnitTag = tag;
        [self adjustImageEdgeInsetsOfButton:_selectUnitBtn];
    }
}



//-(void)dropMenu{
//    _purposeDropDown.delegate = self;
//    _purposeDropDown.items = pusrposeArray;
//    _purposeDropDown.title = pusrposeArray[0];
//    _purposeDropDown.titleColor = rgb(191, 152, 36);
//    _purposeDropDown.DirectionDown = YES;
//
//
//    _subPurposeDropDown.delegate = self;
//    _subPurposeDropDown.items = subPurposeArray;
//    _subPurposeDropDown.title = subPurposeArray[0];
//    _subPurposeDropDown.titleColor = rgb(191, 152, 36);
//    _subPurposeDropDown.DirectionDown = YES;
    
    
//    _unitsDropDown.delegate = self;
//    unitsArray = [[DamacSharedClass sharedInstance].unitsArray valueForKey:@"unitNumber"];
//    _unitsDropDown.items = unitsArray;
//    _unitsDropDown.title = @"Select unit";
//    _unitsDropDown.titleColor = rgb(191, 152, 36);
//    _unitsDropDown.DirectionDown = YES;
//
//
//    _timeSlotDropMenu.delegate = self;
//    _timeSlotDropMenu.items = slotsArray;
//    _timeSlotDropMenu.title = @"Select slot";
//    _timeSlotDropMenu.titleColor = rgb(191, 152, 36);
//    _timeSlotDropMenu.DirectionDown = YES;
//
//}
//-(void)setCalendarInit{
//
//    calendarView = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
//    //calendarView.dayColor=[UIColor blackColor];
//    //calendarView.weekDayNameColor=[UIColor purpleColor];
//    //calendarView.barDateColor=[UIColor purpleColor];
//    //calendarView.todayBackgroundColor=[UIColor blackColor];
//    calendarView.tappedDayBackgroundColor=[UIColor blackColor];
//    calendarView.calendarStyle = WSCalendarStyleDialog;
//    calendarView.isShowEvent=false;
//    [calendarView setupAppearance];
//    [self.baseView addSubview:calendarView];
//    calendarView.delegate=self;
//
//    eventArray=[[NSMutableArray alloc] init];
//    NSDate *lastDate;
//    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
//    for (int i=0; i<10; i++) {
//
//        if (!lastDate) {
//            lastDate=[NSDate date];
//        }
//        else{
//            [dateComponent setDay:1];
//        }
//        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:lastDate options:0];
//        lastDate=datein;
//        [eventArray addObject:datein];
//    }
//    [calendarViewEvent reloadCalendar];
//
//    NSLog(@"%@",[eventArray description]);
//}



//#pragma mark DropMenu Delegates
//-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
//{
//    if(dropMenu == _purposeDropDown){
//        _purposeDropDown.title = pusrposeArray[atIntedex];
//        subPurposeArray = [dtarr[atIntedex] valueForKey:@"value"];
//        _subPurposeDropDown.items = subPurposeArray;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            _subPurposeDropDown.title = subPurposeArray[0];
//        });
//    }
//    if(dropMenu == _subPurposeDropDown){
//        _subPurposeDropDown.title = subPurposeArray[atIntedex];
//    }
//    if(dropMenu == _unitsDropDown){
//        _unitsDropDown.title = unitsArray[atIntedex];
//    }
//    if(dropMenu == _timeSlotDropMenu){
//        _timeSlotDropMenu.title = slotsArray[atIntedex];
//    }
//
//}
//-(void)changeSubPurposeDropDown{
//
//}
//
//-(void)didShow : (KPDropMenu *)dropMenu{
//
//}
//-(void)didHide : (KPDropMenu *)dropMenu{
//
//}

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

- (IBAction)calendarClick:(id)sender {
  
//    [calendarView ActiveCalendar:self.baseView];
    if(!(_appointObj.BookingUnit.length>0)){
        [FTIndicator showToastMessage:@"Please select unit"];
    }
    if(validationBool){
        [FTIndicator showToastMessage:@"No Handover notice available"];
    }else{
        [self getAvailableSlots];
    }
    
}
- (IBAction)sendRequestClick:(id)sender {
    
    if(isEmpty(_appointObj.ServiceType)){
        [FTIndicator showToastMessage:@"please select purpose"];
        return;
    }
    if(isEmpty(_appointObj.TimeSlot)){
        [FTIndicator showToastMessage:@"please select slot"];
        return;
    }
    [FTIndicator showProgressWithMessage:@"Loading please wait" userInteractionEnable:NO];
    [_appointObj createappointment];
    
}


-(void)setToNormalValuesWhenSelectionChanged:(BOOL)purpose{
    
    if(purpose){
        _appointObj.SubProcessName = @"";
        [_selectSubPurposeBtn setTitle:@"Select Sub Purpose" forState:UIControlStateNormal];
    }
    else{
        _appointObj.AppointmentDate = @"";
        [_calendarBtn setTitle:@"Select Appointment Date" forState:UIControlStateNormal];
    }
    
    _slotLabel.text = @"Select Slot";
    _appointObj.TimeSlot = @"";
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
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    
//    NSDateFormatter *todaysDate = [[NSDateFormatter alloc]init];
//    [todaysDate setDateFormat:@"dd MMM yyyy"];
    NSDate *tdaysDate = [NSDate date];
    NSComparisonResult result = [tdaysDate compare:selectedDate];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
    NSLog(@"%ld",(long)result);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:(NSWeekOfYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitWeekday) fromDate:selectedDate];

    if(result == -1 ){
        [self.calendarBtn setTitle:str forState:UIControlStateNormal];
        
    }else if(dateComponent.weekday == 6 || dateComponent.weekday == 7){
        [FTIndicator showErrorWithMessage:@"Friday and Saturday are weekoff"];
        [calendarView ActiveCalendar:self.baseView];
    }
        else{
            [FTIndicator showErrorWithMessage:@"Selected Date should be greater"];
            [calendarView ActiveCalendar:self.baseView];
    }
        
}


- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
}

- (NSArray *)JSONFromFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


- (IBAction)selectPurposeNewClick:(id)sender {
    [self showpopover:_selectPurposeBtn];
}

- (IBAction)selectSubPurposeNewClick:(id)sender{
    [self showSubpopover:_selectSubPurposeBtn];
}
- (IBAction)selectUnitNewClick:(id)sender{
    [self showUnitspopover:_selectUnitBtn];
}
-(void)getAvailableSlots{
    
    if(isEmpty(_appointObj.ServiceType))
    {
        [FTIndicator showToastMessage:@"Please select Purpose"];
        return;
    }
//    if(isEmpty(_appointObj.SubProcessName))
//    {
//        [FTIndicator showToastMessage:@"Please select Sub-Purpose"];
//        return;
//    }
    if(isEmpty(_appointObj.BookingUnit))
    {
        [FTIndicator showToastMessage:@"Please select Unit"];
        return;
    }
    
    [FTIndicator showProgressWithMessage:@"Loading please wait" userInteractionEnable:NO];
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc]init];
    [dtFormat setDateFormat:@"YYYY-MM-dd"];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setDay:2];
    
    NSDate *date = [[NSCalendar currentCalendar]dateByAddingComponents:comp toDate:[NSDate date] options:0];
    NSString *dtStr =[dtFormat stringFromDate:date];
    
    NSDictionary *dict =@{ @"strSelectedProcess" : handleNull(_appointObj.ServiceType),
                           @"strSelectedSubProcess":handleNull(_appointObj.SubProcessName),
                           @"buildingId":handleNull(_appointObj.BookingUnit),
                           @"strSelectedDate":handleNull(dtStr)
                           };
    
    ServerAPIManager *ser = [ServerAPIManager sharedinstance];
    [ser postRequestwithUrl:@"https://servicecloudtrial-155c0807bf-1580afc5db1.force.com/MobileApp/services/apexrest/SendAvailableAppointmentsToMObileApp/" withParameters:dict successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dictSlots = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dictSlots);
            
            if([dictSlots isKindOfClass:[NSArray class]]){
                [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                [FTIndicator showToastMessage:@"Non availability of time slots"];
                return;
            }
            
            if([dictSlots[@"AvailableSlotsList"] count]>0)
            {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FTIndicator dismissProgress];
                AppointmentsSlotsViewController *appvc = [self.storyboard instantiateViewControllerWithIdentifier:@"appointmentsSlotsViewController"];
                appvc.appointObj = _appointObj;
                appvc.totalArrayDates = dictSlots[@"AvailableSlotsList"];
                [self presentViewController:appvc animated:NO completion:nil];
            });
            }else{
                [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                [FTIndicator showToastMessage:@"Non availability of time slots"];
            }
        }
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
}

@end
