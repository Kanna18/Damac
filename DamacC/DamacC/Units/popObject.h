//
//  popObject.h
//  DamacC
//
//  Created by Gaian on 10/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//


@interface popObject : NSObject

@property (nonatomic) ResponseLine *selectedUnit;
@property (nonatomic,assign) NSString <Optional> *RecordType;
@property (nonatomic) NSString <Optional> *AccountID;
@property (nonatomic) NSString <Optional> *fileName;
@property (nonatomic) NSString <Optional> *AttachmentURL;
@property (nonatomic) NSString <Optional> *Totalamount;
@property (nonatomic) NSString <Optional> *PARemark;
@property (nonatomic) NSString <Optional> *PaymentMode;
@property (nonatomic) NSString <Optional> *PaymentDate;
@property (nonatomic) NSString <Optional> *PaymentCurrency;
@property (nonatomic) NSString <Optional> *SenderName;
@property (nonatomic) NSString <Optional> *BankName;
@property (nonatomic) NSString <Optional> *SwiftCode;
@property (nonatomic) NSString <Optional> *origin;
@property (nonatomic) NSString <Optional> *status;


@property (nonatomic) UIImage *popImage;
@property (nonatomic) UIImage *otherImage;

@property (nonatomic) NSString <Optional> *popImagePath;
@property (nonatomic) NSString <Optional> *otherImagePath;
-(void)cancelPOPfromServicesSRDetails:(ServicesSRDetails*)srD;
-(void)subMitPOPfromServicesSRDetails;
@end

