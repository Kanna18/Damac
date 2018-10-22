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
}
-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)fillCOCDObjectWithCaseID:(BOOL)caseID{
    
    udm = [DamacSharedClass sharedInstance].userProileModel;
    self.RecordType = @"";
    self.UserName = @"";
    self.salesforceId = udm.sfAccountId;
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
-(void)sendDraftStatusToServer:(NSString*)status{
    
    
    ServerAPIManager *serverAp = [ServerAPIManager sharedinstance];
    NSNumber *boo;
    if([status isEqualToString:@"Draft Request"])
    {
        boo = [NSNumber numberWithBool:YES];
    }
  NSDictionary *dict = @{
        @"codCaseWrapper": @{
            @"RecordType":@"Change of Details",
            @"UserName": kUserProfile.emailAddress,
            @"AccountID": kUserProfile.sfAccountId,
            @"AddressLine1": self.AddressLine1,
            @"AddressLine2": self.AddressLine2,
            @"AddressLine3": self.AddressLine3,
            @"AddressLine4": self.AddressLine4,
            @"City": self.City,
            @"State": self.State,
            @"PostalCode": self.PostalCode,
            @"Country": self.Country,
            @"Mobile": self.Mobile,
            @"Email": self.Email,
            @"AddressLine1Arabic": self.AddressLine1Arabic,
            @"AddressLine2Arabic": self.AddressLine2Arabic,
            @"AddressLine3Arabic": self.AddressLine3Arabic,
            @"AddressLine4Arabic": self.AddressLine4Arabic,
            @"CityArabic": self.CityArabic,
            @"StateArabic": self.StateArabic,
            @"PostalCodeArabic": self.PostalCodeArabic,
            @"CountryArabic": self.CountryArabic,
            @"draft": boo,
            @"Status": status,
            @"Origin": @"Mobile app",
            @"fcm": @""
        }
        };
    
    [serverAp postRequestwithUrl:ChangeofDetailsServicesUrl withParameters:dict successBlock:^(id responseObj) {
        if(responseObj){
            NSString *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dic);
        }
        [FTIndicator showToastMessage:@"Draft Saved Successfully"];
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)popToMainVC{
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}

@end
