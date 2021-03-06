//
//  CreateAppointmentVC.h
//  DamacC
//
//  Created by Gaian on 25/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "AppointmentObject.h"
@interface CreateAppointmentVC : UIViewController<WSCalendarViewDelegate,KPDropMenuDelegate>
@property (weak, nonatomic) IBOutlet KPDropMenu *purposeDropDown;
@property (weak, nonatomic) IBOutlet KPDropMenu *subPurposeDropDown;
@property (weak, nonatomic) IBOutlet KPDropMenu *unitsDropDown;
@property (weak, nonatomic) IBOutlet UIButton *calendarBtn;
- (IBAction)calendarClick:(id)sender;
@property (weak, nonatomic) IBOutlet KPDropMenu *timeSlotDropMenu;
- (IBAction)sendRequestClick:(id)sender;
@property UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *baseView;


@property (weak, nonatomic) IBOutlet UIButton *selectPurposeBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectSubPurposeBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectUnitBtn;
- (IBAction)selectPurposeNewClick:(id)sender;
- (IBAction)selectSubPurposeNewClick:(id)sender;
- (IBAction)selectUnitNewClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *slotLabel;

@property AppointmentObject *appointObj;

@end
