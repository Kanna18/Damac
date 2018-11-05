//
//  NotificationsTableVC.m
//  DamacC
//
//  Created by Gaian on 01/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "NotificationsTableVC.h"
#import "NotificationsCell.h"
#import "ServicesDetailController.h"
@interface NotificationsTableVC ()

@end

@implementation NotificationsTableVC{
    
    NSArray *tvData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getListOfNotifications];
    
    
}

-(void)getListOfNotifications{
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server postRequestwithUrl:@"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendNotificationsToMobileApp/" withParameters:@{@"accountId":sf.currentUser.credentials.userId} successBlock:^(id responseObj) {
        if(responseObj){
            tvData =[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",tvData);
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return tvData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationsCell" forIndexPath:indexPath];
    if(indexPath.row %2 == 0){
        cell.contentView.backgroundColor = rgb(30, 30, 30);
    }else{
        cell.contentView.backgroundColor = rgb(50, 50, 50);
    }
    NSArray *arr = [[tvData[indexPath.row] valueForKey:@"Notification_Text__c"] componentsSeparatedByString:@" "];
    cell.label1.text = arr.lastObject;
    cell.label2.text = [tvData[indexPath.row] valueForKey:@"Notification_Text__c"];
    cell.label3.text =  [self returnDate:[tvData[indexPath.row] valueForKey:@"CreatedDate"]];
    cell.label3.adjustsFontSizeToFitWidth = YES;
    cell.label2.adjustsFontSizeToFitWidth = YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServicesDetailController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"servicesDetailVC"];
    NSArray *arr = [[tvData[indexPath.row] valueForKey:@"Notification_Text__c"] componentsSeparatedByString:@" "];
    svc.srCaseId = arr.lastObject;;
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(NSString*)returnDate:(NSString*)dat{
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dt = [format dateFromString:dat];
    [format setDateFormat:@"EEE, d MMM yyyy h:mm a"];
    NSString *output = [format stringFromDate:dt];
    return  output;
    
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
