//
//  AppointmentsSlotsViewController.m
//  DamacC
//
//  Created by Gaian on 29/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "AppointmentsSlotsViewController.h"
#import "SlotCell.h"

@interface AppointmentsSlotsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WYPopoverControllerDelegate,POPDelegate>


@end

@implementation AppointmentsSlotsViewController{
    
    WYPopoverController* popovermonth;
    WYPopoverController* popoverDate;
    
    NSMutableArray *dateArray;
    NSMutableArray *monthArray;
    NSMutableArray *timeSlotsArray;
    NSMutableArray *onlyDayArray;
    
    NSMutableArray *slotsDictArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *floe = [[UICollectionViewFlowLayout alloc]init];
    [floe setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.navigationController.navigationBar.hidden=NO;
    
    monthArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    timeSlotsArray = [[NSMutableArray alloc]init];
    onlyDayArray = [[NSMutableArray alloc]init];
    slotsDictArray = [[NSMutableArray alloc]init];
    
    [self sortMonthsArray];
    [_selectDateBtn setTitle:@"" forState:UIControlStateNormal];
    _heightConstraint.constant = 140;
    
    
    [self roundCorners:_selectMonthBtn];
    [self roundCorners:_selectDateBtn];
    [self roundCornersView:_viewBackground];
    _availableSlotsLabel.hidden = YES;
}

-(void)roundCornersView:(UIView*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = goldColor.CGColor;
    sender.layer.borderWidth = 1.0f;
    sender.clipsToBounds = YES;
}
-(void)selectTheFirstDateAndMonthBydefault{
    
    _heightConstraint.constant = 351;
    _availableSlotsLabel.hidden = NO;
    
    [_selectMonthBtn setTitle:monthArray[0] forState:UIControlStateNormal];
    [_selectDateBtn setTitle:@"Select Date" forState:UIControlStateNormal];
    [self sortDatesArray:monthArray[0]];
    
    
    [_selectDateBtn setTitle:onlyDayArray[0] forState:UIControlStateNormal];
    [self sortSlotsArray:dateArray[0]];
    _appointObj.AppointmentDate = dateArray[0];
    
    
    [_collectionView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self adjustImageEdgeInsetsOfButton:_selectMonthBtn];
    [self adjustImageEdgeInsetsOfButton:_selectDateBtn];
    [self selectTheFirstDateAndMonthBydefault];
}
-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = goldColor.CGColor;
    sender.layer.borderWidth = 1.0f;
    sender.clipsToBounds = YES;
    [self adjustImageEdgeInsetsOfButton:sender];
}

-(void)adjustImageEdgeInsetsOfButton:(UIButton*)sender{
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-30-sender.titleLabel.intrinsicContentSize.width, 0, 0);
}
-(void)sortMonthsArray{
    NSSet *dupSet = [[NSSet alloc]initWithArray:_totalArrayDates];
    _totalArrayDates = [dupSet allObjects];
    
    for (NSString *str in _totalArrayDates) {
        NSArray *ar = [str componentsSeparatedByString:@"\("];
        NSString *mont = [ar[0] substringWithRange:NSMakeRange(5, 2)];
        [monthArray  addObject:mont];
    }
    NSSet *monthSet = [[NSSet alloc]initWithArray:monthArray];
    [monthArray removeAllObjects];
    NSSortDescriptor *sortK = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray* monthSort = [monthSet sortedArrayUsingDescriptors:@[sortK]];
    for (NSString *mont in monthSort) {
        NSDateFormatter *format1 = [[NSDateFormatter alloc]init];
        [monthArray addObject:[[format1 monthSymbols] objectAtIndex:mont.intValue-1]];
    }
    
    NSLog(@"%@",monthArray);
}

-(void)sortDatesArray:(NSString*)date{
    
    [dateArray removeAllObjects];
    [onlyDayArray removeAllObjects];
    
    NSDateFormatter *dt = [[NSDateFormatter alloc]init];
    int countOfObj = (int)[[dt monthSymbols] indexOfObject:date]+1;
    for (NSString *str in _totalArrayDates) {
        NSArray *ar = [str componentsSeparatedByString:@"\("];
        NSString *mont = ar[0];
        if([mont containsString:[NSString stringWithFormat:@"-%02d-",countOfObj]]&&![dateArray containsObject:mont]){
            [dateArray  addObject:mont];
        }
    }
       dateArray =  [[NSMutableArray alloc]initWithArray:[dateArray sortedArrayUsingSelector:@selector(compare:)]];
    for (NSString *dtt in dateArray) {
        [onlyDayArray addObject:[[dtt componentsSeparatedByString:@"-"] lastObject]];
    }
    [onlyDayArray addObject:@"..."];
}

-(void)sortSlotsArray:(NSString*)date{
    
//    [timeSlotsArray removeAllObjects];
//    for (NSString *str in _totalArrayDates) {
//        if([str containsString:date]){
//            NSArray *arr = [str componentsSeparatedByString:@"\("];
//            [timeSlotsArray addObject:[arr[1] substringToIndex:[arr[1] length]-1]];
//        }
//    }
//    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
//    [timeSlotsArray sortUsingDescriptors:@[sd]];
//    [_collectionView reloadData];
    
    [self fetchingAvailableSlotsNewForDate:date];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectDataClick:(id)sender {
    [self showDatePopover:_selectDateBtn];
}

- (IBAction)selectMonthClick:(id)sender {
    [self showMonthpopover:_selectMonthBtn];
}
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void)showMonthpopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData =monthArray;
    popovermonth = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popovermonth.delegate = self;
    popovermonth.popoverContentSize=CGSizeMake(drop.frame.size.width, monthArray.count*50);
    popovermonth.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popovermonth presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}
