//
//  COCDServerObj.m
//  DamacC
//
//  Created by Gaian on 16/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//


#import "COCDServerObj.h"



@implementation COCDServerObj{
    
    UserDetailsModel *udm;
    NSString *toastMessage;
}
-(instancetype)init{
    self = [super init];
    if(self){
        udm = [DamacSharedClass sharedInstance].userProileModel;
    }
    return self;
}

-(void)fillCOCDObjectWithOutCaseID{
    self.RecordType = @"Change of Details";
    self.UserName = kUserProfile.partyName;
    self.salesforceId = kUserProfile.sfAccountId;
    self.AccountID = udm.sfContactId;
    self.AddressLine1 = udm.addressLine1;
    self.AddressLine2 = udm.addressLine2;
    self.AddressLine3 = @"Enter Address3";
    self.AddressLine4 = @"Enter Address3";
    self.City = [NSString stringWithFormat:@"%@",udm.city];
    self.State = @"Enter State";
    self.PostalCode = @"Enter Postal Code";
    self.Country = udm.countryOfResidence;
    self.Mobile = [NSString stringWithFormat:@"%@%@%@",udm.phoneCountry,udm.phoneAreaCode,udm.phoneNumber];
    self.Email = [NSString stringWithFormat:@"%@",udm.emailAddress];
    self.AddressLine1Arabic = @"";
    self.AddressLine2Arabic = @"";
    self.AddressLine3Arabic = @"";
    self.AddressLine4Arabic = @"";
    self.CityArabic = @"";
    self.StateArabic = @"";
    self.PostalCodeArabic = @"";
    self.CountryArabic = @"";
    self.draft = @"";
    self.Status = @"";
    self.Origin = @"";
    self.fcm = @"";
    self.salesforceId = @"";
}

