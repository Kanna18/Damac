//
//  JointView1.h
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"
#import "JointBuyerObject.h"

@interface JointView1 : UIView<ImagePickedProtocol>

@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn;
@property (weak, nonatomic) IBOutlet UIButton *downloadFormBtn;
- (IBAction)downloadDraftCLick:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *selectFile1;
@property (weak, nonatomic) IBOutlet UIButton *selectFile2;
@property (weak, nonatomic) IBOutlet UIButton *selectFile3;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn2;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn2;
@property (weak, nonatomic) IBOutlet UIButton *submitSR;
- (IBAction)selectFile1Click:(id)sender;
- (IBAction)selectFile2Click:(id)sender;
- (IBAction)selectFile3CLick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *attachLabel1;
@property (weak, nonatomic) IBOutlet UILabel *attachLabel2;
@property (weak, nonatomic) IBOutlet UILabel *attachLabel3;


@property JointBuyerObject *joObj; //FOR Joint Buyer


@property (weak, nonatomic) IBOutlet UIView *uploadsView;
@property (weak, nonatomic) IBOutlet UIStackView *bottomButtomsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *previous1height;
@property (weak, nonatomic) IBOutlet UILabel *downloadText;
@property (weak, nonatomic) IBOutlet UIImageView *downloadImage;

@end
