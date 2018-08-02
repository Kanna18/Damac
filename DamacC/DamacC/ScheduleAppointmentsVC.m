//
//  ScheduleAppointmentsVC.m
//  DamacC
//
//  Created by Gaian on 09/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ScheduleAppointmentsVC.h"
#import "AppointmentsCell.h"

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
    [ser postRequestwithUrl:getAppointments withParameters:@{@"userName":@"siraj.khan@damacgroup.com"} successBlock:^(id responseObj) {
        
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        for (NSDictionary *dict in arr) {
            [tvArray addObject:[[AppointmentsDataModel alloc] initWithDictionary:dict error:nil]];
        }
        [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    } errorBlock:^(NSError *error) {
        
    }];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vw = [[UIView alloc]initWithFrame:tableView.tableFooterView.frame];
    vw.backgroundColor = [UIColor clearColor];
    return vw;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 50;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
