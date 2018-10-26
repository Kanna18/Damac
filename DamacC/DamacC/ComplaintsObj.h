//
//  ComplaintsObj.h
//  DamacC
//
//  Created by Gaian on 26/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComplaintsObj : NSObject

@property NSString *userId;
@property NSString *AccountID;
@property NSString *Description;
@property NSString *BookingUnit;
@property NSString *ComplaintType;
@property NSString *ComplaintSubType;
@property NSString *Status;
@property NSString *salesforceId;

@property UIImage *attactment1;
@property UIImage *attactment2;

@property NSString *attactment1Path;
@property NSString *attactment2Path;


-(void)sendDraftStatusToServer;
-(void)fillWithDefaultValues;
-(void)fillValuesWithServiceDetails:(ServicesSRDetails*)srd;
@end

NS_ASSUME_NONNULL_END
