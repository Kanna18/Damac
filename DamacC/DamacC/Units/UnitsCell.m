//
//  UnitsCell.m
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "UnitsCell.h"

@implementation UnitsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self labelsAdjustment:_stackView1];
    [self labelsAdjustment:_stackView2];
    [self labelsAdjustment:_stackView3];
    [self buttonsRadius:_payNowButton];
    [self buttonsRadius:_printDocButton];
    _printDocButton.layer.borderColor = rgb(191, 154, 88).CGColor;
}

-(void)buttonsRadius:(UIButton*)btn{
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1.0f;
}
-(void)labelsAdjustment:(UIStackView*)sv{
    
    for (UILabel *lbl in sv.arrangedSubviews) {
        if([lbl isKindOfClass:[UILabel class]]){
            [lbl setAdjustsFontSizeToFitWidth:YES];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
