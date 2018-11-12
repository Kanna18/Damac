//
//  AlertPopUp.m
//  DamacC
//
//  Created by Gaian on 12/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "AlertPopUp.h"

@implementation AlertPopUp

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"AlertPopUp" owner:self options:nil][0];
        self.frame = frame;
        
    }
    return self;
}

- (IBAction)okClick:(id)sender {
    _okHandler();
}

- (IBAction)closeClick:(id)sender {
    _cancelHandler();
}



//-(void)alertViewWithTitle:(NSString *)title descriptionMsg:(NSString *)descrp okClick:(okBlock)ok cancelClick:(cancelBlock)cancel{
//    
//}



@end
