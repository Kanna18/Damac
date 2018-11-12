//
//  JointView1.m
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointView1.h"

@implementation JointView1{
    
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
        self = [[NSBundle mainBundle] loadNibNamed:@"JointView1" owner:self options:nil][0];
        self.frame = frame;
        
        camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:DamacSharedClass.sharedInstance.currentVC];
        
        NSLog(@"Current View %@, Subviews --%@, Class - %@",[DamacSharedClass.sharedInstance.currentVC class],DamacSharedClass.sharedInstance.currentVC.view.subviews,[DamacSharedClass.sharedInstance.currentVC.view class]);
        [DamacSharedClass.sharedInstance.currentVC.view addSubview:camView];
        camView.delegate = self;
        selectedButtonTag = 0;
        [self cornerRadius:_submitSR];
    }
    return self;
}


- (IBAction)downloadDraftCLick:(id)sender {
//    ErrorViewController *errvc = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"errorVC"];
//    [DamacSharedClass.sharedInstance.currentVC presentViewController:errvc animated:YES completion:nil];
    _NextButton.hidden = NO;
    _saveDraftBtn.hidden = NO;
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
        [ch.scrollView setContentOffset:self.frame.origin];
    }
}

-(void)setImageNamesAsSelected:(int)tag withImage:(UIImage*)img{
    if(selectedButtonTag == 100){
//        [_selectFile1 setTitle:@"cacheJPEG1.jpg" forState:UIControlStateNormal];
        _attachLabel1.text =@"cacheJPEG1.jpg";
        if (_joObj) {
            _joObj.cocdImage = img;
        }
    }
    if(selectedButtonTag == 200){
//        [_selectFile2 setTitle:@"cacheJPEG2.jpg" forState:UIControlStateNormal];
        _attachLabel2.text =@"cacheJPEG2.jpg";
        if (_joObj) {
            _joObj.primaryPassportImage = img;
        }
    }
    if(selectedButtonTag == 300){
//        [_selectFile3 setTitle:@"cacheJPEG3.jpg" forState:UIControlStateNormal];
        _attachLabel3.text =@"cacheJPEG3.jpg";
        if (_joObj) {
            _joObj.additionalDocumentImage = img;
        }
    }
}

-(void)cornerRadius:(UIButton*)btn{
    btn.layer.cornerRadius = 6;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = goldColor.CGColor;
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
}

@end
