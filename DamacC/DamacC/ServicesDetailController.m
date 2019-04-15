//
//  ServicesDetailController.m
//  DamacC
//
//  Created by Gaian on 18/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ServicesDetailController.h"
#import "SerquestRequestDetailCell.h"
#import "PassportUpdateVC.h"
#import "popObject.h"
#import "PassportObject.h"
#import "JointBuyerObject.h"
#import "ComplaintsObj.h"

//#define ChangeofDetailsServicesUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveChangeOfDetailsCase/"
//#define ComplaintsServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveComplaintFromMobileApp/"
//#define ProofOFPaymentServiceURl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveProofOfPayment/"
//#define JointBuyerServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveJointBuyerDetails/"
//#define PassportUpdateServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveUpdatePassportDetails/"
//
//#define getDetailsBySR @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendCaseDetailToMObileApp/"

#define kPOPConstant            @"Proof of Payment SR"
#define kCODConstant            @"Change of Contact Details"
#define kCOCDWorking            @"Working"
#define kJointBuyerConstant     @"Change of Joint Buyer Details"
#define kPassportUpdateConstant @"Passport Detail Update SR"
#define kPromotionsConstant     @"Promotions"
#define kMortgageConstant       @"Mortgage"
#define kComplaintConstant      @"Complaints SR"


