//
//  ChangeOfContactDetails.h
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COCDServerObj.h"
#import "SaopServices.h"
@interface ChangeOfContactDetails : UIViewController<UITableViewDelegate,UITableViewDataSource,SoapImageuploaded>
@property (weak, nonatomic) IBOutlet UIView *stepperBaseView;
- (IBAction)mobileClick:(id)sender;
- (IBAction)emailClick:(id)sender;
- (IBAction)addressClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)saveDraftClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property COCDServerObj *cocdOBj;
- (IBAction)downloadFormClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *nextbtn;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftButton;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property (weak, nonatomic) IBOutlet UIButton *downloadFormButton;
@property (nonatomic) SaopServices *soap;
@property (nonatomic) SaopServices *soap3;
@property (nonatomic) SaopServices *soap2;
@property NSIndexPath *editingIndexPath;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonWidth;


@end
