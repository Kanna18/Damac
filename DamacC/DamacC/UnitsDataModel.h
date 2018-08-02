//
//  UnitsDataModel.h
//  DamacC
//
//  Created by Gaian on 16/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JSONModel.h"

/**********************/
@protocol Action;
@interface Action :JSONModel
@property (nonatomic) NSString <Optional>*action;
@property (nonatomic) NSString <Optional>*method;
@property (nonatomic) NSString <Optional>*url;
@end
/**********************/

/**********************/
@protocol ResponseLine;
@interface ResponseLine :JSONModel

@property (nonatomic) NSString <Optional>*registrationId;
@property (nonatomic) NSString <Optional>*registrationDate;
@property (nonatomic) NSString <Optional>*agreementDate;
@property (nonatomic) NSString <Optional>*projectCurrency;
@property (nonatomic) NSString <Optional>*partyId;
@property (nonatomic) NSString <Optional>*totalPaidInvoice;
@property (nonatomic) NSString <Optional>*totalInvoiced;
@property (nonatomic) NSString <Optional>*totalDueInvoice;
@property (nonatomic) NSString <Optional>*totalDueOther;
@property (nonatomic) NSString <Optional>*totalDue;
@property (nonatomic) NSString <Optional>*totalOverDue;
@property (nonatomic) NSString <Optional>*penaltyCharged;
@property (nonatomic) NSString <Optional>*penaltyRemaining;
@property (nonatomic) NSString <Optional>*pdcAmount;
@property (nonatomic) NSString <Optional>*pdcCoveragePercent;
@property (nonatomic) NSString <Optional>*reservationPrice;
@property (nonatomic) NSString <Optional>*psf;
@property (nonatomic) NSString <Optional>*lastPaymentDate;
@property (nonatomic) NSString <Optional>*nextPaymentDate;
@property (nonatomic) NSString <Optional>*spaAcdDate;
@property (nonatomic) NSString <Optional>*unitNumber;
@property (nonatomic) NSString <Optional>*unitStatus;
@property (nonatomic) NSString <Optional>*unitStatusFlag;
@property (nonatomic) NSString <Optional>*propertyCity;
@property (nonatomic) NSString <Optional>*unitType;
@property (nonatomic) NSString <Optional>*unitCategory;
@property (nonatomic) NSString <Optional>*permittedUse;
@property (nonatomic) NSString <Optional>*readyOrOffPlan;
@property (nonatomic) NSString <Optional>*percentCompleted;
@property (nonatomic) NSString <Optional>*propertyName;
@property (nonatomic) NSString <Optional>*buildingName;
@property (nonatomic) NSString <Optional>*unitId;
@property (nonatomic) NSString <Optional>*area;
@property (nonatomic) NSString <Optional>*completionDate;
@property (nonatomic) NSString <Optional>*inRentalPool;
@property (nonatomic) NSString <Optional>*masterCommunity;
@property (nonatomic) NSString <Optional>*masterCommunityArabic;
@property (nonatomic) NSArray <Action>*actions;

@end
/**********************/

/**********************/
@interface UnitsDataModel : JSONModel
@property (nonatomic) NSString <Optional>*responseId;
@property (nonatomic) NSString <Optional>*responseTime;
@property (nonatomic) NSArray <Action> *actions;
@property (nonatomic) NSArray <ResponseLine> *responseLines;
@end

/**********************/
