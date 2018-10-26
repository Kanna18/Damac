//
//  ReceiptsTableViewCell.h
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label1;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label2;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label3;
- (IBAction)receiptsClick:(id)sender;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label4;
@property (weak, nonatomic) IBOutlet UIButton *generateReceiptButton;
@property ReceiptResponseLines *rs;
@end
