//
//  PassportCell3.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassportObject.h"

@interface PassportCell3 : UITableViewCell<ImagePickedProtocol>
- (IBAction)uploadbtnOneClick:(id)sender;
- (IBAction)uploadbtnTwoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property PassportObject *passObj;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end
