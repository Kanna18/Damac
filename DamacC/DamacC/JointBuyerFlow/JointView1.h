//
//  JointView1.h
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JointView1 : UIView

@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn;
@property (weak, nonatomic) IBOutlet UIButton *downloadFormBtn;
- (IBAction)downloadDraftCLick:(id)sender;



@end
