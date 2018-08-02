//
//  PaymentsViewController.h
//  DamacC
//
//  Created by Gaian on 16/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *serverUrlString;
@end
