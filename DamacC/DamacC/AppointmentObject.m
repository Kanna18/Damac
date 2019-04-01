//
//  AppointmentObject.m
//  DamacC
//
//  Created by Gaian on 30/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "AppointmentObject.h"

@implementation AppointmentObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


//-(void)createappointment{
//
//
//    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
//
//    NSMutableDictionary *di = [[NSMutableDictionary alloc]init];
//    [di setValue:@"Appointment Scheduling" forKey:@"RecordType"];
//    [di setValue:handleNull(sf.currentUser.userName) forKey:@"UserName"];
//    [di setValue:handleNull(kUserProfile.sfAccountId) forKey:@"AccountID"];
//    [di setValue:self.AppointmentDate forKey:@"AppointmentDate"];
//    [di setValue:self.BookingUnit forKey:@"BookingUnit"];
//    [di setValue:self.SubProcessName forKey:@"SubProcessName"];
//    [di setValue:self.ServiceType forKey:@"ServiceType"];
//    [di setValue:self.TimeSlot forKey:@"TimeSlot"];
//
//
//    NSDictionary *dict = @{@"codCaseWrapper":di};
//    ServerAPIManager *srvr = [ServerAPIManager sharedinstance];
//    [srvr postRequestwithUrl:createAppointmentRequest withParameters:dict successBlock:^(id responseObj) {
//        if(responseObj){
//            NSDictionary *dicttt = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
//            NSLog(@"%@",dicttt);
//            [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
//        }
//    }  errorBlock:^(NSError *error) {
//        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
//        [FTIndicator showToastMessage:error.localizedDescription];
//    }];
//
//}

-(void)createappointment{
    
        SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
        NSMutableDictionary *di = [[NSMutableDictionary alloc]init];
        [di setValue:handleNull(kUserProfile.sfAccountId) forKey:@"accountId"];
        [di setValue:self.BookingUnit forKey:@"unitName"];
        [di setValue:self.ServiceType forKey:@"processName"];
        [di setValue:self.SubProcessName forKey:@"subProcessName"];
        [di setValue:self.AppointmentDate forKey:@"selectedDate"];
        [di setValue:[NSArray arrayWithObject:self.slotsNewDictionary] forKey:@"lstWrap"];

    
    
    
    ServerAPIManager *srvr = [ServerAPIManager sharedinstance];
    [srvr postRequestwithUrl:AppointmentsSlotsNew withParameters:di successBlock:^(id responseObj) {
            if(responseObj){
                NSDictionary *dicttt = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
                NSLog(@"%@",dicttt);
                [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
            }
        }  errorBlock:^(NSError *error) {
            [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
            [FTIndicator showToastMessage:error.localizedDescription];
        }];
    
    }








-(void)popToMainVC{
    
    
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"Book an Appointment - Success"],
                                     kFIRParameterItemName:@"Book an Appointment - Success",
                                     kFIRParameterContentType:@"Button Clicks"
                                     }];
    
    
    [FTIndicator dismissProgress];
    [FTIndicator showToastMessage:@"Appointment successfully Scheduled"];    
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}

@end
