//
//  PaymentsCell.h
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentsScheduleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label1;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label2;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label3;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label4;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label5;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label6;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label7;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label8;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label9;
-(void)setLabels:(ResponseLinePayments*)paymentsDM;
@end
