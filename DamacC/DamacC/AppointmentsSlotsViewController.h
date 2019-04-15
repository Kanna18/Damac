//
//  AppointmentsSlotsViewController.h
//  DamacC
//
//  Created by Gaian on 29/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentsSlotsViewController : UIViewController
- (IBAction)closeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectMonthBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectDateBtn;
- (IBAction)selectDataClick:(id)sender;
- (IBAction)selectMonthClick:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *totalArrayDates;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property AppointmentObject *appointObj;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UILabel *availableSlotsLabel;



@end



NS_ASSUME_NONNULL_END
