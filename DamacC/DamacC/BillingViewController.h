//
//  BillingViewController.h
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillingViewController : UIViewController<CCAvenuePaymentControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *proceedBtn;
@property (weak, nonatomic) IBOutlet UIButton *showAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *ccavenueBtn;
@property (weak, nonatomic) NSString *dueAmount;

- (IBAction)showAddressClick:(id)sender;
- (IBAction)proceedClick:(id)sender;
- (IBAction)ccavenueClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *outStandingTF;

@end
