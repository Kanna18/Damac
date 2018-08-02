//
//  PaymentsCell.h
//  DamacC
//
//  Created by Gaian on 16/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *installmentLbl;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *milestoneEvent;
@property (weak, nonatomic) IBOutlet UILabel *invoiceAmount;
@property (weak, nonatomic) IBOutlet UILabel *paidAmount;
@property (weak, nonatomic) IBOutlet UILabel *dueAmount;
@property (weak, nonatomic) IBOutlet UILabel *paid2Amount;
-(void)setLabels:(ResponseLinePayments*)paymentsDM;
@end
