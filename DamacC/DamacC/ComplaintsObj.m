//
//  ComplaintsObj.m
//  DamacC
//
//  Created by Gaian on 26/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ComplaintsObj.h"

@implementation ComplaintsObj{
    
    NSString *toastMessage;
}

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)fillWithDefaultValues{
    
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    self.userId = sf.currentUser.credentials.userId;
    self.AccountID = kUserProfile.sfAccountId;
    self.Description = @"";
    self.BookingUnit = @"";
    self.ComplaintType = @"";
    self.ComplaintSubType = @"";
    self.Status = @"";
    
}
-(void)fillValuesWithServiceDetails:(ServicesSRDetails*)srd{
 
//    00525000003ptSPAAY Android
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    self.userId = sf.currentUser.idData.userId;

    self.AccountID = kUserProfile.sfAccountId;
    self.Description = srd.Description;
    self.BookingUnit = srd.Booking_Unit_Name__c;
    self.ComplaintType = srd.Complaint_Type__c;
    self.ComplaintSubType = srd.Complaint_Sub_Type__c;
    self.Status = @"";
    self.salesforceId = srd.Id;
    self.attactment1Path = handleNull(srd.OD_File_URL__c);
    self.attactment2Path = handleNull(srd.Additional_Doc_File_URL__c);
}

-(void)sendDraftStatusToServer{
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:self.userId forKey:@"userId"];
    [dict setValue:self.AccountID forKey:@"AccountID"];
    [dict setValue:self.Description forKey:@"Description"];
    [dict setValue:self.BookingUnit forKey:@"BookingUnit"];
    [dict setValue:self.ComplaintType forKey:@"ComplaintType"];
    [dict setValue:self.ComplaintSubType forKey:@"ComplaintSubType"];
    [dict setValue:self.attactment2Path forKey:@"Attachment1Url"];
    [dict setValue:self.attactment1Path forKey:@"Attachment2Url"];
    [dict setValue:self.Status forKey:@"Status"];
    if(self.salesforceId.length>0){
        [dict setValue:self.salesforceId forKey:@"salesforceId"];
    }
    
    NSDictionary *resp = @{@"saveComplaintWrapper": dict};
    ServerAPIManager *serverAp = [ServerAPIManager sharedinstance];
    [serverAp postRequestwithUrl:ComplaintsServiceUrl withParameters:resp successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dic);
        }
        [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
    }  errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];

}
-(void)popToMainVC{
    
    if([self.Status isEqualToString:@"Cancelled"]){
        toastMessage = @"Complaint has been Cancelled successfully";
    }
    if([self.Status isEqualToString:@"Draft Request"]){
        toastMessage = @"Complaint has been successfully saved";
    }
    if([self.Status isEqualToString:@"Submitted"]){
        toastMessage = @"Complaint has been submitted successfully";
    }
    
    [FTIndicator showToastMessage:toastMessage];
    [FTIndicator dismissProgress];
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            dispatch_async(dispatch_get_main_queue(), ^{
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
            });
            
        }
    }
}
    
    @end
