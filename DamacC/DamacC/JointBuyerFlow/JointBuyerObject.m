//
//  JointBuyerObject.m
//  DamacC
//
//  Created by Gaian on 24/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointBuyerObject.h"

@implementation JointBuyerObject{
    
    NSString *toastMessage;
}
-(instancetype)init{
    self =  [super init];
    if(self){
        
    }
    return self;
}

-(void)fillObjectWithDict:(NSDictionary*)dict{
  
    
    /*Dictionary Format*/
//    {
//        "Account__c" = 0012500000i4XznAAE;
//        "Account__r" =     {
//            Id = 0012500000i4XznAAE;
//            "Party_ID__c" = 1748147;
//            "Passport_Number__pc" = 484101978;
//            attributes =         {
//                type = Account;
//                url = "/services/data/v43.0/sobjects/Account/0012500000i4XznAAE";
//            };
//        };
//        "Booking__c" = a0y25000000vJMXAA2;
//        "Buyer_ID__c" = 3105759;
//        "First_Name__c" = "Barbara Maria";
//        Id = a1m25000000jeFxAAI;
//        "Last_Name__c" = Kennedy;
//        Name = "B-105758";
//        "Primary_Buyer__c" = 0;
//        attributes =     {
//            type = "Buyer__c";
//            url = "/services/data/v43.0/sobjects/Buyer__c/a1m25000000jeFxAAI";
//        };
//    }
    
    self.AccountID = dict[@"Booking__c"];
    self.AdditionalDocFileUrl =@"";// handleNull(dict[@"Booking__c"]);
    self.address1 = handleNull(kUserProfile.addressLine1);//handleNull(dict[@"Booking__c"]);
    self.address2 = handleNull(kUserProfile.addressLine2);//handleNull(dict[@"Booking__c"]);
    self.address3 = handleNull(kUserProfile.addressLine3);//handleNull(dict[@"Booking__c"]);
    self.address4 = @"";//handleNull(dict[@"Booking__c"]);
    self.city = handleNull(kUserProfile.city);//handleNull(dict[@"Booking__c"]);
    self.country = handleNull(kUserProfile.countryOfResidence);//handleNull(dict[@"Booking__c"])
    self.email = handleNull(kUserProfile.emailAddress);//handleNull(dict[@"Booking__c"]);
    self.mobileCountryCode = handleNull(kUserProfile.countryCode);//handleNull(dict[@"Booking__c"]);
    self.origin = @"Mobile App";//handleNull(dict[@"Booking__c"]);
    self.PassportFileUrl = @"";//handleNull(dict[@"Booking__c"]);
    self.phone = handleNull(kUserProfile.phoneNumber);//handleNull(dict[@"Booking__c"]);
    self.postalCode = handleNull(kUserProfile.countryCode);//handleNull(dict[@"Booking__c"]);
    self.RecordType = @"Change of Joint Buyer";
    self.state = @"";
    self.status = @"";
    self.UploadSignedChangeofDetails = @"";
    
}
-(void)changeValueBasedonTag:(UITextField*)textField withValue:(NSString*)str{
    
    int tagValue = textField.tag;
    if(tagValue == MobileJ){
        self.phone = str;
        return;
    }
    if(tagValue == EmailJ){
        self.email = str;
        return;
    }
    if(tagValue == Address1J){
        self.address1 = str;
        return;
    }
    if(tagValue == Address2J){
        self.address2 = str;
        return;
    }
    if(tagValue == Address3J){
        self.address3 = str;
        return;
    }
    if(tagValue == Address4J){
        self.address4 = str;
        return;
    }
    if(tagValue == CityJ){
        self.city = str;
        return;
    }
    if(tagValue == StateJ){
        self.state = str;
        return;
    }
    if(tagValue == PostalCodeJ){
        self.postalCode = str;
        return;
    }
   
}
-(void)sendJointBuyerResponsetoserver{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:kUserProfile.sfAccountId forKey:@"AccountID"];
    [dict setValue:self.AdditionalDocFileUrl forKey:@"AdditionalDocFileUrl"];
    [dict setValue:self.address1 forKey:@"address1"];
    [dict setValue:self.address2 forKey:@"address2"];
    [dict setValue:self.address3 forKey:@"address3"];
    [dict setValue:self.address4 forKey:@"address4"];
    [dict setValue:self.city forKey:@"city"];
    [dict setValue:self.country forKey:@"country"];
    [dict setValue:self.email forKey:@"email"];
    [dict setValue:self.mobileCountryCode forKey:@"mobileCountryCode"];
    [dict setValue:self.origin forKey:@"origin"];
    [dict setValue:self.PassportFileUrl forKey:@"PassportFileUrl"];
    [dict setValue:self.phone forKey:@"phone"];
    [dict setValue:self.postalCode forKey:@"postalCode"];
    [dict setValue:@"Change of Joint Buyer" forKey:@"RecordType"];
    [dict setValue:self.state forKey:@"state"];
    [dict setValue:self.status forKey:@"status"];
    [dict setValue:self.UploadSignedChangeofDetails forKey:@"UploadSignedChangeofDetails"];
    NSDictionary *response = @{@"joinBuyerWraper":dict};
    
    ServerAPIManager *server =[ServerAPIManager sharedinstance];
    [server postRequestwithUrl:JointBuyerServiceUrl withParameters:response successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
            toastMessage = @"Submitted Successfully";
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(void)popToMainVC{
    [FTIndicator showToastMessage:toastMessage];
    [FTIndicator dismissProgress];
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}
@end
