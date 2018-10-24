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
    if(self.salesforceId){
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
    self.AdditionalDocFileUrl = handleNull(srd.Passport_File_URL__c);
    self.passportNo = handleNull(srd.New_CR__c);
    self.PassportIssuedPlace = handleNull(srd.Passport_Issue_Place__c);
    self.AdditionalDocFileUrl = handleNull(srd.Additional_Doc_File_URL__c);
    self.PassportIssuedPlaceArabic = @"";
    self.PassportIssuedDate = handleNull(srd.Passport_Issue_Date__c);
    self.salesforceId = handleNull(srd.Id);
}

-(void)popToMainVC{
    
    if([self.status isEqualToString:@"Cancelled"]){
        toastMessage = @"SR has benn Cancelled";
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