//
//  COCDServerObj.h
//  DamacC
//
//  Created by Gaian on 16/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesSRDetails.h"
#import "Translator.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ArabicDelegate <NSObject>

-(void)arabicConversionDone;

@end

@interface COCDServerObj : NSObject

@property NSString *RecordType;
@property NSString *UserName;
@property NSString *salesforceId;
@property NSString *AccountID;
@property NSString *AddressLine1;
@property NSString *AddressLine2;
@property NSString *AddressLine3;
@property NSString *AddressLine4;
@property NSString *City;
@property NSString *State;
@property NSString *PostalCode;
@property NSString *Country;
@property NSString *Mobile;
@property NSString *Email;
@property NSString *AddressLine1Arabic;
@property NSString *AddressLine2Arabic;
@property NSString *AddressLine3Arabic;
@property NSString *AddressLine4Arabic;
@property NSString *CityArabic;
@property NSString *StateArabic;
@property NSString *PostalCodeArabic;
@property NSString *CountryArabic;
@property NSString *draft;
@property NSString *Status;
@property NSString *Origin;
@property NSString *fcm;
@property NSString *cocdUploadedImagePath;
@property NSString *primaryPassportUploadedImagePath;
@property NSString *additionalImageUploadedImagePath;

@property UIImage *cocdImage;
@property UIImage *primaryPassportImage;
@property UIImage *additionalDocumentImage;

@property int CountobobjectstoTranslate;

-(void)fillCOCDObjectWithOutCaseID;
-(void)changeValueBasedonTag:(UITextField*)textField withValue:(NSString*)str;
-(void)sendDraftStatusToServer;
-(void)fillCOCDObjWithCaseID:(ServicesSRDetails*)srd;

- (void)updateTranslatewithText:(NSString*)txt;
-(void)sendArabicTexts;


@property id<ArabicDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
