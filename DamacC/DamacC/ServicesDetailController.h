//
//  ServicesDetailController.h
//  DamacC
//
//  Created by Gaian on 18/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
- (IBAction)editButtonClick:(id)sender;

@property NSString *srCaseId;
- (IBAction)cancelButton:(id)sender;
@property MyServicesDataModel *servicesDataModel;
@end
