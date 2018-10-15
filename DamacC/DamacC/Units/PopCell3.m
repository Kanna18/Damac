//
//  PopCell3.m
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PopCell3.h"

@implementation PopCell3{
    
    CameraView *camView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self roundCorners:_buttonSubmit];
    [self roundCorners:_buttonDocument];
    CGRect fra = [UIScreen mainScreen].bounds;
    camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:[DamacSharedClass sharedInstance].currentVC];
    [[DamacSharedClass sharedInstance].currentVC.view addSubview:camView];    
    [self roundCorners:_buttonSubmit];
    [self roundCorners:_buttonDocument];
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
    
}

- (IBAction)uploadProofClick1:(id)sender {
    [camView frameChangeCameraView];
}
- (IBAction)uploadProofClick2:(id)sender {
    [camView frameChangeCameraView];
}
@end
