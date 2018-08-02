//
//  ChangeofDetailsViewController.h
//  DamacC
//
//  Created by Gaian on 06/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeofDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UITableView *tablView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextButtonClick:(id)sender;

@end
