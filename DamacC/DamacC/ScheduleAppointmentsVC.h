//
//  ScheduleAppointmentsVC.h
//  DamacC
//
//  Created by Gaian on 09/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleAppointmentsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

- (IBAction)createAppointmentClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *recentlyCreatedBtn;
- (IBAction)recentlyCreatedClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *upcomingBtn;
- (IBAction)upcomingClick:(id)sender;

@end
