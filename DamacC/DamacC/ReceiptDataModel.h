//
//  ReceiptDataModel.h
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"

@protocol ReceiptActions;
@interface ReceiptActions : JSONModel
@property (nonatomic) NSString <Optional> *action;
@property (nonatomic) NSString <Optional> *method;
@property (nonatomic) NSString <Optional> *url;
@end

@protocol ReceiptResponseLines;
@interface ReceiptResponseLines : JSONModel

@property (nonatomic) NSString <Optional> *cashReceiptId;
@property (nonatomic) NSString <Optional> *receiptType;
@property (nonatomic) NSString <Optional> *partyId;
@property (nonatomic) NSString <Optional> *customerName;
@property (nonatomic) NSString <Optional> *currencyCode;
@property (nonatomic) NSString <Optional> *enteredAmount;
@property (nonatomic) NSString <Optional> *unAppliedAmount;
@property (nonatomic) NSString <Optional> *appliedAmount;
@property (nonatomic) NSString <Optional> *functionalAmount;
@property (nonatomic) NSString <Optional> *receiptNumber;
@property (nonatomic) NSString <Optional> *receiptReference;
@property (nonatomic) NSString <Optional> *receiptDate;
@property (nonatomic) NSString <Optional> *paymentMethod;
@property (nonatomic) NSString <Optional> *comment;
@property (nonatomic) NSArray <ReceiptActions> *actions;
@end


@interface ReceiptDataModel : JSONModel
@property (nonatomic) NSString <Optional> *responseId;
@property (nonatomic) NSString <Optional> *responseTime;
@property (nonatomic) NSArray <ReceiptResponseLines>*responseLines;
@end
