//
//  UnitsCell.h
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitsClassLabel.h"
#import "KATCircularProgress.h"

@interface UnitsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label1;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label2;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label3;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label4;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label5;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label7;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label8;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label9;
@property (weak, nonatomic) IBOutlet UnitsClassLabel *label6;

@property (weak, nonatomic) IBOutlet UIButton *printDocButton;
@property (weak, nonatomic) IBOutlet UIButton *payNowButton;
@property (weak, nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;
@property (weak, nonatomic) IBOutlet UIStackView *stackView3;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) NSString *dueAmount;
@property (weak, nonatomic) IBOutlet KATCircularProgress *progressView;
@property CGFloat percentValue;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
-(void)setProgressView;

@end
