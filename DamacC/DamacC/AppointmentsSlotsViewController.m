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
    
    [self sortMonthsArray];
    [_selectDateBtn setTitle:@"" forState:UIControlStateNormal];
    _heightConstraint.constant = 140;
    [self adjustImageEdgeInsetsOfButton:_selectMonthBtn];
    [self adjustImageEdgeInsetsOfButton:_selectDateBtn];
    
    [self roundCorners:_selectMonthBtn];
    [self roundCorners:_selectDateBtn];
    [self roundCornersView:_viewBackground];
    
}

-(void)roundCornersView:(UIView*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = goldColor.CGColor;
    sender.layer.borderWidth = 1.0f;
    sender.clipsToBounds = YES;
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
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-40, 0, 0);
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
    for (NSString *mont in monthSet) {
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
        if([mont containsString:[NSString stringWithFormat:@"-%d-",countOfObj]]&&![dateArray containsObject:mont]){
            [dateArray  addObject:mont];
        }
    }
       dateArray =  [[NSMutableArray alloc]initWithArray:[dateArray sortedArrayUsingSelector:@selector(compare:)]];
    for (NSString *dtt in dateArray) {
        [onlyDayArray addObject:[[dtt componentsSeparatedByString:@"-"] lastObject]];
    }
}
-(void)sortSlotsArray:(NSString*)date{
    
    [timeSlotsArray removeAllObjects];
    for (NSString *str in _totalArrayDates) {
        if([str containsString:date]){
            NSArray *arr = [str componentsSeparatedByString:@"\("];
            [timeSlotsArray addObject:[arr[1] substringToIndex:[arr[1] length]-1]];
        }
    }
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    [timeSlotsArray sortUsingDescriptors:@[sd]];
    [_collectionView reloadData];
    
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
    cell.timeSLotLabel.text = [NSString stringWithFormat:@"%@-\n%@",removeEmpty(arr[0]),removeEmpty(arr[1])];
    cell.timeSLotLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SlotCell *cell = (SlotCell*)[collectionView cellForItemAtIndexPath:indexPath];
    _appointObj.TimeSlot = [cell.timeSLotLabel.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(collectionView.frame.size.width/3-9, collectionView.frame.size.width/4-30);
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
        
        _heightConstraint.constant = 351;
//        [_selectDateBtn setTitle:dateArray[tag] forState:UIControlStateNormal];
        [_selectDateBtn setTitle:onlyDayArray[tag] forState:UIControlStateNormal];
        [self sortSlotsArray:dateArray[tag]];
        popoverDate.delegate = nil;
        popoverDate = nil;
        [popoverDate dismissPopoverAnimated:YES];
        [self sortSlotsArray:dateArray[tag]];
        _appointObj.AppointmentDate = dateArray[tag];
    }
}
@end
