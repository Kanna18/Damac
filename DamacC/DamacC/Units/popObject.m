//
//  popObject.m
//  DamacC
//
//  Created by Gaian on 10/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "popObject.h"

@implementation popObject
-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;    
}
-(void)cancelPOPfromServicesSRDetails:(ServicesSRDetails*)srD{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"POP" forKey:@"RecordType"];
    [dict setValue:srD.RecordTypeId forKey:@"AccountID"];
    [dict setValue:@"" forKey:@"fileName"];
    [dict setValue:@"" forKey:@"AttachmentURL"];
    [dict setValue:srD.Total_Amount__c forKey:@"Totalamount"];
    [dict setValue:srD.Payment_Allocation_Details__c forKey:@"PARemark"];
    [dict setValue:srD.Payment_Mode__c forKey:@"PaymentMode"];
    [dict setValue:srD.Payment_Date__c forKey:@"PaymentDate"];
    [dict setValue:@"" forKey:@"PaymentCurrency"];
    [dict setValue:srD.Sender_Name__c forKey:@"SenderName"];
    [dict setValue:srD.Cheque_Bank_Name__c forKey:@"BankName"];
    [dict setValue:srD.Swift_Code__c forKey:@"SwiftCode"];
    [dict setValue:@"Mobile App" forKey:@"origin"];
    [dict setValue:@"Cancelled" forKey:@"status"];
    NSDictionary *response = @{@"proofOfPaymentWrapper": dict};
    
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server postRequestwithUrl:ProofOFPaymentServiceURl withParameters:response successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dict);
            [FTIndicator showToastMessage:@"SR has been cancelled"];
            [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
            [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
        }
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
