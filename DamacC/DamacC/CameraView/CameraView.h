//
//  CameraView.h
//  DamacC
//
//  Created by Gaian on 05/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImagePickedProtocol <NSObject>

-(void)imagePickerSelectedImage:(UIImage*)image;

@end

@interface CameraView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) id <ImagePickedProtocol>delegate;
-(instancetype)initWithFrame:(CGRect)frame parentViw:(UIViewController*)vc;
-(void)frameChangeCameraView;
@end
