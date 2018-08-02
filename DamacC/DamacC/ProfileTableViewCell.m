//
//  ProfileTableViewCell.m
//  DamacC
//
//  Created by Gaian on 13/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _nameLabel.text = kUserProfile.partyName;
    _emailLabel.text = kUserProfile.emailAddress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
