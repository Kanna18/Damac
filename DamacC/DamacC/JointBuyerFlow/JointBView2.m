//
//  JointBView2.m
//  DamacC
//
//  Created by Gaian on 02/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointBView2.h"

@implementation JointBView2
{
    
    CameraView *camView;
    int selectedButtonTag;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self = [[NSBundle mainBundle] loadNibNamed:@"JointBView2" owner:self options:nil][0];
        self.frame = frame;
        camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:DamacSharedClass.sharedInstance.currentVC];
        [DamacSharedClass.sharedInstance.currentVC.view addSubview:camView];
        camView.delegate = self;
        selectedButtonTag = 0;
    }
    return self;
    
}


- (IBAction)selectFile1Click:(id)sender {
    [camView frameChangeCameraView];
    selectedButtonTag =100;
}

- (IBAction)selectFile2Click:(id)sender {
    [camView frameChangeCameraView];
    selectedButtonTag =200;
}
- (IBAction)selectFile3CLick:(id)sender {
    [camView frameChangeCameraView];
    selectedButtonTag =300;
}

#pragma Mark PickedImageProtocol
-(void)imagePickerSelectedImage:(UIImage *)image{
    
    [self setContentOffsetsofVC];
    if(image){
        [self setImageNamesAsSelected:selectedButtonTag withImage:image];
    }
    
}

-(void)setContentOffsetsofVC{
    
    if([DamacSharedClass.sharedInstance.currentVC isKindOfClass:[ChangeOfContactDetails class]])
    {
        ChangeOfContactDetails *ch = (ChangeOfContactDetails*)DamacSharedClass.sharedInstance.currentVC;
        [ch.scrollView setContentOffset:CGPointMake(ch.scrollView.bounds.size.width+10, 0)];
    }
    if([DamacSharedClass.sharedInstance.currentVC isKindOfClass:[RentalPoolViewCellViewController class]])
    {
        RentalPoolViewCellViewController *ch = (RentalPoolViewCellViewController*)DamacSharedClass.sharedInstance.currentVC;
        [ch.scrollView setContentOffset:CGPointMake(2*ch.scrollView.bounds.size.width+3, 0)];
    }
}

-(void)setImageNamesAsSelected:(int)tag withImage:(UIImage*)img{
    if(selectedButtonTag == 100){
        [_selectFile1 setTitle:@"cacheJPEG1.jpg" forState:UIControlStateNormal];
        if(_cocdObj){
        _cocdObj.cocdImage = img;
        }
        if (_joObj) {
        _cocdObj.cocdImage = img;
        }
    }
    if(selectedButtonTag == 200){
        [_selectFile2 setTitle:@"cacheJPEG2.jpg" forState:UIControlStateNormal];
        if(_cocdObj){
        _cocdObj.primaryPassportImage = img;
        }
        if (_joObj) {
            _cocdObj.cocdImage = img;
        }
    }
    if(selectedButtonTag == 300){
        [_selectFile3 setTitle:@"cacheJPEG3.jpg" forState:UIControlStateNormal];
        if(_cocdObj){
            _cocdObj.additionalDocumentImage = img;
        }
        if (_joObj) {
            _cocdObj.cocdImage = img;
        }
    }
}
@end
