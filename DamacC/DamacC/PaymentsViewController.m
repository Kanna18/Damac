//
//  PaymentsViewController.m
//  DamacC
//
//  Created by Gaian on 16/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PaymentsViewController.h"
#import "PaymentsCell.h"
@interface PaymentsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PaymentsViewController{
    
    NSDictionary *dataDictionary;
    NSArray *tvArray;
    PaymentsDataModel *paymentsDM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self webServiceCall];
    [FTIndicator showProgressWithMessage:@"Loading"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webServiceCall{
    if(_serverUrlString.length>0){
        ServerAPIManager *server = [ServerAPIManager sharedinstance];
        [server getRequestwithUrl:_serverUrlString successBlock:^(id responseObj) {
            if(responseObj){
                dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
                [self convertDataToJsonModel:responseObj];
                [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
            }
        } errorBlock:^(NSError *error) {
            [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        }];
    }
    [FTIndicator dismissProgress];
}

-(void)convertDataToJsonModel:(NSData*)jsonData{
    NSError *err;
        paymentsDM = [[PaymentsDataModel alloc]initWithDictionary:dataDictionary error:&err];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"description_payment" ascending:YES];
        tvArray = [paymentsDM.responseLines sortedArrayUsingDescriptors:@[sort]];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}


#pragma mark Tableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tvArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseCell = @"paymentsCell";
    PaymentsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    [cell setLabels:tvArray[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
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
