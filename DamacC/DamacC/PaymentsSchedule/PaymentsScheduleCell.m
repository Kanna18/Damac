//
//  PaymentsCell.m
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PaymentsScheduleCell.h"

@implementation PaymentsScheduleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLabels:(ResponseLinePayments*)paymentsDM{
    
    NSLog(@"%@",paymentsDM);
    _label1.text = paymentsDM.installment;
    _label2.text = paymentsDM.description_payment;
    _label3.text = paymentsDM.milestoneEvent;
    _label4.text = paymentsDM.invoiceAmount;
    _label5.text = paymentsDM.paidAmount;
    _label6.text = paymentsDM.dueAmount;
    _label7.text = paymentsDM.paidPercentage;
    _label8.text = paymentsDM.milestonePercent;
    _label9.text = paymentsDM.dueDate;
}
@end
