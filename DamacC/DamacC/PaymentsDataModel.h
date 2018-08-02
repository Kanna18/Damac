//
//  PaymentsDataModel.h
//  DamacC
//
//  Created by Gaian on 16/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"

@protocol ResponseLinePayments;
@interface ResponseLinePayments : JSONModel

@property (nonatomic) NSString <Optional>*id;
@property (nonatomic) NSString <Optional>*registrationId;
@property (nonatomic) NSString <Optional>*termId;
@property (nonatomic) NSString <Optional>*lineId;
@property (nonatomic) NSString <Optional>*installment;
@property (nonatomic) NSString <Optional>*description_payment;
@property (nonatomic) NSString <Optional>*milestoneEvent;
@property (nonatomic) NSString <Optional>*milestoneEventArabic;
@property (nonatomic) NSString <Optional>*milestonePercent;
@property (nonatomic) NSString <Optional>*dueDate;
@property (nonatomic) NSString <Optional>*invoiceAmount;
@property (nonatomic) NSString <Optional>*paidAmount;
@property (nonatomic) NSString <Optional>*dueAmount;
@property (nonatomic) NSString <Optional>*paidPercentage;
@end

@interface PaymentsDataModel : JSONModel
@property (nonatomic) NSString <Optional>*responseId;
@property (nonatomic) NSString <Optional>*responseTime;
@property (nonatomic) NSArray <ResponseLinePayments>*responseLines;
@end
