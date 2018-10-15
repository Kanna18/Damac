//
//  PrintDocView.m
//  DamacC
//
//  Created by Gaian on 17/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PrintDocView.h"

@implementation PrintDocView{
    
    __weak IBOutlet UIImageView *image1;
    __weak IBOutlet UIImageView *image3;
    __weak IBOutlet UIImageView *image2;
}

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
        [self rectBounds:_serviceBtn];
        [self rectBounds:_soaButton];
        [self rectBounds:_penalityBtn];
    }
    return self;
}

-(void)rectBounds:(UIButton*)img{
    img.layer.cornerRadius = img.frame.size.height/2;
    img.layer.borderColor = [UIColor blackColor].CGColor;
    img.layer.borderWidth = 2.0f;
    img.clipsToBounds = YES;
    
}
- (IBAction)soaClick:(id)sender {
}

- (IBAction)serviceChargesClick:(id)sender {
}

- (IBAction)penalityClick:(id)sender {
}
@end
