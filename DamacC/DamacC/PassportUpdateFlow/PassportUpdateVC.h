//
//  PassportUpdateVC.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassportUpdateVC : UIViewController<KPDropMenuDelegate>
@property (weak, nonatomic) IBOutlet KPDropMenu *dropBaseView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