@interface ServicesDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ServicesDetailController{
    ServicesSRDetails *srD;
    NSArray *headingLabels;
    NSArray *dataLabels;
    COCDServerObj *cocd;
    PassportObject *passObj;
    JointBuyerObject *jointBuyerObj;
    ComplaintsObj *complaintsObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.dataSource =self;
    _tableView.delegate =self;
    NSLog(@"%@",_servicesDataModel);
    [self webServiceCall:_srCaseId];
    [FTIndicator showProgressWithMessage:@"" userInteractionEnable:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
//    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"Service Request Detail"];
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Service Request Detail"];
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
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
            
            if([srD.Status isEqualToString:@"Cancelled"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    _cancelBtn.hidden =YES;
                    _editButtonNew.hidden = YES;
                });
                
            }
            if([srD.Status isEqualToString:@"Draft Request"]){
                
                [self ediButtonHideUnhide:NO];
            }
            else{
                [self ediButtonHideUnhide:YES];
            }
        }
    }  errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];

    
}
-(void)fillLabels{
    
    if([srD.Type isEqualToString:kCODConstant]){
        [self fillLabelsforCOCD];
    }
    if([srD.Type isEqualToString:kPOPConstant]){
        [self fillLabelsForPOP];
    }
    if([srD.Type isEqualToString:kPassportUpdateConstant]){
        [self fillLabelsForPassportUpdate];
    }
    if([srD.Type isEqualToString:kJointBuyerConstant]){
        [self fillLabelsForJointBuyer];
    }
    if([srD.Type isEqualToString:kComplaintConstant]){
        [self fillLabelsForComplaints];
    }
    [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
}

-(void)fillLabelsForComplaints{
    headingLabels = @[@"SR No.",
                      @"SR Raised Date",
                      @"Buyer",
                      @"Unit Name",
                      @"SR Type",
                      @"Complaint Type",
                      @"Complaint Sub-Type",
                      @"Complaint Description",
                      @"Attachment1 Url",
                      @"Attachment2 Url"];
    
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    
    dataLabels = @[[NSString stringWithFormat:@"%@ - %@",handleNull(srD.CaseNumber),handleNull(srD.Status)],
                   [self returnDate:srD.CreatedDate],
                   name,
                   handleNull(srD.Unit_Name__c),
                   handleNull(srD.Type),
                   handleNull(srD.Complaint_Type__c),
                   handleNull(srD.Complaint_Sub_Type__c),
                   handleNull(srD.Description),
                   handleNull(srD.OD_File_URL__c),
                   handleNull(srD.Additional_Doc_File_URL__c),
                   ];
    complaintsObj = [[ComplaintsObj alloc]init];
    [complaintsObj fillValuesWithServiceDetails:srD];
}

-(void)fillLabelsForJointBuyer{
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
    
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    
    dataLabels = @[[NSString stringWithFormat:@"%@ - %@",handleNull(srD.CaseNumber),handleNull(srD.Status)],
                   handleNull([self returnDate:srD.CreatedDate]),
                   name,
                   @"",
                   handleNull(srD.Type),
                   handleNull(srD.Country__c),
                   handleNull(srD.Address__c),
                   handleNull(srD.City__c),
                   handleNull(srD.State__c),
                   @"",
                   handleNull(srD.Contact_Email__c),
                   handleNull(srD.Contact_Mobile__c),
                   handleNull(srD.OD_File_URL__c),
                   handleNull(srD.Additional_Doc_File_URL__c),
                   handleNull(srD.Passport_File_URL__c)];
    jointBuyerObj = [[JointBuyerObject alloc]init];
    [jointBuyerObj fillObjectWIthSerViceRequestDetail:srD];
}

-(void)fillLabelsForPassportUpdate{
    
    
    headingLabels = @[@"SR No.",
                      @"SR Raised Date",
                      @"Buyer",
                      @"Unit Name",
                      @"SR Type",
                      @"Passport Number",
                      @"Passport Expiry Date",
                      @"Passport Issue Place",
                      @"Passport File Url",
                      @"Additional Doc File Url"];
    
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    
    dataLabels = @[[NSString stringWithFormat:@"%@ - %@",handleNull(srD.CaseNumber),handleNull(srD.Status)],
                   [self returnDate:srD.CreatedDate],
                   name,
                   @"",
                   handleNull(srD.Type),
                   handleNull(srD.New_CR__c),
                   handleNull(srD.Passport_Issue_Date__c),
                   handleNull(srD.Passport_Issue_Place__c),
                   handleNull(srD.Passport_File_URL__c),
                   handleNull(srD.Additional_Doc_File_URL__c)];
    passObj = [[PassportObject alloc]init];
    [passObj fillValuesWIth:srD];
}


-(void)fillLabelsForPOP{
    
    headingLabels = @[@"SR No.",
                      @"SR Raised Date",
                      @"Buyer",
                      @"Unit Name",
                      @"SR Type",
                      @"Payment Date",
                      @"Total Amount",
                      @"Currency",
                      @"Payment Mode",
                      @"Payment Allocation Details"];
    
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    
    dataLabels = @[[NSString stringWithFormat:@"%@ - %@",handleNull(srD.CaseNumber),handleNull(srD.Status)],
                   [self returnDate:srD.CreatedDate],
                   name,
                   @"",
                   handleNull(srD.Type),
                   handleNull(srD.Payment_Date__c),
                   handleNull(srD.Total_Amount__c),
                   @"",
                   handleNull(srD.Payment_Mode__c),
                   handleNull(srD.Payment_Allocation_Details__c)];
}

-(NSString*)returnDate:(NSString*)dat{
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dt = [format dateFromString:dat];
    [format setDateFormat:@"EEE, d MMM yyyy h:mm a"];
    NSString *output = [format stringFromDate:dt];
    return  output;
    
}
-(void)fillLabelsforCOCD{
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
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    
    dataLabels = @[[NSString stringWithFormat:@"%@ - %@",handleNull(srD.CaseNumber),handleNull(srD.Status)],
                   [self returnDate:srD.CreatedDate],
                   name,
                   @"",
                   handleNull(srD.Type),
                   handleNull(srD.Country__c),
                   handleNull(srD.Address__c),
                   handleNull(srD.City__c),
                   handleNull(srD.State__c),
                   handleNull(srD.Postal_Code__c),
                   handleNull(srD.Contact_Email__c),
                   handleNull(srD.Contact_Mobile__c),
                   handleNull(srD.CRF_File_URL__c),
                   handleNull(srD.Additional_Doc_File_URL__c),
                   handleNull(srD.Passport_File_URL__c)];
    cocd = [[COCDServerObj alloc]init];
    [cocd fillCOCDObjWithCaseID:srD];
}

- (IBAction)cancelButton:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    if([srD.Type isEqualToString:kCODConstant]){
        [FTIndicator showProgressWithMessage:@"" userInteractionEnable:NO];
        cocd.Status = @"Cancelled";
        [cocd sendDraftStatusToServer];
    }
    if([srD.Type isEqualToString:kPOPConstant])
    {
        popObject *pop = [[popObject alloc]init];
        [pop cancelPOPfromServicesSRDetails:srD];
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    }
    if([srD.Type isEqualToString:kPassportUpdateConstant]){
        passObj.status = @"Cancelled";
        [passObj sendPassportResponsetoServer];
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    }
    
    if([srD.Type isEqualToString:kJointBuyerConstant]){
        jointBuyerObj.status = @"Cancelled";
        [jointBuyerObj sendJointBuyerResponsetoserver];
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    }
    if([srD.Type isEqualToString:kComplaintConstant]){
        complaintsObj.Status = @"Cancelled";
        [complaintsObj sendDraftStatusToServer];
        [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    }
    
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"Cancel Service Request"],
                                     kFIRParameterItemName:@"Cancel Service Request",
                                     kFIRParameterContentType:@"Button Clicks"
                                     }];
    [FIRAnalytics setScreenName:@"Service Request Detail" screenClass:NSStringFromClass([self class])];
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
    [_editButtonNew addTarget:self action:@selector(loadEditVC) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if(indexPath.row == 0){
//        if([srD.Status isEqualToString:@"Draft Request"]){
////            cell.editButton.hidden = NO;
//            cell.editButton.hidden = YES;
//            [self ediButtonHideUnhide:NO];
//        }else{
//            cell.editButton.hidden = YES;
//            [self ediButtonHideUnhide:YES];
//        }
//    }else{
        cell.editButton.hidden = YES;
//    }

    return cell;
    
}
-(void)ediButtonHideUnhide:(BOOL)bo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(bo){
            _editButtonNew.hidden = YES;
            _xaxix.constant = 0;
        }else{
            _editButtonNew.hidden = NO;
        }
    });
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SerquestRequestDetailCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    NSString *url = cell.label2.text;
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//- (IBAction)editButtonClick:(id)sender {
//
//    if([_servicesDataModel.RecordType.Name isEqualToString:kJointBuyerConstant]){
//
//        RentalPoolViewCellViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"rentalPoolViewCellVC"];
//        [self.navigationController pushViewController:rvc animated:YES];
//    }
//    if([_servicesDataModel.RecordType.Name isEqualToString:kPOPConstant]){
//        ChangeOfContactDetails *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"changeOfContactsVC"];
//        [self.navigationController pushViewController:rvc animated:YES];
//    }
//}

