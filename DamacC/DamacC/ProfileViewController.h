//
//  ProfileViewController.h
//  DamacC
//
//  Created by Gaian on 02/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *partyLabel;
@property (weak, nonatomic) IBOutlet UILabel *portofolioLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableview;
@property (weak, nonatomic) IBOutlet UIButton *headingButton;
- (IBAction)profileImageUploadClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end
