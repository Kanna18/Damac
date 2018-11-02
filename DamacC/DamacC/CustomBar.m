//
//  CustomBar.m
//  DamacC
//
//  Created by Gaian on 30/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CustomBar.h"

@implementation CustomBar

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
        self = [[NSBundle mainBundle]loadNibNamed:@"CustomBar" owner:self options:nil][0];
    }
    return self;
}
- (IBAction)backClick:(id)sender {
    [DamacSharedClass.sharedInstance.currentVC.navigationController popViewControllerAnimated:YES];
}
@end
