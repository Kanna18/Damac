//
//  MyServiceRequestViewController.h
//  DamacC
//
//  Created by Gaian on 07/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServiceRequestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)newButtonClick:(id)sender;
- (IBAction)draftClick:(id)sender;
- (IBAction)allClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UIButton *btnDraft;
- (IBAction)creatteServiceClick:(id)sender;

@property NSString *typeoFVC;

@property (weak, nonatomic) IBOutlet UIView *eservicesMessage;

@property BOOL loadFromServisesMenu;
@end
