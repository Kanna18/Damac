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
@interface ChangeOfContactDetails ()<KPDropMenuDelegate,UITextFieldDelegate,WYPopoverControllerDelegate,POPDelegate>

@end

@implementation ChangeOfContactDetails{
    
    StepperView *sterView;
    CGFloat heightTV,numberOfCells,sections;
    NSArray *tvArr,*section2Array ;
    UserDetailsModel *udm;
    KPDropMenu *dropNew;
    UIColor *selectedColor;
    NSArray *dropItems;
    WYPopoverController* popoverController;

    NSInteger *section2Cells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _stepperBaseView.backgroundColor = [UIColor clearColor];
    heightTV = 50;
    numberOfCells = 3;
    sections = 1;
    section2Cells = 0;
    _tableViewHeight.constant = heightTV;
    udm = [DamacSharedClass sharedInstance].userProileModel;
    
    selectedColor = _view1.backgroundColor;
    [self mobileClick:nil];
    
    [self layerRadius:_view1];
    [self layerRadius:_view2];
    [self layerRadius:_view3];
    
    _downloadBtn.layer.cornerRadius = 5;
    _downloadBtn.layer.borderWidth =1.0f;
    _downloadBtn.layer.borderColor = rgb(191, 154, 88).CGColor;
    
    dropItems = @[@"Apple", @"Grapes", @"Cherry", @"Pineapple", @"Mango", @"Orange"];
    dropNew = [[KPDropMenu alloc] init];
    dropNew.layer.cornerRadius = 10.0f;
    dropNew.layer.borderColor = [UIColor yellowColor].CGColor;
    dropNew.layer.borderWidth = 1.0f;
    dropNew.backgroundColor = [UIColor clearColor];
    dropNew.delegate = self;
    dropNew.items = dropItems;
    dropNew.title = @"Select Again";
    dropNew.titleColor = [UIColor yellowColor];
    dropNew.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    dropNew.titleTextAlignment = NSTextAlignmentLeft;
    dropNew.DirectionDown = YES;
    dropNew.clipsToBounds = NO;
    _tableView.clipsToBounds = NO;
    dropNew.userInteractionEnabled = YES;
    self.view.clipsToBounds = NO;
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    sterView = [[StepperView alloc]initWithFrame:_stepperBaseView.frame];
    [self.view addSubview:sterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showpopover:(UIButton*)button{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
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
        cell.textField.delegate = self;
        cell.clipsToBounds = NO;
        [cell.selectCountryButtton addTarget:self action:@selector(showpopover:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    if(indexPath.section ==1){
        ChangeofContactCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"changeofContactCell2" forIndexPath:indexPath];
        cell.subLabel.text = section2Array[indexPath.row][@"key"];
        cell.textField.text = section2Array[indexPath.row][@"value"];
        cell.textField.delegate = self;
        cell.clipsToBounds = NO;
        return cell;
    }
    
//    if(indexPath.row==5){
//        dropNew.frame = cell.textField.bounds;
//        [cell.contentView addSubview:dropNew];
//        cell.borderView.hidden = YES;
//        cell.clipsToBounds = NO;
//    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        ChangeofContactCell *cell1 = (ChangeofContactCell*)cell ;
        if(indexPath.row==5){
//        dropNew.frame = cell1.textField.bounds;
//        [cell1.textField addSubview:dropNew];
//        cell1.borderView.hidden = YES;
//        cell1.clipsToBounds = NO;
//        dropNew.layer.borderWidth = 2.0;
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
        sections = 1;
        numberOfCells = 1;
        _tableViewHeight.constant = heightTV;
    NSLog(@"%@",[DamacSharedClass sharedInstance].userProileModel);
    tvArr = @[@{@"key":@"Mobile No.",
                @"value":[NSString stringWithFormat:@"%@%@%@",udm.countryCode,udm.phoneAreaCode,udm.phoneNumber]}
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
        sections = 1;
        numberOfCells = 1;
        _tableViewHeight.constant = heightTV;
    tvArr = @[@{@"key":@"Email",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]}];
    [_tableView reloadData];
    [self setColorsForSelectedButton:_view2];
}

- (IBAction)addressClick:(id)sender {
        sections = 2;
        numberOfCells = 3;
        _tableViewHeight.constant = 280;
    tvArr = @[@{@"key":@"Address1",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
              @{@"key":@"Address2",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
              @{@"key":@"Address3",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
              @{@"key":@"Address4",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
              @{@"key":@"City",
                @"value":[NSString stringWithFormat:@"%@",udm.city]},
              @{@"key":@"Country",
                @"value":@""},//[NSString stringWithFormat:@"%@",udm.countryOfResidence]},
              @{@"key":@"State",
                @"value":[NSString stringWithFormat:@"%@",udm.countryCode]},
              @{@"key":@"Postal Code",
                @"value":[NSString stringWithFormat:@"%@",udm.countryCode]}];
    
    section2Array = @[@{@"key":@"Address1\n(in Arabic) ",
                        @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
                      @{@"key":@"City\n(in Arabic)",
                        @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
                      @{@"key":@"Country\n(in Arabic)",
                        @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
                      @{@"key":@"State(in Arabic)",
                        @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]}];
    
    [self setColorsForSelectedButton:_view3];
    [_tableView reloadData];
}
- (IBAction)saveDraftClick:(id)sender {
}

- (IBAction)downloadFormClick:(id)sender {
}

#pragma mark TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@",textField.placeholder);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    [self.view bringSubviewToFront:dropNew];
    dropNew.title = dropItems[atIntedex];
    
}

-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}

@end
