//
//  ServicesCell.h
//  DamacC
//
//  Created by Gaian on 13/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitsClassLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServicesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@end

NS_ASSUME_NONNULL_END
