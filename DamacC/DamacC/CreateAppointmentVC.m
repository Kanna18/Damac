//
//  CreateAppointmentVC.m
//  DamacC
//
//  Created by Gaian on 25/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CreateAppointmentVC.h"

@interface CreateAppointmentVC ()

@end

@implementation CreateAppointmentVC{
    
    NSArray *pusrposeArray, *subPurposeArray,*dtarr,*unitsArray,*slotsArray;
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    slotsArray = @[@"09:00 - 10:00",
                   @"10:00 - 11:00",
                   @"11:00 - 12:00",
                   @"12:00 - 13:00",
                   @"13:00 - 14:00",
                   @"14:00 - 15:00",
                   @"15:00 - 16:00",
                   @"16:00 - 17:00",
                   @"17:00 - 18:00"];
    [self loadingDropDownsList];
}

-(void)loadingDropDownsList{
    
    dtarr = [self JSONFromFile:@"Appointments"];
    pusrposeArray = [dtarr valueForKey:@"key"];
    subPurposeArray = [dtarr[0] valueForKey:@"value"];
    [self dropMenu];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self setCalendarInit];
}

-(void)dropMenu{
    _purposeDropDown.delegate = self;
    _purposeDropDown.items = pusrposeArray;
    _purposeDropDown.title = pusrposeArray[0];
    _purposeDropDown.titleColor = rgb(191, 152, 36);
    _purposeDropDown.DirectionDown = YES;
    
    
    _subPurposeDropDown.delegate = self;
    _subPurposeDropDown.items = subPurposeArray;
    _subPurposeDropDown.title = subPurposeArray[0];
    _subPurposeDropDown.titleColor = rgb(191, 152, 36);
    _subPurposeDropDown.DirectionDown = YES;
    
    
    _unitsDropDown.delegate = self;
    unitsArray = [[DamacSharedClass sharedInstance].unitsArray valueForKey:@"unitId"];
    _unitsDropDown.items = unitsArray;
    _unitsDropDown.title = @"Select unit";
    _unitsDropDown.titleColor = rgb(191, 152, 36);
    _unitsDropDown.DirectionDown = YES;
    
    
    _timeSlotDropMenu.delegate = self;
    _timeSlotDropMenu.items = slotsArray;
    _timeSlotDropMenu.title = @"Select slot";
    _timeSlotDropMenu.titleColor = rgb(191, 152, 36);
    _timeSlotDropMenu.DirectionDown = YES;
    
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
    [self.baseView addSubview:calendarView];
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
    [calendarViewEvent reloadCalendar];
    
    NSLog(@"%@",[eventArray description]);
}



#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    if(dropMenu == _purposeDropDown){
        _purposeDropDown.title = pusrposeArray[atIntedex];
        subPurposeArray = [dtarr[atIntedex] valueForKey:@"value"];
        _subPurposeDropDown.items = subPurposeArray;
        dispatch_async(dispatch_get_main_queue(), ^{
        _subPurposeDropDown.title = @"sdfcd";
        });
    }
    if(dropMenu == _subPurposeDropDown){
        _subPurposeDropDown.title = subPurposeArray[atIntedex];
    }
    if(dropMenu == _unitsDropDown){
        _unitsDropDown.title = unitsArray[atIntedex];
    }
    if(dropMenu == _timeSlotDropMenu){
        _timeSlotDropMenu.title = slotsArray[atIntedex];
    }
    
}
-(void)changeSubPurposeDropDown{
    
}

-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
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

- (IBAction)calendarClick:(id)sender {
    
    [calendarView ActiveCalendar:self.baseView];
    
}
- (IBAction)sendRequestClick:(id)sender {
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


@end