-(void)showDatePopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
//        popVC.tvData =dateArray;
    popVC.tvData = onlyDayArray;
    popoverDate = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverDate.delegate = self;
    popoverDate.popoverContentSize=CGSizeMake(80, dateArray.count*50);
    popoverDate.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverDate presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark collection View Delegates


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return timeSlotsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SlotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"slotCell" forIndexPath:indexPath];
    NSArray *arr = [timeSlotsArray[indexPath.row] componentsSeparatedByString:@"-"];
    
//    NSString *slottext = [NSString stringWithFormat:@"%@-\n%@",removeEmpty(arr[0]),removeEmpty(arr[1])];
    NSString *slottext = [NSString stringWithFormat:@"%@",removeEmpty(arr[0])];
    int slotTime = [slottext intValue];
    if(slotTime>12){
        slottext = [NSString stringWithFormat:@"%2d:00 PM",slotTime-12];
    }else if (slotTime<12){
        slottext = [NSString stringWithFormat:@"%2d:00 AM",slotTime];
    }else if (slotTime==12){
        slottext = [NSString stringWithFormat:@"%2d:00 PM",slotTime];
    }
    cell.timeSLotLabel.text = slottext;
    
    cell.timeSLotLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SlotCell *cell = (SlotCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSArray *arr = [timeSlotsArray[indexPath.row] componentsSeparatedByString:@"-"];
    _appointObj.TimeSlot = [[NSString stringWithFormat:@"%@-\n%@",removeEmpty(arr[0]),removeEmpty(arr[1])] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    [self capturetheSlotobjectFromAllSlots:[_appointObj.TimeSlot stringByReplacingOccurrencesOfString:@"-" withString:@" - "]];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)capturetheSlotobjectFromAllSlots:(NSString*)slot{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.objApp.Slots__c MATCHES %@",slot];
    NSArray *arr = [slotsDictArray filteredArrayUsingPredicate:pre];
    if(arr.count>0){
        _appointObj.slotsNewDictionary = [[NSMutableDictionary alloc]initWithDictionary:arr.lastObject];
        [_appointObj.slotsNewDictionary setValue:[NSNumber numberWithBool:1] forKey:@"isSelected"];
    }
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(collectionView.frame.size.width/3-9, 295/4-30);
}




#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if(popovermonth){
        popovermonth.delegate = nil;
        popovermonth = nil;
        
    }
    if(popoverDate){
        popoverDate.delegate = nil;
        popoverDate = nil;
    }
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    
    if(popovermonth){
        
        [_selectMonthBtn setTitle:monthArray[tag] forState:UIControlStateNormal];
        [_selectDateBtn setTitle:@"Select Date" forState:UIControlStateNormal];
        [self sortDatesArray:str];
        popovermonth.delegate = nil;
        popovermonth = nil;
        [popovermonth dismissPopoverAnimated:YES];
        _heightConstraint.constant = 140;
    }
    if(popoverDate){
        
        if([str isEqualToString:@"..."]){
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.delegateForCalendar tappedonThreeDots];
        }else{
            _heightConstraint.constant = 351;
            [_collectionView reloadData];
            //        [_selectDateBtn setTitle:dateArray[tag] forState:UIControlStateNormal];
            [_selectDateBtn setTitle:onlyDayArray[tag] forState:UIControlStateNormal];
            //        [self sortSlotsArray:dateArray[tag]];
            popoverDate.delegate = nil;
            popoverDate = nil;
            [popoverDate dismissPopoverAnimated:YES];
            [self sortSlotsArray:dateArray[tag]];
            _appointObj.AppointmentDate = dateArray[tag];
            _availableSlotsLabel.hidden = NO;
        }
        
    }
}

-(void)fetchingAvailableSlotsNewForDate:(NSString*)date{
    
//    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSDictionary *dict =@{ @"processName" : handleNull(_appointObj.ServiceType),
                           @"subProcessName":handleNull(_appointObj.SubProcessName),
                           @"unitName":handleNull(_appointObj.BookingUnit),
                           @"selectedDate":handleNull(date),
                           @"accountId":kUserProfile.sfAccountId
                           };
    ServerAPIManager *ser = [ServerAPIManager sharedinstance];
    [ser getRequestwithUrl:[NSString stringWithFormat:@"%@?processName=%@&subProcessName=%@&unitName=%@&selectedDate=%@&accountId=%@",AppointmentsSlotsNew,handleNull(_appointObj.ServiceType),handleNull(_appointObj.SubProcessName),handleNull(_appointObj.BookingUnit),handleNull(date),kUserProfile.sfAccountId] withParameters:dict successBlock:^(id responseObj) {
        slotsDictArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        NSLog(@"%@",slotsDictArray);
        NSArray *validayionChechk = [slotsDictArray valueForKey:@"objApp"];
        if(!slotsDictArray.count){
            [FTIndicator showToastMessage:@"Non availability of time slots"];
        }
        else if(validayionChechk && validayionChechk.count>0)
        {
            NSArray *sArr = [[NSMutableArray alloc]initWithArray:[[slotsDictArray valueForKey:@"objApp"] valueForKey:@"Slots__c"]];
            if(sArr && sArr.count>1){
                NSArray *sortedArray = [[NSSet setWithArray:sArr] allObjects];
                timeSlotsArray = [[NSMutableArray alloc]initWithArray:sortedArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
                    [timeSlotsArray sortUsingDescriptors:@[sd]];
                    [_collectionView reloadData];
                });
            }
        }
        
    } errorBlock:^(NSError *error) {
        [FTIndicator showToastMessage:@"Non availability of time slots"];
    }];
    
}

@end
