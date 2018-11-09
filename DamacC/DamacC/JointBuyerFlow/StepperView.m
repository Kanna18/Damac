//
//  StepperView.m
//  sampleAPPContent
//
//  Created by gaian  on 7/31/18.
//  Copyright © 2018 gaian . All rights reserved.
//

#import "StepperView.h"

@implementation StepperView

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
       self = [[NSBundle mainBundle] loadNibNamed:@"StepperView" owner:self options:nil][0];
       self.frame = frame;
    }
    return self;
    
}
-(void)setLine1Animation:(BOOL)line1Animation{
    if(line1Animation == YES){
        [UIView animateWithDuration:2.0 animations:^{
            _line2.backgroundColor = [UIColor whiteColor];
            _line1.backgroundColor = goldColor;
            _btn1.selected = YES;
            _btn2.selected = NO;
        } completion:NULL];
    }
}

-(void)setLine2Animation:(BOOL)line2Animation{
    if(line2Animation == YES){
        [UIView animateWithDuration:2.0 animations:^{
            _line2.backgroundColor = goldColor;
        } completion:NULL];
        _btn2.selected = YES;
    }
}
-(void)nolineColor{
    _line2.backgroundColor = [UIColor whiteColor];
    _line1.backgroundColor = [UIColor whiteColor];
    
    _btn1.selected = NO;
    _btn2.selected = NO;
}
@end
