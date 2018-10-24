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
        self.frame = CGRectMake(0,fra.size.height, fra.size.width, fra.size.height);
        parentVC = vc;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frameChangeCameraView)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)frameChangeCameraView{
    CGRect fra = self.frame;
    CGRect mainfra = [UIScreen mainScreen].bounds;
    if(fra.origin.y == 0){
        fra.origin.y = mainfra.size.height;
    }else{
        fra.origin.y = 0;
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
        DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    }    
}

#pragma Mark : PickerViewDelegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<UIImagePickerControllerInfoKey, id> *)editingInfo{
    [_delegate imagePickerSelectedImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self frameChangeCameraView];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
     [_delegate imagePickerSelectedImage:[UIImage imageNamed:@""]];
    [self frameChangeCameraView];
}

@end
