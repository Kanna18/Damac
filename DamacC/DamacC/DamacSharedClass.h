//
//  DamacSharedClass.h
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetailsModel.h"

@interface DamacSharedClass : NSObject

+ (DamacSharedClass *)sharedInstance;

@property UserDetailsModel *userProileModel;
@property NSDictionary *firstDataObject;
@property NSMutableArray *sfidsForJointBuyersArray;
@property NSMutableArray *unitsArray;
//@property UserDetailsModel *userDetailsModel;
@end
