//
//  AppointmentsDataModel.h
//  DamacC
//
//  Created by Gaian on 20/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"



@interface AppointemsAttrib : JSONModel

@property (nonatomic) NSString <Optional> *type;
@property (nonatomic) NSString <Optional> *url;
@end


@interface AppointementsAccounts : JSONModel

@property (nonatomic) AppointemsAttrib <Optional> *attributes;
@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;
@property (nonatomic) NSString <Optional> *PersonEmail;
@end


@interface AppointementsRecords : JSONModel

@property (nonatomic) AppointemsAttrib <Optional> *attributes;
@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *DeveloperName;
@end

@interface AppointmentsDataModel : JSONModel

@property (nonatomic) AppointementsRecords <Optional> *RecordType;
@property (nonatomic) AppointementsAccounts <Optional> *Account__r;
@property (nonatomic) AppointemsAttrib <Optional> *attributes;
@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;
@property (nonatomic) NSString <Optional> *OwnerId;
@property (nonatomic) NSString <Optional> *Account__c;
@property (nonatomic) NSString <Optional> *Appointment_Date__c;
@property (nonatomic) NSString <Optional> *Account_Email__c;
@property (nonatomic) NSString <Optional> *Appointment_Slot__c;
@property (nonatomic) NSString <Optional> *Account_Name_for_Walk_In__c;
@property (nonatomic) NSString <Optional> *Appointment_Status__c;
@property (nonatomic) NSString <Optional> *Booking_Unit_Name__c;
@property (nonatomic) NSString <Optional> *Registration_ID__c;
@property (nonatomic) NSString <Optional> *RecordTypeId;
@property (nonatomic) NSString <Optional> *Service_Type__c;
@property (nonatomic) NSString <Optional> *Sub_Purpose__c;

@end
