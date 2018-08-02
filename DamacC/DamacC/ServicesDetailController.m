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
    
    
}


#pragma mark Tableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5  ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseCell = @"serviceRequestDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    
    switch (indexPath.row) {
        case 0:{
            NSString *txt = [NSString stringWithFormat:@"SR No:%@",_servicesDataModel.CaseNumber];
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

@end
