//
//  DetailMyUnitsViewController.h
//  DamacC
//
//  Created by Gaian on 06/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMyUnitsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label_project;
@property (weak, nonatomic) IBOutlet UILabel *label_bedroomtype;
@property (weak, nonatomic) IBOutlet UILabel *label_unitType;
@property (weak, nonatomic) IBOutlet UILabel *label_inoicesRaised;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIView *percentViewPaid;
@property (weak, nonatomic) IBOutlet UILabel *label_paidPercent;
@property (weak, nonatomic) IBOutlet UIView *percentOverDue;
@property (weak, nonatomic) IBOutlet UILabel *label_overDue;
@property (weak, nonatomic) IBOutlet UIView *percentPDCCoverage;
@property (weak, nonatomic) IBOutlet UILabel *label_percentPDCCoverage;
@property (weak, nonatomic) IBOutlet UIButton *printDocumentButton;
@property (weak, nonatomic) IBOutlet UIButton *payNow;

- (IBAction)printDocumentsClick:(id)sender;
- (IBAction)payNow:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *typVCButton;
@property ResponseLine *responseUnit;

@end
