//
//  PaymentsDataModel.m
//  DamacC
//
//  Created by Gaian on 16/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PaymentsDataModel.h"

@implementation ResponseLinePayments

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"id":    @"id",
                                                                  @"registrationId":    @"registrationId",
                                                                  @"termId":    @"termId",
                                                                  @"lineId":    @"lineId",
                                                                  @"installment":    @"installment",
                                                                  @"description_payment":    @"description",
                                                                  @"milestoneEvent":    @"milestoneEvent",
                                                                  @"milestoneEventArabic":    @"milestoneEventArabic",
                                                                  @"milestonePercent":    @"milestonePercent",
                                                                  @"dueDate":    @"dueDate",
                                                                  @"invoiceAmount":    @"invoiceAmount",
                                                                  @"paidAmount":    @"paidAmount",
                                                                  @"dueAmount":    @"dueAmount",
                                                                  @"paidPercentage":    @"paidPercentage"
                                                                  }];
}
@end

@implementation PaymentsDataModel

@end
