//
//  JointBuyerObject.h
//  DamacC
//
//  Created by Gaian on 24/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesSRDetails.h"
NS_ASSUME_NONNULL_BEGIN

@interface JointBuyerObject : NSObject

@property NSString *AccountID;
@property NSString *AdditionalDocFileUrl;
@property NSString *address1;
@property NSString *address2;
@property NSString *address3;
@property NSString *address4;
@property NSString *city;
@property NSString *country;
@property NSString *email;
@property NSString *mobileCountryCode;
@property NSString *origin;
@property NSString *PassportFileUrl;
@property NSString *phone;
@property NSString *postalCode;
@property NSString *RecordType;
@property NSString *state;
@property NSString *status;
@property NSString *UploadSignedChangeofDetails;
@property NSString *salesforceId;

@property UIImage *cocdImage;
@property UIImage *primaryPassportImage;
@property UIImage *additionalDocumentImage;

-(void)fillObjectWithParticularBuyerDict:(NSDictionary*)dict;
-(void)fillObjectWithPrimaryBuyerInfo;
-(void)fillObjectWIthSerViceRequestDetail:(ServicesSRDetails*)srd;

-(void)changeValueBasedonTag:(UITextField*)textField withValue:(NSString*)str;
-(void)sendJointBuyerResponsetoserver;

@end

NS_ASSUME_NONNULL_END
