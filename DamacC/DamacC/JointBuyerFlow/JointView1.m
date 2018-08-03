//
//  JointView1.m
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointView1.h"

@implementation JointView1

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
        self = [[NSBundle mainBundle] loadNibNamed:@"JointView1" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
    
}


@end
