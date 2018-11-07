//
//  BackgroundRequests.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "BackgroundRequests.h"

@implementation BackgroundRequests


-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}
-(void)getSfiDSList{
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSArray *arr = dict[@"Booking__c "];
            DamacSharedClass.sharedInstance.sfidsForJointBuyersArray = [NSMutableArray arrayWithArray:arr];
            
        }
    }  errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];

}
@end
