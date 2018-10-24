//
//  PassportObject.h
//  DamacC
//
//  Created by Gaian on 24/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PassportObject : NSObject

@property NSString *salesforceId;
@property NSString *RecordType;
@property NSString *AccountID;
@property NSString *status;
@property NSString *origin;
@property NSString *fcm;
@property NSString *PassportFileUrl;
@property NSString *AdditionalDocFileUrl;
@property NSString *passportNo;
@property NSString *PassportIssuedPlace;
@property NSString *PassportIssuedPlaceArabic;
@property NSString *PassportIssuedDate;

@property UIImage *passportImage;
@property NSString *passportImagePath;

@property UIImage *additionalImage;
@property NSString *additionalImagePath;

-(void)sendPassportResponsetoServer;
-(void)fillWithDefaultValues;
-(void)fillValuesWIth:(ServicesSRDetails*)srd;
@end

NS_ASSUME_NONNULL_END
