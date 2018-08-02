//
//  PrintDocView.m
//  DamacC
//
//  Created by Gaian on 17/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PrintDocView.h"

@implementation PrintDocView

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
        self = [[NSBundle mainBundle] loadNibNamed:@"PrintDocView" owner:self options:nil][0];
    }
    return self;
}
- (IBAction)soaClick:(id)sender {
}

- (IBAction)serviceChargesClick:(id)sender {
}

- (IBAction)penalityClick:(id)sender {
}
@end
