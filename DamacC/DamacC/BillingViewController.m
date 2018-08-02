//
//  BillingViewController.m
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ViewControllerCell.h"
#import "BillingViewController.h"
#import "ViewControllerCellHeader.h"

#define coun 2

@interface BillingViewController ()

@end

@implementation BillingViewController{
    
    IBOutlet UITableView *tblView;
    NSMutableArray *arrSelectedSectionIndex;
    BOOL isMultipleExpansionAllowed, isFilterExpanded;
    NSArray *headerArr;
    NSArray *sideLabelsArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isMultipleExpansionAllowed = NO;
    arrSelectedSectionIndex = [[NSMutableArray alloc] init];
    if (!isMultipleExpansionAllowed) {
        [arrSelectedSectionIndex addObject:[NSNumber numberWithInt:coun+2]];
    }
    headerArr = @[@"BILLING ADDRESS",@"SHIPPING ADDRESS"];
    sideLabelsArray = @[@"Name",@"Address",@"City",@"Country",@"State",@"Telephone",@"Email Id"];
    tblView.alwaysBounceVertical = NO;
    isFilterExpanded = NO;
    
    _proceedBtn.titleLabel.textColor = rgb(174, 134, 73);
    _proceedBtn.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:10];
}

#pragma mark - TableView methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return coun;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        return sideLabelsArray.count;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v =[[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor blackColor];
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    if (cell ==nil)
    {
        [tblView registerClass:[ViewControllerCell class] forCellReuseIdentifier:@"ViewControllerCell"];
        cell = [tblView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    }
    cell.lblName.text = sideLabelsArray[indexPath.row];//[NSString stringWithFormat:@"%ld", (long)indexPath.row];
//    cell.backgroundColor = indexPath.row%2==0?[UIColor lightTextColor]:[[UIColor lightTextColor] colorWithAlphaComponent:0.5f];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ViewControllerCellHeader *headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    if (headerView ==nil)
    {
        [tblView registerClass:[ViewControllerCellHeader class] forCellReuseIdentifier:@"ViewControllerCellHeader"];
        headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];        
    }
    headerView.lbTitle.text = headerArr[section];//[NSString stringWithFormat:@"Section %ld", (long)section];
    headerView.lbTitle.textColor = rgb(174, 134, 73);
    headerView.lbTitle.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16];
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        headerView.btnShowHide.selected = YES;
    }
    [[headerView btnShowHide] setTag:section];
    [[headerView btnShowHide] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];
//    [headerView.contentView setBackgroundColor:section%2==0?[UIColor groupTableViewBackgroundColor]:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5f]];
    return headerView.contentView;
}

-(IBAction)btnTapShowHideSection:(UIButton*)sender
{
    if (!sender.selected)
    {
        if (!isMultipleExpansionAllowed) {
            if(arrSelectedSectionIndex.count==0){
                [arrSelectedSectionIndex addObject:[NSNumber numberWithInt:2]];
            }
            [arrSelectedSectionIndex replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:sender.tag]];
        }else {
            [arrSelectedSectionIndex addObject:[NSNumber numberWithInteger:sender.tag]];
        }
        sender.selected = YES;
        isFilterExpanded = YES;
        
    }else{
        sender.selected = NO;
        isFilterExpanded = NO;
        if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:sender.tag]])
        {
            [arrSelectedSectionIndex removeObject:[NSNumber numberWithInteger:sender.tag]];
        }
    }
    if (!isMultipleExpansionAllowed) {
        [tblView reloadData];
    }else {
        [tblView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationTop];
    }
    [self adjustHeightOfTheTableView:7];
}

-(void)adjustHeightOfTheTableView:(int)numbe{
    CGFloat num = 1;
    if(isFilterExpanded){
         num = numbe *50;
    }else{
         num = -numbe *50;
    }
    CGFloat con = _heightConstraint.constant;
    
    _heightConstraint.constant = con + num;
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

- (IBAction)showAddressClick:(id)sender {
}

- (IBAction)proceedClick:(id)sender {
}

- (IBAction)ccavenueClick:(id)sender {
}
@end
