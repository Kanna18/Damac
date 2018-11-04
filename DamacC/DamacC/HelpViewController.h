//
//  HelpViewController.h
//  DamacC
//
//  Created by Gaian on 04/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpViewController : UIViewController
- (IBAction)skipClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
