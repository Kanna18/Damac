//
//  PassportCell1.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassportObject.h"
@interface PassportCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet COCDTF *textField;
@property PassportObject *passObj;
@end
