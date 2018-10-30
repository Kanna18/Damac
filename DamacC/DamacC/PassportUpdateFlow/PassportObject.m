//
//  PassportObject.m
//  DamacC
//
//  Created by Gaian on 24/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportObject.h"

@implementation PassportObject{
    
    NSString *toastMessage;
}

-(instancetype)init{
    self =  [super init];
    if(self){
        
    }
    return self;
}
-(void)fillWithDefaultValues{
    self.RecordType = @"Passport Detail Update";
    self.AccountID = handleNull(kUserProfile.sfAccountId);
    self.origin = @"Mobile App";
    self.fcm = @"";
    self.AdditionalDocFileUrl = @"";
    self.passportNo = @"";
    self.PassportIssuedPlace = @"";
    self.AdditionalDocFileUrl = @"";
    self.PassportIssuedPlaceArabic = @"";
    self.PassportIssuedDate = @"";
    
    self.previousPPNumber = handleNull(kUserProfile.passportNumber);
    self.previousPassPlace = handleNull(kUserProfile.ppIssuePlace);
    self.previousExpiryDate = handleNull(kUserProfile.ppIssueDate);
    
}
-(void)fillDefaultValuesForParticularBuyer:(NSDictionary*)buyerDict{
    
    self.previousPPNumber = handleNull(buyerDict[@"Account__r"][@"Passport_Number__pc"]);
    self.previousPassPlace = @"";
    self.previousExpiryDate = handleNull(kUserProfile.ppIssueDate);
    
    
    self.RecordType = @"Passport Detail Update";
    self.AccountID = handleNull(buyerDict[@"Account__r"][@"Id"]);
    self.origin = @"Mobile App";
    self.fcm = @"";
    self.AdditionalDocFileUrl = @"";
    self.passportNo = @"";
    self.PassportIssuedPlace = @"";
    self.AdditionalDocFileUrl = @"";
    self.PassportIssuedPlaceArabic = @"";
    self.PassportIssuedDate = @"";
}

-(void)sendPassportResponsetoServer{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Passport Detail Update" forKey:@"RecordType"];
    [dict setValue:self.AccountID forKey:@"AccountID"];
    [dict setValue:self.status forKey:@"status"];
    [dict setValue:@"Mobile App" forKey:@"origin"];
    [dict setValue:@"" forKey:@"fcm"];
    [dict setValue:self.passportImagePath forKey:@"PassportFileUrl"];
    [dict setValue:self.additionalImagePath forKey:@"AdditionalDocFileUrl"];
    [dict setValue:self.passportNo forKey:@"passportNo"];
    [dict setValue:self.PassportIssuedPlace forKey:@"PassportIssuedPlace"];
    [dict setValue:self.PassportIssuedPlaceArabic forKey:@"PassportIssuedPlaceArabic"];
    [dict setValue:self.PassportIssuedDate forKey:@"PassportIssuedDate"];
    if(self.salesforceId.length>0){
        [dict setValue:self.salesforceId forKey:@"salesforceId"];
    }
    NSDictionary *response =   @{@"passPortUpdateWraper":dict};
    
    ServerAPIManager *server =[ServerAPIManager sharedinstance];
    [server postRequestwithUrl:PassportUpdateServiceUrl withParameters:response successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dict);
            [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(void)fillValuesWIth:(ServicesSRDetails *)srd{
    
    self.RecordType = @"Passport Detail Update";
    self.AccountID = handleNull(srd.AccountId);
    self.origin = @"Mobile App";
    self.fcm = @"";
    self.AdditionalDocFileUrl = handleNull(srd.Additional_Doc_File_URL__c);
    self.passportNo = handleNull(srd.New_CR__c);
    self.PassportIssuedPlace = handleNull(srd.Passport_Issue_Place__c);
    self.PassportIssuedPlaceArabic = @"";
    self.PassportIssuedDate = handleNull(srd.Passport_Issue_Date__c);
    self.salesforceId = handleNull(srd.Id);
    
    self.previousPPNumber = handleNull(srd.New_CR__c);
    self.previousPassPlace = handleNull(srd.Passport_Issue_Place__c);
    self.previousExpiryDate = handleNull(srd.Passport_Issue_Date__c);
}

-(void)popToMainVC{
    
    if([self.status isEqualToString:@"Cancelled"]){
        toastMessage = @"SR has been Cancelled successfully";
    }
    if([self.status isEqualToString:@"Draft Request"]){
        toastMessage = @"Draft has been Successfully saved";
    }
    if([self.status isEqualToString:@"Submitted"]){
        toastMessage = @"Submitted Successfully";
    }
    
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
