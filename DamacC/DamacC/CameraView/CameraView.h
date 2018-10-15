//
//  CameraView.h
//  DamacC
//
//  Created by Gaian on 05/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

-(instancetype)initWithFrame:(CGRect)frame parentViw:(UIViewController*)vc;
-(void)frameChangeCameraView;
@end
