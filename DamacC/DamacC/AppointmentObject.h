//
//  AppointmentObject.h
//  DamacC
//
//  Created by Gaian on 30/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentObject : NSObject

@property NSString *RecordType;
@property NSString *UserName;
@property NSString *AccountID;
@property NSString *AppointmentDate;
@property NSString *BookingUnit;
@property NSString *SubProcessName;
@property NSString *ServiceType;
@property NSString *TimeSlot;

-(void)createappointment;

@end

NS_ASSUME_NONNULL_END
