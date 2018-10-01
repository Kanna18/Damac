//
//  PassportCell3.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportCell3.h"

@implementation PassportCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self borders:_view2];
    [self borders:_view1];
    
}
-(void)borders:(UIView*)vw{
    vw.layer.cornerRadius = 10;
    vw.layer.borderColor = rgb(191, 154, 88).CGColor;
    vw.clipsToBounds = YES;
    vw.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)uploadbtnOneClick:(id)sender {
}

- (IBAction)uploadbtnTwoClick:(id)sender {
}
@end
