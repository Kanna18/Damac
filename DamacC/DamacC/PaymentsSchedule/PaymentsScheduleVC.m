//
//  PaymentsScheduleVC.m
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PaymentsScheduleVC.h"
#import "PaymentsScheduleCell.h"
#import "UnitsHeaderView.h"
#import "UnitsHeaderView.h"
@interface PaymentsScheduleVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PaymentsScheduleVC{
    NSInteger  headerIndex;
    NSDictionary *dataDictionary;
    NSMutableDictionary *tvMutableDictionary;
    UnitsDataModel *unitsDM;
    NSArray *tvArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
     [self.tableView registerNib:[UINib nibWithNibName:@"PaymentsScheduleCell" bundle:nil] forCellReuseIdentifier:@"paymentsScheduleCell"];
    headerIndex = -1;
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
//    [self webServiceCall];
    [self webServiceCallForPayments];
    tvMutableDictionary = [[NSMutableDictionary alloc]init];
        
    /*Latest Google Analytics*/
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"%@", kUserProfile.partyId],
                                     kFIRParameterItemName:[NSString stringWithFormat:@"Payment_Schedule"],
                                     kFIRParameterContentType:@"Button Clicks"
                                     }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Payment schedules"];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return DamacSharedClass.sharedInstance.unitsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[tvMutableDictionary objectForKey:[NSNumber numberWithInteger:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentsScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paymentsScheduleCell" forIndexPath:indexPath];
    [cell setLabels:[tvMutableDictionary objectForKey:[NSNumber numberWithInteger:indexPath.section]][indexPath.row]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vw =[[UIView alloc]initWithFrame:CGRectZero];
    vw.backgroundColor= [UIColor blackColor];
    return  vw;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == headerIndex){
        return 250;
    }else{
        return 0;
    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UnitsHeaderView *headerView = [[UnitsHeaderView alloc]initWithFrame:CGRectZero];
    headerView.headerButton.tag = section;
    [headerView.headerButton addTarget:self action:@selector(reloadTableViewWithHeight:) forControlEvents:UIControlEventTouchUpInside];
    ResponseLine *resp = [DamacSharedClass sharedInstance].unitsArray[section];
    headerView.label1.text =resp.unitNumber;
    headerView.label2.text =resp.unitType;
    headerView.label3.text =resp.propertyCity;
    if(section %2 == 0){
        headerView.backgroundColor = rgb(50, 50, 50);
    }else{
        headerView.backgroundColor = rgb(41, 41, 41);
    }
    return headerView;
    
}

-(void)reloadTableViewWithHeight:(UIButton*)btn{
    btn.selected = YES;
    if(headerIndex == btn.tag){
        headerIndex = -1;
    }else{
        headerIndex = btn.tag;
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:btn.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}


-(void)webServiceCallForPayments{

    for (int i = 0 ; i<[DamacSharedClass sharedInstance].unitsArray.count ; i++) {
        ResponseLine *resp = [DamacSharedClass sharedInstance].unitsArray[i];
        Action *act = resp.actions[0];
        NSString *paymentsUrl = act.url;
        ServerAPIManager *server = [ServerAPIManager sharedinstance];
        [server getRequestwithUrl:paymentsUrl successBlock:^(id responseObj) {
            if(responseObj){
//                dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
                [self convertDataToJsonModel:responseObj withIndex:i];
                [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
            }
        } errorBlock:^(NSError *error) {
            [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        }];
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
    }
    
    if(!([DamacSharedClass sharedInstance].unitsArray.count>0)){
       [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
    }
}

-(void)convertDataToJsonModel:(NSData*)jsonData withIndex:(int)inde{
    NSError *err;
    NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    PaymentsDataModel *paymentsDM = [[PaymentsDataModel alloc]initWithDictionary:dict error:&err];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"description_payment" ascending:YES];
    NSArray *paymentsArray = [paymentsDM.responseLines sortedArrayUsingDescriptors:@[sort]];
    [tvMutableDictionary  setObject:paymentsArray forKey:[NSNumber numberWithInteger:inde]];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    
}

@end
