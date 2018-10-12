//
//  PassportHeader.m
//  DamacC
//
//  Created by Gaian on 10/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportHeader.h"

@implementation PassportHeader

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
        
        self = [[NSBundle mainBundle] loadNibNamed:@"PassportHeader" owner:self options:0][0];
        self.frame = frame;
        self.layer.cornerRadius = 10.0f;
        self.clipsToBounds = YES;        
        
    }
    return self;
}

@end
