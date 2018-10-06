//
//  PassportCell3.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PassportCell3.h"

@implementation PassportCell3{
    
    CameraView *camView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self borders:_view2];
    [self borders:_view1];
    
    CGRect fra = [UIScreen mainScreen].bounds;
    camView = [[CameraView alloc]initWithFrame:CGRectMake(0,fra.size.height, fra.size.width, 85) parentViw:[DamacSharedClass sharedInstance].currentVC];
    [[DamacSharedClass sharedInstance].currentVC.view addSubview:camView];
    
}
-(void)borders:(UIView*)vw{
    vw.layer.cornerRadius = 10;
    vw.layer.borderColor = rgb(191, 154, 88).CGColor;
    vw.clipsToBounds = YES;
    vw.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)uploadbtnOneClick:(id)sender {
    [self frameChange];
}

- (IBAction)uploadbtnTwoClick:(id)sender {
    [self frameChange];
}

-(void)frameChange{
    CGRect fra = camView.frame;
    CGRect mainfra = [UIScreen mainScreen].bounds;
    if(fra.origin.y == mainfra.size.height){
        fra.origin.y = mainfra.size.height-85;
    }else{
        fra.origin.y = mainfra.size.height;
    }
    [UIView animateWithDuration:0.2 animations:^{
        camView.frame = fra;
    }];
    
}
@end
