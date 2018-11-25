//
//  ShowMenuOptiionsVC.h
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMenuOptiionsVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *img1Label1;
@property (weak, nonatomic) IBOutlet UILabel *img1Label2;
@property (weak, nonatomic) IBOutlet UILabel *img2Label1;
@property (weak, nonatomic) IBOutlet UILabel *img2Label2;
@property (weak, nonatomic) IBOutlet UILabel *img3Label1;
@property (weak, nonatomic) IBOutlet UILabel *img3Label2;
@property (weak, nonatomic) IBOutlet UILabel *img4Label1;
@property (weak, nonatomic) IBOutlet UILabel *img4Label2;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
- (IBAction)skipButtonClick:(id)sender;

@property NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gridWidth;

@end