-(void)loadEditVC{
    if([srD.Type isEqualToString:kCODConstant]){
        ChangeOfContactDetails *chd = [self.storyboard instantiateViewControllerWithIdentifier:@"changeOfContactsVC"];
        chd.cocdOBj = cocd;
        [self.navigationController pushViewController:chd animated:YES];
    }
    if([srD.Type isEqualToString:kPassportUpdateConstant]){
        PassportUpdateVC *chd = [self.storyboard instantiateViewControllerWithIdentifier:@"passportUpdateVC"];
        chd.passportObj = passObj;
        chd.srdRental = srD;
        [self.navigationController pushViewController:chd animated:YES];
    }
    if([srD.Type isEqualToString:kJointBuyerConstant]){
        RentalPoolViewCellViewController *chd = [self.storyboard instantiateViewControllerWithIdentifier:@"rentalPoolViewCellVC"];
        chd.jointObj = jointBuyerObj;
        chd.srdRental = srD;
        [self.navigationController pushViewController:chd animated:YES];
    }
    if([srD.Type isEqualToString:kComplaintConstant]){
        ComplaintsViewController *chd = [self.storyboard instantiateViewControllerWithIdentifier:@"complaintsViewController"];
        chd.complaintsObj= complaintsObj;
        chd.srdRental = srD;
        [self.navigationController pushViewController:chd animated:YES];
    }
    
    
}

@end
