//
//  ScheduleAppointmentsVC.m
//  DamacC
//
//  Created by Gaian on 09/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ScheduleAppointmentsVC.h"
#import "AppointmentsCell.h"
#import "CreateAppointmentVC.h"

@interface ScheduleAppointmentsVC ()<UITableViewDataSource,UITableViewDelegate>

@end
static NSString *reuseCell = @"appointmentsCell";
@implementation ScheduleAppointmentsVC{
    NSMutableArray *tvArray,*originalArray;
    NSMutableArray *upcomingArray,*recentlyCreatedArray;;
    UIColor *selectedColor,*unselectedColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [_tableView registerClass:[AppointmentsCell class] forCellReuseIdentifier:reuseCell];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    tvArray = [[NSMutableArray alloc]init];
    originalArray= [[NSMutableArray alloc]init];
    [self webServiceCall];
    
    selectedColor = rgb(151, 121, 73);
    unselectedColor = rgb(68, 68, 68);
    [self changeSelectedColor:_recentlyCreatedBtn];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 200, 0)];

}

-(void)changeSelectedColor:(UIButton*)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_upcomingBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
        [_recentlyCreatedBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
        [sender setTitleColor:selectedColor forState:UIControlStateNormal];
    });
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _bottomView.bounds;
    gradient.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor, (id)[UIColor blackColor].CGColor];
    //    gradient.colors = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor greenColor].CGColor];
    [_bottomView.layer insertSublayer:gradient atIndex:0];

//    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"Appointment Details"];
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Appointment details"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tvArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    [cell setLabelsData:tvArray[indexPath.section]];
    return cell;
}

-(void)webServiceCall{
    ServerAPIManager *ser =[ ServerAPIManager sharedinstance];
    NSLog(@"%@",kUserProfile);
    [ser postRequestwithUrl:getAppointments withParameters:@{@"userName":@"sasanka.rath1@damacgroup.com"} successBlock:^(id responseObj) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        if(arr.count>0){
            for (NSDictionary *dic in arr) {
                if(dic[@"message"]){
                    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
                    [sf logout];
                }else{
                    [originalArray addObject:[[AppointmentsDataModel alloc] initWithDictionary:dic error:nil]];
                }
            }
            [self recentlyCreatedList];
            [self upcomingAppointmentsList];
        }
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vw = [[UIView alloc]initWithFrame:tableView.tableFooterView.frame];
    vw.backgroundColor = [UIColor clearColor];
    return vw;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createAppointmentClick:(id)sender {
    
    CreateAppointmentVC *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"createAppointmentVC"];
    [self.navigationController pushViewController:cvc animated:YES];
}
- (IBAction)recentlyCreatedClick:(id)sender {
    [self changeSelectedColor:(UIButton*)sender];
    [tvArray removeAllObjects];
    tvArray = [[NSMutableArray alloc]initWithArray:recentlyCreatedArray];
    [_tableView reloadData];
}

- (IBAction)upcomingClick:(id)sender {
    [self changeSelectedColor:(UIButton*)sender];
    [tvArray removeAllObjects];
    tvArray = [[NSMutableArray alloc]initWithArray:upcomingArray];
    [_tableView reloadData];
}

-(void)recentlyCreatedList{

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSArray *sortedArray = [originalArray sortedArrayUsingComparator:^NSComparisonResult(AppointmentsDataModel *obj1, AppointmentsDataModel *obj2) {
        NSDate *d1 = [df dateFromString: obj1.Appointment_Date__c];
        NSDate *d2 = [df dateFromString: obj2.Appointment_Date__c];
        return [d2 compare: d1];
    }];
    recentlyCreatedArray = [[NSMutableArray alloc]initWithArray:sortedArray];
    tvArray = [[NSMutableArray alloc]initWithArray:recentlyCreatedArray];
    [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}
-(void)upcomingAppointmentsList{
    
    upcomingArray = [[NSMutableArray alloc]init];
    for (AppointmentsDataModel *dict in originalArray) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSDate *givenDate = [format dateFromString:dict.Appointment_Date__c];
        NSDate *date = [NSDate date];
        NSComparisonResult result = [date compare:givenDate];
        if((result == NSOrderedAscending)||(result == NSOrderedSame)){
            [upcomingArray addObject:dict];
        }
    }
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSArray *sortedArray = [upcomingArray sortedArrayUsingComparator:^NSComparisonResult(AppointmentsDataModel *obj1, AppointmentsDataModel *obj2) {
        NSDate *d1 = [df dateFromString: obj1.Appointment_Date__c];
        NSDate *d2 = [df dateFromString: obj2.Appointment_Date__c];
        return [d2 compare: d1];
    }];
    upcomingArray = [[NSMutableArray alloc]initWithArray:sortedArray];
    
}
@end
