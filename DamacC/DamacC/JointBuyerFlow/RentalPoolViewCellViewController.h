//
//  RentalPoolViewCellViewController.h
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentalPoolViewCellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UIView *stepperViewBase;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextClick;
@property (weak, nonatomic) IBOutlet UIView *firstView;

- (IBAction)nextClick:(id)sender;
@end
