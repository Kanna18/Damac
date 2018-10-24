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
    int currenImageTapped;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self borders:_view2];
    [self borders:_view1];
    
    CGRect fra = [UIScreen mainScreen].bounds;
    camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:[DamacSharedClass sharedInstance].currentVC];
    camView.delegate = self;
    [[DamacSharedClass sharedInstance].currentVC.view addSubview:camView];
    currenImageTapped= 0;
    
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
    [camView frameChangeCameraView];
    currenImageTapped = 100;
}

- (IBAction)uploadbtnTwoClick:(id)sender {
    [camView frameChangeCameraView];
    currenImageTapped = 200;
    
}

-(void)imagePickerSelectedImage:(UIImage *)image{
    if(currenImageTapped == 100 && image){
        _passObj.additionalImage = image;
        _label1.text = @"cacheJPEG1.jpg";
    }
    if(currenImageTapped == 200 && image){
        _passObj.passportImage = image;
        _label2.text = @"cacheJPEG2.jpg";
    }
}
@end
