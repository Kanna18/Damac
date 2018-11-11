//
//  UnitsClassLabel.m
//  DamacC
//
//  Created by Gaian on 03/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "UnitsClassLabel.h"

@implementation UnitsClassLabel

-(void)awakeFromNib{
    [super awakeFromNib];
    self.textColor = rgb(208, 199, 182);
}

@end


@implementation UnitsClassHeading

-(void)awakeFromNib{
    [super awakeFromNib];
//    self.textColor = rgb(126, 117, 44);
    self.textColor = [rgb(163, 153, 112) colorWithAlphaComponent:0.58];
    self.font = [UIFont fontWithName:@"Montserrat-Medium" size:13];
}

@end
