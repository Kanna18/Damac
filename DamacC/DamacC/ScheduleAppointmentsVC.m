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
    NSMutableArray *tvArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [_tableView registerClass:[AppointmentsCell class] forCellReuseIdentifier:reuseCell];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    tvArray = [[NSMutableArray alloc]init];
    [self webServiceCall];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _bottomView.bounds;
    gradient.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor, (id)[UIColor blackColor].CGColor];
    //    gradient.colors = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor greenColor].CGColor];
    [_bottomView.layer insertSublayer:gradient atIndex:0];

    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"Appointment Details"];
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
    [cell setLabelsData:tvArray[indexPath.row]];
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
                    [tvArray addObject:[[AppointmentsDataModel alloc] initWithDictionary:dic error:nil]];
                }
            }
        }
       
        [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    } errorBlock:^(NSError *error) {
        
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
@end
