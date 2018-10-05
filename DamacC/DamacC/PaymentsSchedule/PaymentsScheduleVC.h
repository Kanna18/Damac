//
//  PaymentsScheduleVC.h
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentsScheduleVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *serverUrlString;
@end
