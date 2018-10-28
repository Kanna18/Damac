//
//  UnitsTableViewController.m
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "UnitsTableViewController.h"
#import "UnitsCell.h"
#import "UnitsHeaderView.h"
#import "PrintDocView.h"
#import "BillingViewController.h"
@interface UnitsTableViewController ()

@end

@implementation UnitsTableViewController{
 
    NSInteger  headerIndex;
    NSDictionary *dataDictionary;
    NSArray *tvArray;
    UnitsDataModel *unitsDM;
    UIButton *arrowButton;
    PrintDocView *docView;
    UIView *bgView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"UnitsCell" bundle:nil] forCellReuseIdentifier:@"unitsCell"];
    headerIndex = -1;
     [self webServiceCall];
    DamacSharedClass.sharedInstance.currentVC = self;
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"My Units"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WebService


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tvArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UnitsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unitsCell" forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    ResponseLine *rs = tvArray[indexPath.section];
    cell.label1.text = rs.permittedUse;
    cell.label2.text = rs.unitCategory;
    cell.label3.text = rs.readyOrOffPlan;
    cell.label4.text = rs.registrationDate;
    cell.label5.text = rs.completionDate;
    cell.label6.text = rs.area;
    cell.label7.text = rs.agreementDate;
    cell.label8.text = rs.unitCategory;
    cell.label9.text = rs.propertyCity;
    cell.statusLabel.text = @"Agreement executed by DAMAC";
    cell.printDocButton.tag = 100 +indexPath.section;
    cell.payNowButton.tag = 500 +indexPath.section;
    [cell.printDocButton addTarget:self action:@selector(printDocumentsClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.printDocButton.tag = indexPath.section;
    cell.dueAmount = rs.totalDueInvoice;
//    [cell.payNowButton addTarget:self action:@selector(payNow:) forControlEvents:UIControlEventTouchUpInside];
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
        return 303;
    }else{
        return 0;
    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UnitsHeaderView *headerView = [[UnitsHeaderView alloc]initWithFrame:CGRectZero];
    headerView.headerButton.tag = section;
    [headerView.headerButton addTarget:self action:@selector(reloadTableViewWithHeight:) forControlEvents:UIControlEventTouchUpInside];
    ResponseLine *rs = tvArray[section];
    headerView.label1.text =rs.unitNumber;
    headerView.label2.text =rs.unitType;
    headerView.label3.text =rs.propertyName;
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
    
    if(!([DamacSharedClass sharedInstance].unitsArray.count>0))
    {
    [FTIndicator showProgressWithMessage:@"Fetching Units"];
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
    }
    else{
        tvArray = [DamacSharedClass sharedInstance].unitsArray;
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    }
    [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
}


-(void)convertDataToJsonModel:(NSData*)jsonData{

    NSError *err;
    unitsDM = [[UnitsDataModel alloc]initWithDictionary:dataDictionary error:&err];
    tvArray = unitsDM.responseLines;
    
    [DamacSharedClass sharedInstance].unitsArray = [[NSMutableArray alloc]initWithArray:tvArray];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)printDocumentsClick:(UIButton*)sender {
    
    [self dismissDocView];
    
    bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    docView = [[PrintDocView alloc]initWithFrame:CGRectMake(0, 0, 300, 276)];
    [bgView addSubview:docView];
    docView.center = self.view.center;
    [docView.dismissViewBtn addTarget:self action:@selector(dismissDocView) forControlEvents:UIControlEventTouchUpInside];    
    docView.currentUnit = tvArray[sender.tag];
}
-(void)dismissDocView{
    if(docView){
        [bgView removeFromSuperview];
        [docView removeFromSuperview];
        docView = nil;
        bgView = nil;
    }
}
- (void)payNow:(id)sender{
    
    ErrorViewController *errvc =[self.storyboard instantiateViewControllerWithIdentifier:@"errorVC"];
    [self presentViewController:errvc animated:YES completion:nil];
//    BillingViewController *bvc = [self.storyboard instantiateViewControllerWithIdentifier:@"billVC"];
//    [self.navigationController pushViewController:bvc animated:YES];
}

@end
