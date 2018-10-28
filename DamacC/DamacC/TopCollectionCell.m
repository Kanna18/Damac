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
    CGRect fra = self.label2.frame;
    fra.size.width = self.label2.intrinsicContentSize.width;
    self.label2.frame =fra;
    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self animateLabel];
    }];
}

-(void)animateLabel{

    [UIView animateWithDuration:0.5 animations:^{
        CGRect fram = self.label2.frame;
        
        if(fram.origin.x <= -(fram.size.width)){
            fram.origin.x = fram.size.width - fram.size.width/10;
        }else{
            fram.origin.x = fram.origin.x - fram.size.width/10;
        }
        self.label2.frame= fram;
    }];
    
}
@end
