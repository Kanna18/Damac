//
//  TopCollectionCell.m
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "TopCollectionCell.h"

@implementation TopCollectionCell


-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderColor = rgb(34, 34, 34).CGColor;
    self.layer.borderWidth = 1.5f;
    
}
@end
