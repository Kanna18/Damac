//
//  ReceiptsTableVC.m
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ReceiptsTableVC.h"
#import "ReceiptsTableViewCell.h"
#import "UnitsHeaderView.h"

@interface ReceiptsTableVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ReceiptsTableVC{
    
    NSInteger  headerIndex;
    NSDictionary *dataDictionary;
    ReceiptDataModel *receiptsDM;
    NSArray *tvArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ReceiptsTableViewCell" bundle:nil] forCellReuseIdentifier:@"receiptsTableViewCell"];
    headerIndex = -1;
    [self webServiceCall];
    DamacSharedClass.sharedInstance.currentVC = self;
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
    return tvArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"receiptsTableViewCell" forIndexPath:indexPath];
    ReceiptResponseLines *rs = tvArray[indexPath.section];
    cell.label1.text = rs.appliedAmount;
    cell.label2.text = rs.receiptReference;
    cell.label3.text = rs.cashReceiptId;
    cell.label4.text = @"";
    cell.rs = rs;
  
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
        return 230;
    }else{
        return 0;
    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UnitsHeaderView *headerView = [[UnitsHeaderView alloc]initWithFrame:CGRectZero];
    headerView.headerButton.tag = section;
    [headerView.headerButton addTarget:self action:@selector(reloadTableViewWithHeight:) forControlEvents:UIControlEventTouchUpInside];
    ReceiptResponseLines *resp = tvArray[section];
    headerView.label1.text =resp.receiptNumber;
    headerView.label2.text =resp.receiptDate;
    headerView.label3.text =resp.functionalAmount;
    if(section %2 == 0){
        headerView.backgroundColor = rgb(30, 30, 30);
    }else{
        headerView.backgroundColor = rgb(50, 50, 50);
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



-(void)webServiceCall{
    NSLog(@"%@",_serverUrlString);
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
    
        receiptsDM = [[ReceiptDataModel alloc]initWithDictionary:dataDictionary error:&err];
        tvArray = receiptsDM.responseLines;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}


@end
