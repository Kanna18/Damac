//
//  RentalPoolViewCellViewController.h
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaopServices.h"
#import "JointBuyerObject.h"

@interface RentalPoolViewCellViewController : UIViewController<SoapImageuploaded>
@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextClick;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIButton *dropDownCountriesBtn;
- (IBAction)countriesCLick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
- (IBAction)saveDraftCLickView:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)nextClick:(id)sender;
@property SaopServices *soap;
@property SaopServices *soap2;
@property SaopServices *soap3;
- (IBAction)buyersNewDropDownClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buyersNewBtn;
@property JointBuyerObject *jointObj;
@property NSIndexPath *editingIndexPath;


@property ServicesSRDetails *srdRental;
@end
