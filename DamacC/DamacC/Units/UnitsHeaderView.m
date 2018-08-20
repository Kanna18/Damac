//
//  UnitsHeaderView.m
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "UnitsHeaderView.h"

@implementation UnitsHeaderView

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
        
        self = [[NSBundle mainBundle]loadNibNamed:@"UnitsHeaderView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

- (IBAction)topButtonClick:(id)sender {
}
- (IBAction)buttonClick:(id)sender {
    if(_button.isSelected){
        _button.selected = NO;
    }else{
        _button.selected = YES;
    }
}
@end
