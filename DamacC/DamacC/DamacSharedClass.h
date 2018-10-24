//
//  DamacSharedClass.h
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetailsModel.h"
#import "VCFloatingActionButton.h"

@interface DamacSharedClass : NSObject

+ (DamacSharedClass *)sharedInstance;

@property UserDetailsModel *userProileModel;
@property NSDictionary *firstDataObject;
@property NSMutableArray *sfidsForJointBuyersArray;
@property NSMutableArray *unitsArray;
@property UIViewController *currentVC;
@property VCFloatingActionButton *windowButton;
//@property UserDetailsModel *userDetailsModel;
@property NSArray *unitsSFIDSArray;
@end
