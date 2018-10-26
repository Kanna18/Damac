//
//  ChangeofDetailsCell.h
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COCDServerObj.h"
#import "COCDTF.h"
@interface ChangeofContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet COCDTF *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sideLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@property (weak, nonatomic) IBOutlet UIImageView *borderView;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectCountryButtton;
@property COCDServerObj *cocdOBj;


@end
