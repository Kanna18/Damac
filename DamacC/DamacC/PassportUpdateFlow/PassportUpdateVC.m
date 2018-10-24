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

@interface PassportUpdateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *baseSuperView;

@end

@implementation PassportUpdateVC{
    
     CGFloat heightTV,numberOfCells,sections;
    CGFloat sec1,sec2,sec3;
    NSArray *sectionHeaders;
    NSArray *dropItems;
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
    
    
    [self dropMenun];
    DamacSharedClass.sharedInstance.currentVC = self;
    self.view.clipsToBounds = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dropMenun{
    
    dropItems = @[@"Existing Details",@"New Details",@"Upload Documents"];
    _dropBaseView.backgroundColor = [UIColor clearColor];
    _dropBaseView.layer.cornerRadius = 10.0f;
    _dropBaseView.layer.borderColor = [UIColor yellowColor].CGColor;
    _dropBaseView.layer.borderWidth = 1.0f;
    _dropBaseView.backgroundColor = [UIColor clearColor];
    _dropBaseView.delegate = self;
    _dropBaseView.items = dropItems;
    _dropBaseView.title = dropItems[0];
    _dropBaseView.titleColor = goldColor;
    _dropBaseView.titleTextAlignment = NSTextAlignmentLeft;
    _dropBaseView.DirectionDown = YES;
    
}
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
            return cell1;
    }
    if (indexPath.section == 1){
            PassportCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"passportCell2" forIndexPath:indexPath];
            return cell2;
    }
    if (indexPath.section == 2){
            PassportCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"passportCell3" forIndexPath:indexPath];
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
        return footer;
    }else{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.view bringSubviewToFront:_baseSuperView];
    [_baseSuperView setNeedsDisplay];
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
}
@end
