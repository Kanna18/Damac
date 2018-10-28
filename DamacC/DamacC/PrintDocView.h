//
//  PrintDocView.h
//  DamacC
//
//  Created by Gaian on 17/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrintDocView : UIView
@property (weak, nonatomic) IBOutlet UIButton *penalityBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *soaButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissViewBtn;
- (IBAction)soaClick:(id)sender;
- (IBAction)serviceChargesClick:(id)sender;
- (IBAction)penalityClick:(id)sender;
@property ResponseLine *currentUnit;
@end
