//
//  PaymentsCell.m
//  DamacC
//
//  Created by Gaian on 16/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PaymentsCell.h"

@implementation PaymentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLabels:(ResponseLinePayments*)paymentsDM{
    
    _installmentLbl.text = paymentsDM.installment;
    _descriptionLbl.text = paymentsDM.description_payment;
    _milestoneEvent.text = paymentsDM.milestoneEvent;
    _invoiceAmount.text = paymentsDM.invoiceAmount;
    _paidAmount.text = paymentsDM.paidAmount;
    _paid2Amount.text = paymentsDM.paidPercentage;
}
@end
