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
        self.frame = frame;
        parentVC = vc;
        
    }
    return self;
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
