//
//  JointBView2.h
//  DamacC
//
//  Created by Gaian on 02/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"
#import "COCDServerObj.h"
#import "JointBuyerObject.h"

@interface JointBView2 : UIView<ImagePickedProtocol>
@property (weak, nonatomic) IBOutlet UIButton *selectFile1;
@property (weak, nonatomic) IBOutlet UIButton *selectFile2;
@property (weak, nonatomic) IBOutlet UIButton *selectFile3;
@property (weak, nonatomic) IBOutlet UIButton *previous;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitSR;
- (IBAction)selectFile1Click:(id)sender;
- (IBAction)selectFile2Click:(id)sender;
- (IBAction)selectFile3CLick:(id)sender;

@property COCDServerObj *cocdObj; //FOR COCD
@property JointBuyerObject *joObj; //FOR Joint Buyer


@end
