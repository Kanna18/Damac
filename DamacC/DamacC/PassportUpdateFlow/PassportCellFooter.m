//
//  PassportCellFooter.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportCellFooter.h"

@implementation PassportCellFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self roundCorners:_saveDraftBtn];
    [self roundCorners:_submitBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)submitClick:(id)sender {

}

- (IBAction)saveDraftClick:(id)sender {
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
    
}


@end
