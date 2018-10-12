//
//  PassportFooter.m
//  DamacC
//
//  Created by Gaian on 10/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportFooter.h"

@implementation PassportFooter

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
        
        self = [[NSBundle mainBundle] loadNibNamed:@"PassportFooter" owner:self options:0][0];
        self.frame = frame;
        self.layer.cornerRadius = 10.0f;
        self.clipsToBounds = YES;
        [self roundCorners:_submitbutton];
        [self roundCorners:_saveDraftButton];
    }
    return self;
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
    
}
@end
