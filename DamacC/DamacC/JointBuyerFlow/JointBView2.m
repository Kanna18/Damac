//
//  JointBView2.m
//  DamacC
//
//  Created by Gaian on 02/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointBView2.h"

@implementation JointBView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"JointBView2" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
    
}


@end
