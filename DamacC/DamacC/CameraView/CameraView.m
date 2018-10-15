//
//  CameraView.m
//  DamacC
//
//  Created by Gaian on 05/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView
{
    
    UIViewController *parentVC;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame parentViw:(UIViewController*)vc{
    self = [super initWithFrame:frame];
    if(self){
        self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CameraView class]) owner:self options:nil][0];
        
        CGRect fra = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0,fra.size.height, fra.size.width, 85);
        parentVC = vc;
    }
    return self;
}

-(void)frameChangeCameraView{
    CGRect fra = self.frame;
    CGRect mainfra = [UIScreen mainScreen].bounds;
    if(fra.origin.y == mainfra.size.height){
        fra.origin.y = mainfra.size.height-85;
    }else{
        fra.origin.y = mainfra.size.height;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = fra;
    }];
}


- (IBAction)uploadClick:(id)sender {
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.allowsEditing = YES;
    pickerView.delegate = self;
    [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [parentVC presentViewController:pickerView animated:YES completion:nil];
}
- (IBAction)cameraClick:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
        [parentVC presentViewController:pickerView animated:YES completion:nil];
    }
    
}

@end
