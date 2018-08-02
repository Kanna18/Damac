//
//  CustomViewCarousel.m
//  DamacC
//
//  Created by Gaian on 13/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CustomViewCarousel.h"

@implementation CustomViewCarousel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"CustomViewCarousel" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.layer.cornerRadius = 20.0f;
        self.layer.borderWidth =1.0f;
        self.layer.borderColor = rgb(174, 134, 73).CGColor;
        self.label1.textColor = rgb(174, 134, 73);
        self.label2.textColor = rgb(174, 134, 73);
        
        [self.label1 setAdjustsFontSizeToFitWidth:YES];
        [self.label2 setAdjustsFontSizeToFitWidth:YES];
    }
    return self;
}

@end
