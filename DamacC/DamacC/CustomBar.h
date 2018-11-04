//
//  CustomBar.h
//  DamacC
//
//  Created by Gaian on 30/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backClick:(id)sender;


- (IBAction)loadNotifications:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *notificationsBtn;

@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;
- (IBAction)settingsClick:(id)sender;


@property UINavigationController *navController;
@end
