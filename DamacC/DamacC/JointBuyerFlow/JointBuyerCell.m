//
//  JointBuyerCell.m
//  DamacC
//
//  Created by Gaian on 14/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointBuyerCell.h"

@implementation JointBuyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
