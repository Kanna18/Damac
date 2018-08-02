//
//  MyServiceRequestViewController.h
//  DamacC
//
//  Created by Gaian on 07/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServiceRequestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *dropButton;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIView *hideView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)newButtonClick:(id)sender;
- (IBAction)draftClick:(id)sender;
- (IBAction)allClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@property NSString *typeoFVC;
@end
