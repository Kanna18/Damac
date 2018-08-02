//
//  MyServicesDataModel.h
//  DamacC
//
//  Created by Gaian on 16/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"

@interface MyServicesAttributes : JSONModel

@property (nonatomic) NSString <Optional> *type;
@property (nonatomic) NSString <Optional> *url;

@end

@interface MyServicesAccount : JSONModel
@property (nonatomic) MyServicesAttributes <Optional> *attributes;
@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;
@end

@interface MyServicesRecordType : JSONModel

@property (nonatomic) MyServicesAttributes <Optional> *attributes;
@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;

@end

@interface MyServicesContact : JSONModel
@property (nonatomic) MyServicesAttributes <Optional> *attributes;
@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;
@end

@interface MyServicesDataModel : JSONModel

@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *CaseNumber;
@property (nonatomic) NSString <Optional> *CreatedDate;
@property (nonatomic) NSString <Optional> *Type;
@property (nonatomic) NSString <Optional> *SR_Type__c;
@property (nonatomic) NSString <Optional> *RecordTypeId;
@property (nonatomic) NSString <Optional> *AccountId;
@property (nonatomic) NSString <Optional> *Origin;
@property (nonatomic) NSString <Optional> *Priority;
@property (nonatomic) NSString <Optional> *Status;
@property (nonatomic) MyServicesRecordType <Optional> *RecordType;
@property (nonatomic) MyServicesAccount <Optional> *Account;
@property (nonatomic) MyServicesContact <Optional> *Contact;


@end
