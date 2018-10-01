//
//  ChangeOfContactDetails.h
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeOfContactDetails : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *stepperBaseView;
- (IBAction)mobileClick:(id)sender;
- (IBAction)emailClick:(id)sender;
- (IBAction)addressClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)saveDraftClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

- (IBAction)downloadFormClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view2;
@end
