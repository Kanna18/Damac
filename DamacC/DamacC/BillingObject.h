//
//  BillingObject.h
//  DamacC
//
//  Created by Gaian on 05/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillingObject : NSObject

@property NSString *billAddress;
@property NSString *billName;
@property NSString *billCity;
@property NSString *billCountry;
@property NSString *billState;
@property NSString *billTelephone;
@property NSString *billemailID;

@property NSString *shipAddress;
@property NSString *shipName;
@property NSString *shipCity;
@property NSString *shipCountry;
@property NSString *shipState;
@property NSString *shipTelephone;
@property NSString *shipemailID;

-(void)setDefaultValues:(NSArray*)arr;
@end

NS_ASSUME_NONNULL_END