-(void)fillCOCDObjWithCaseID:(ServicesSRDetails*)srd{
    
    self.RecordType = handleNull(srd.RecordTypeId);
    self.UserName = @"";
    self.salesforceId = handleNull(udm.sfAccountId);
    self.AccountID = handleNull(udm.sfContactId);
    self.AddressLine1 = handleNull(srd.Address__c);
    self.AddressLine2 = handleNull(srd.Address_2__c);
    self.AddressLine3 = handleNull(srd.Address_3__c);
    self.AddressLine4 = handleNull(srd.Address_4__c);
    self.City = handleNull(srd.City__c);
    self.State = handleNull(srd.State__c);
    self.PostalCode = @"Enter Postal Code";
    self.Country = handleNull(srd.Country__c);
    self.Mobile = handleNull(srd.Contact_Mobile__c);
    self.Email = handleNull(srd.Contact_Email__c);
    self.AddressLine1Arabic = @"";
    self.AddressLine2Arabic = @"";
    self.AddressLine3Arabic = @"";
    self.AddressLine4Arabic = @"";
    self.CityArabic = @"";
    self.StateArabic = @"";
    self.PostalCodeArabic = @"";
    self.CountryArabic = @"";
    self.draft = @"";
    self.Status = @"";
    self.Origin = @"";
    self.fcm = @"";
    self.salesforceId = handleNull(srd.Id);
}
-(void)changeValueBasedonTag:(UITextField*)textField withValue:(NSString*)str{
    
    int tagValue = textField.tag;
    if(tagValue == Mobile){
        self.Mobile = str;
        return;
    }
    if(tagValue == Email){
        self.Email = str;
        return;
    }
    if(tagValue == Address1){
        self.AddressLine1 = str;
        return;
    }
    if(tagValue == Address2){
        self.AddressLine2 = str;
        return;
    }
    if(tagValue == Address3){
        self.AddressLine3 = str;
        return;
    }
    if(tagValue == Address4){
        self.AddressLine4 = str;
        return;
    }
    if(tagValue == City){
        self.City = str;
        return;
    }
    if(tagValue == State){
        self.State = str;
        return;
    }
    if(tagValue == PostalCode){
        self.PostalCode = str;
        return;
    }
    if(tagValue == Address1Arabic){
        self.AddressLine1Arabic = str;
        return;
    }
    if(tagValue == CityArabic){
        self.CityArabic = str;
        return;
    }
    if(tagValue == CountryArabic){
        self.CountryArabic = str;
        return;
    }
    if(tagValue == StateInArabic){
        self.StateArabic = str;
        return;
    }
}
-(void)sendDraftStatusToServer{
    
    ServerAPIManager *serverAp = [ServerAPIManager sharedinstance];
    NSNumber *boo;
    
    if([self.Status isEqualToString:@"Draft Request"])
    {
        boo = [NSNumber numberWithBool:YES];
    }
    if([self.Status isEqualToString:@"Cancelled"]||[self.Status isEqualToString:@"Submitted"])
    {
        boo = [NSNumber numberWithBool:NO];
    }
   
    NSMutableDictionary *wrapperDict = [[NSMutableDictionary alloc]init];
    [wrapperDict setValue:@"Change of Details" forKey:@"RecordType"];
    [wrapperDict setValue:kUserProfile.emailAddress forKey:@"UserName"];
    [wrapperDict setValue:kUserProfile.sfAccountId forKey:@"AccountID"];
    [wrapperDict setValue:self.AddressLine1 forKey:@"AddressLine1"];
    [wrapperDict setValue:self.AddressLine2 forKey:@"AddressLine2"];
    [wrapperDict setValue:self.AddressLine3 forKey:@"AddressLine3"];
    [wrapperDict setValue:self.AddressLine4 forKey:@"AddressLine4"];
    [wrapperDict setValue:self.City forKey:@"City"];
    [wrapperDict setValue:self.State forKey:@"State"];
    [wrapperDict setValue:self.PostalCode forKey:@"PostalCode"];
    [wrapperDict setValue:self.Country forKey:@"Country"];
    [wrapperDict setValue:self.Mobile forKey:@"Mobile"];
    [wrapperDict setValue:self.Email forKey:@"Email"];
    [wrapperDict setValue:self.AddressLine1Arabic forKey:@"AddressLine1Arabic"];
    [wrapperDict setValue:self.AddressLine2Arabic forKey:@"AddressLine2Arabic"];
    [wrapperDict setValue:self.AddressLine3Arabic forKey:@"AddressLine3Arabic"];
    [wrapperDict setValue:self.AddressLine4Arabic forKey:@"AddressLine4Arabic"];
    [wrapperDict setValue:self.CityArabic forKey:@"CityArabic"];
    [wrapperDict setValue:self.StateArabic forKey:@"StateArabic"];
    [wrapperDict setValue:self.PostalCodeArabic forKey:@"PostalCodeArabic"];
    [wrapperDict setValue:self.CountryArabic forKey:@"CountryArabic"];
    [wrapperDict setValue:boo forKey:@"draft"];
    [wrapperDict setValue:self.Status forKey:@"Status"];
    [wrapperDict setValue:@"Mobile app" forKey:@"Origin"];
    [wrapperDict setValue:handleNull(self.cocdUploadedImagePath) forKey:@"crfFormUrl"];
    [wrapperDict setValue:handleNull(self.additionalImageUploadedImagePath) forKey:@"additionalDocUrl"];
    [wrapperDict setValue:handleNull(self.primaryPassportUploadedImagePath) forKey:@"passportFileUrl"];
    
    [wrapperDict setValue:@"" forKey:@"fcm"];
    if(self.salesforceId.length>0){
    [wrapperDict setValue:self.salesforceId forKey:@"salesforceId"];
    }
    
  NSDictionary *dict = @{
        @"codCaseWrapper": wrapperDict
        };
    
    [serverAp postRequestwithUrl:ChangeofDetailsServicesUrl withParameters:dict successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dic);
        }
        [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)popToMainVC{
    
    if([self.Status isEqualToString:@"Draft Request"]){
        toastMessage= @"SR has been sucessufully saved";
    }
    if([self.Status isEqualToString:@"Submitted"]){
        toastMessage= @"SR has been sucessufully Submitted";
    }
    if([self.Status isEqualToString:@"Cancelled"]){
       toastMessage= @"SR has been sucessufully Cancelled";
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
