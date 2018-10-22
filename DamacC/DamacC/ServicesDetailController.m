//
//  ServicesDetailController.m
//  DamacC
//
//  Created by Gaian on 18/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ServicesDetailController.h"
#import "SerquestRequestDetailCell.h"


//#define ChangeofDetailsServicesUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveChangeOfDetailsCase/"
#define ComplaintsServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveComplaintFromMobileApp/"
#define ProofOFPaymentServiceURl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveProofOfPayment/"
#define JointBuyerServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveJointBuyerDetails/"
#define PassportUpdateServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveUpdatePassportDetails/"

#define getDetailsBySR @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendCaseDetailToMObileApp/"

#define kPOPConstant            @"POP"
#define kCODConstant            @"Change of Contact Details"
#define kJointBuyerConstant     @"Change of Joint Buyer"
#define kPassportUpdateConstant @""
#define kPromotionsConstant     @"Promotions"
#define kMortgageConstant       @"Mortgage"
#define kComplaintConstant      @"Complaint"


@interface ServicesDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ServicesDetailController{
    ServicesSRDetails *srD;
    NSArray *headingLabels;
    NSArray *dataLabels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    _tableView.dataSource =self;
    _tableView.delegate =self;
    NSLog(@"%@",_servicesDataModel);
    [self webServiceCall:_srCaseId];
    if([_servicesDataModel.Status isEqualToString:@"Draft Request"]){
        headingLabels = @[@"SR No.",
                          @"SR Raised Date",
                          @"Buyer",
                          @"Unit Name",
                          @"SR Type",
                          @"Country",
                          @"Address",
                          @"City",
                          @"State",
                          @"Postal Code",
                          @"Email",
                          @"Mobile",
                          @"COCD Form Url",
                          @"Addition Doc File Url",
                          @"Passport File Url"];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"Service Request Detail"];
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
            [self fillLabels];
            [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
}
-(void)fillLabels{
    
    dataLabels = @[[NSString stringWithFormat:@"%@ - %@",_servicesDataModel.CaseNumber,_servicesDataModel.Status],
                   [self returnDate:_servicesDataModel.CreatedDate],
                   [NSString stringWithFormat:@"%@",_servicesDataModel.Account.Name],
                   @"",
                   srD.SR_Type__c,
                   srD.Country__c,
                   srD.Address__c,
                   srD.City__c,
                   srD.State__c,
                   @"",
                   srD.Contact_Email__c,
                   srD.Contact_Mobile__c,
                   @"",
                   @"",
                   @""];
    
}
-(NSString*)returnDate:(NSString*)dat{
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dt = [format dateFromString:dat];
    [format setDateFormat:@"EEE, d MMM yyyy h:mm a"];
    NSString *output = [format stringFromDate:dt];
    return  output;
    
}

- (IBAction)cancelButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark Tableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return headingLabels.count  ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseCell = @"serquestRequestDetailCell";
    SerquestRequestDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    cell.label1.text =headingLabels[indexPath.row];
    cell.label2.text = dataLabels[indexPath.row];
    [cell.editButton addTarget:self action:@selector(loadEditVC) forControlEvents:UIControlEventTouchUpInside];
    if(indexPath.row == 0){
        cell.editButton.hidden = NO;
    }else{
        cell.editButton.hidden = YES;
    }

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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

//-(void)cancelChangeOfDetails{
//    ServerAPIManager *ap = [ServerAPIManager sharedinstance];
//    NSDictionary *dict = @{@"codCaseWrapper":@{    @"RecordType": @"Change of Details",
//                                                   @"UserName":  kUserProfile.emailAddress,
//                                                   @"salesforce Id": kUserProfile.sfAccountId,
//                                                   @"AccountID": kUserProfile.partyId,
//                                                   @"AddressLine1": kUserProfile.addressLine1,
//                                                   @"AddressLine2": kUserProfile.addressLine2,
//                                                   @"AddressLine3": kUserProfile.addressLine3,
//                                                   @"AddressLine4": kUserProfile.addressLine3,
//                                                   @"City": kUserProfile.city,
//                                                   @"State": @"",
//                                                   @"Postal Code": @"",
//                                                   @"Country": @"",
//                                                   @"Mobile": kUserProfile.phoneNumber,
//                                                   @"Email": kUserProfile.emailAddress,
//                                                   @" AddressLine1Arabic": @"",
//                                                   @"AddressLine2Ara bic": @"",
//                                                   @"AddressLine 3Arabic": @"",
//                                                   @"Address Line4Arabic": @"",
//                                                   @"CityArabic": @"",
//                                                   @"StateArabic": @"",
//                                                   @"PostalCodeArabic": @"",
//                                                   @"CountryArabic": @"",
//                                                   @"draft": @"true",
//                                                   @"Status": @"Draft Request",
//                                                   @"Origin": @"Mobile app",
//                                                   @"fcm": @"eatJZYr Hz_k:APA91bGU56e FMo4NvzbBAT8TzI uXkXTukWXrTIFqy kDS16xj4AFrK8ChO m- V4UGwp9zuEJb_lUc tc4b9X7oZOwGCfRb CVFdvad1o9mESkC nSRxkHKHZCH9NR cPXVO2hBH3t_DjO kQOuO5Lj7sDwTHx SE7dbzagO9zw"
//                                                   }};
//
//
////    [ap postRequestwithUrl:ChangeofDetailsServicesUrl withParameters:<#(NSDictionary *)#> successBlock:<#^(id responseObj)success#> errorBlock:<#^(NSError *error)errorBlock#>]po
//}

-(void)loadEditVC{
    
    if([srD.SR_Type__c isEqualToString:kCODConstant]){
        ChangeOfContactDetails *chd = [self.storyboard instantiateViewControllerWithIdentifier:@"changeOfContactsVC"];
        [self.navigationController pushViewController:chd animated:YES];
    }
}

@end
