//
//  ServicesTableViewController.m
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ServicesTableViewController.h"
#import "VCFloatingActionButton.h"
#import "AppDelegate.h"
#import "BillingViewController.h"
#import "PaymentsViewController.h"

@interface ServicesTableViewController ()<floatMenuDelegate>

@end
static NSString *reuseCell = @"servicesCell";

@implementation ServicesTableViewController{
    
    NSArray *tvArray;
    NSDictionary *dataDictionary;
    UnitsDataModel *unitsDM;
    PaymentsDataModel *paymentsDM;
    ReceiptDataModel *receiptsDM;
    
    CGFloat headerHeight,scr_width,scr_height;
    VCFloatingActionButton *addButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if(_loadingpayments){
        headerHeight =80;
    }else{
        headerHeight =80;
    }
    if([_typeOfvc isEqualToString:kMyServiceRequests]){
    tvArray = @[@"MyServices1",@"MyServices2",@"MyServices3",@"MyServices4",@"MyServices5",@"MyServices6",@"MyServices7"];
    }
//    self.navigationController.navigationBar.topItem.title = [_typeOfvc stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    UIImageView  *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImage2.jpg"]];
    [self.tableView setBackgroundView:boxBackView];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [FTIndicator showProgressWithMessage:@"Loading"];
    [self webServiceCall];
//    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:4];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    scr_width = [UIScreen mainScreen].bounds.size.width;
    scr_height = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationController.navigationBar.topItem.title = @" ";
    
    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"My units"];
//    [_typeOfvc stringByReplacingOccurrencesOfString:@"\n" withString:@" "]

}

-(void)loadFoatMenu{
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    addButton = [[VCFloatingActionButton alloc]initWithFrame:CGRectMake(scr_width-70, scr_height-70, 44, 44) normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"] withScrollview:nil];
    addButton.imageArray = @[@"fb-icon",@"twitter-icon",@"google-icon",@"linkedin-icon",@"linkedin-icon"];
    addButton.labelArray = @[@"Chat",@"Schedule Appointments",@"Profile",@"Dail CRM",@"Create E-Services"];
    addButton.hideWhileScrolling = YES;
    addButton.delegate = self;
    [win addSubview:addButton];
//    [self.tableView addSubview:addButton];
}

#pragma mark FloatingMenu Delegate
-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
    NSLog(@"Floating action tapped index %tu",row);
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
    if([_typeOfvc isEqualToString:kMyUnits]||[_typeOfvc isEqualToString:kMyPaymentScedules]||[_typeOfvc isEqualToString:kPay]){
        unitsDM = [[UnitsDataModel alloc]initWithDictionary:dataDictionary error:&err];
        tvArray = unitsDM.responseLines;
    }else if ([_typeOfvc isEqualToString:kMyReceipts]){
        receiptsDM = [[ReceiptDataModel alloc]initWithDictionary:dataDictionary error:&err];
        tvArray = receiptsDM.responseLines;
    }
    else if(_loadingpayments){
        paymentsDM = [[PaymentsDataModel alloc]initWithDictionary:dataDictionary error:&err];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"description_payment" ascending:YES];
        tvArray = [paymentsDM.responseLines sortedArrayUsingDescriptors:@[sort]];
    }
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tvArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    if([_typeOfvc isEqualToString:kMyUnits]||[_typeOfvc isEqualToString:kMyPaymentScedules]||[_typeOfvc isEqualToString:kPay]){
        ResponseLine *rs = tvArray[indexPath.row];
       cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@",rs.unitNumber,rs.unitType,rs.totalInvoiced];
    }
    if([_typeOfvc isEqualToString:kMyReceipts]){
        ReceiptResponseLines *rs = tvArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@",rs.cashReceiptId,rs.customerName,rs.receiptReference];
    }
    if(_loadingpayments){
        ResponseLinePayments *rsPayment = tvArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ ",rsPayment.description_payment,rsPayment.milestoneEvent];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_typeOfvc isEqualToString:kMyUnits]){
        DetailMyUnitsViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailMyUnitsVC"];
        dvc.responseUnit = tvArray[indexPath.row];
        [self.navigationController pushViewController:dvc animated:YES];
    }if([_typeOfvc isEqualToString:kMyPaymentScedules]){
//        ServicesTableViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"servicesTableVC"];
//        ResponseLine *rs = tvArray[indexPath.row];
//        Action *act = rs.actions[0];
//        svc.serverUrlString = act.url;
//        svc.loadingpayments=YES;
//        [self.navigationController pushViewController:svc animated:YES];
        
        PaymentsViewController *paym = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
        ResponseLine *rs = tvArray[indexPath.row];
        Action *act = rs.actions[0];
        paym.serverUrlString = act.url;
        [self.navigationController pushViewController:paym animated:YES];
    
    }if([_typeOfvc isEqualToString:kPay]){
        ErrorViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"errorVC"];
        [self presentViewController:evc animated:YES completion:nil];
//        BillingViewController *bvc = [self.storyboard instantiateViewControllerWithIdentifier:@"billVC"];
////        bvc.responseUnit = tvArray[indexPath.row];
//        [self.navigationController pushViewController:bvc animated:YES];
    }
    
}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
////    UIImageView *imgVw = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backgroundImage2"]];
////    imgVw.frame = tableView.tableHeaderView.frame;
//    UIView *imgVw =[[UIView alloc]init];
//    imgVw.frame = tableView.tableHeaderView.frame;
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(10, 10, scr_width-20, 60);
//    [btn setTitle:self.typeOfvc forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neuel" size:16];
//    btn.titleLabel.textColor = rgb(174, 134, 73);
//    btn.backgroundColor = rgb(76, 97, 125);
//    btn.layer.cornerRadius = 10;
//    btn.layer.borderWidth = 1.0f;
//    btn.layer.borderColor =  rgb(174, 134, 73).CGColor;
//    [imgVw addSubview:btn];
//    return  imgVw;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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

@end
