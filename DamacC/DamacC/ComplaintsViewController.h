//
//  ComplaintsViewController.h
//  DamacC
//
//  Created by Gaian on 14/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComplaintsViewController : UIViewController<POPDelegate>
- (IBAction)selectUnits:(id)sender;

- (IBAction)selectCompleintClick:(id)sender;
- (IBAction)selectSubComplaint:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField     *complaintsTF;
- (IBAction)attachmentClick1:(id)sender;
- (IBAction)attachmentClick2:(id)sender;
- (IBAction)attachDocument:(id)sender;
- (IBAction)submitSRClick:(id)sender;
- (IBAction)saveDraftClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *submitSRButton;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftNumber;
@property (weak, nonatomic) IBOutlet UIButton *attachDocButton;

@property (weak, nonatomic) IBOutlet UIButton *selectComplaintBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectSubBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectUnitsButton;


@end

NS_ASSUME_NONNULL_END
