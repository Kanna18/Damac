//
//  ServicesDetailController.m
//  DamacC
//
//  Created by Gaian on 18/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ServicesDetailController.h"

#define ChangeofDetailsServicesUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveChangeNameOfNationalityCase/"
#define ComplaintsServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveComplaintFromMobileApp/"
#define ProofOFPaymentServiceURl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveProofOfPayment/"
#define JointBuyerServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveJointBuyerDetails/"
#define PassportUpdateServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveUpdatePassportDetails/"

#define getDetailsBySR @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendCaseDetailToMObileApp/"

#define kPOPConstant            @"POP"
#define kCODConstant            @"Change of Details"
#define kJointBuyerConstant     @"Change of Joint Buyer"
#define kPassportUpdateConstant @""
#define kPromotionsConstant     @"Promotions"
#define kMortgageConstant       @"Mortgage"
#define kComplaintConstant      @"Complaint"

@interface ServicesDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ServicesDetailController{
    ServicesSRDetails *srD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.dataSource =self;
    _tableView.delegate =self;
    NSLog(@"%@",_servicesDataModel);
    [self webServiceCall:_srCaseId];
    if([_servicesDataModel.Status isEqualToString:@"Draft Request"]){
        _editButton.hidden=NO;
    }
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

-(void)webServiceCall:(NSString*)str{
    
    ServerAPIManager *ap = [ServerAPIManager sharedinstance];
    
    [ap postRequestwithUrl:getDetailsBySR withParameters:@{@"caseNo":_srCaseId} successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            srD = [[ServicesSRDetails alloc]initWithDictionary:dict error:nil];
            NSLog(@"%@",srD);
            [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
}

- (IBAction)cancelButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark Tableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4  ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseCell = @"serviceRequestDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    switch (indexPath.row) {
        case 0:{
            NSString *txt = [NSString stringWithFormat:@"SR No:%@- %@",_servicesDataModel.CaseNumber,_servicesDataModel.Status];
            cell.textLabel.text =txt;
        }
            break;
        case 1:{
            NSDateFormatter *format = [[NSDateFormatter alloc]init];
            [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSDate *dt = [format dateFromString:_servicesDataModel.CreatedDate];
           
            [format setDateFormat:@"EEE, d MMM yyyy h:mm a"];
            NSString *output = [format stringFromDate:dt];
            
            NSString *txt = [NSString stringWithFormat:@"SR Raised Date:%@",output];
            cell.textLabel.text =txt;
        }
            break;
        case 2:{
            NSString *txt = [NSString stringWithFormat:@"Buyer:%@",_servicesDataModel.Contact.Name];
            cell.textLabel.text =txt;
        }
            break;
        case 3:{
            NSString *txt = [NSString stringWithFormat:@"Unit Name:%@",srD.Booking_Unit_Name__c];
            cell.textLabel.text =txt;
        }
            break;
        default:
            break;
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)editButtonClick:(id)sender {
    
    if([_servicesDataModel.RecordType.Name isEqualToString:kJointBuyerConstant]){
        
        RentalPoolViewCellViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"rentalPoolViewCellVC"];
        [self.navigationController pushViewController:rvc animated:YES];
    }
    if([_servicesDataModel.RecordType.Name isEqualToString:kPOPConstant]){
        ChangeOfContactDetails *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"changeOfContactsVC"];
        [self.navigationController pushViewController:rvc animated:YES];
    }
}

@end
