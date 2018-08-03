//
//  StepperView.h
//  sampleAPPContent
//
//  Created by gaian  on 7/31/18.
//  Copyright © 2018 gaian . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepperView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (nonatomic) BOOL line1Animation;
@property (nonatomic) BOOL line2Animation;
-(void)nolineColor;

@end
