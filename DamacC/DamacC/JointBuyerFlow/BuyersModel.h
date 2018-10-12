//
//  BuyersModel.h
//  DamacC
//
//  Created by Gaian on 11/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface AccountBuyers : JSONModel
//@property (nonatomic) NSString <Optional> *Id
//@property (nonatomic) NSString <Optional> *Party_ID__c;
//@property (nonatomic) NSString <Optional> *Passport_Number__pc;
@end

@interface BuyersModel : JSONModel

@property (nonatomic) NSString <Optional> *Id;
@property (nonatomic) NSString <Optional> *Name;
@property (nonatomic) NSString <Optional> *First_Name__c;
@property (nonatomic) NSString <Optional> *Last_Name__c;
@property (nonatomic) NSString <Optional> *Account__c;
@property (nonatomic) NSString <Optional> *Buyer_ID__c;
@property (nonatomic) NSString <Optional> *Booking__c;
@property (nonatomic) NSString <Optional> *Primary_Buyer__c;

@end

NS_ASSUME_NONNULL_END
