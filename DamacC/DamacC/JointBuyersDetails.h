//
//  JointBuyersDetails.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"


@interface BuyersAccount__r : JSONModel

@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Party_ID__c;
@property (nonatomic) NSString <Optional> *Passport_Number__pc;

@end

@interface JointBuyersDetails : JSONModel

@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;
@property (nonatomic) NSString <Optional> *First_Name__c;
@property (nonatomic) NSString <Optional> *Last_Name__c;
@property (nonatomic) NSString <Optional> *Account__c;
@property (nonatomic) NSString <Optional> *Buyer_ID__c;
@property (nonatomic) NSString <Optional> *Booking__c;
@property (nonatomic) NSString <Optional> *Primary_Buyer__c;
@property (nonatomic) NSString <Optional> *Passport_Issue_Place__c;
@property (nonatomic) NSString <Optional> *Passport_Issue_Date__c;
@property (nonatomic) BuyersAccount__r <Optional> *Account__r;

@end
