//
//  PassportFooter.h
//  DamacC
//
//  Created by Gaian on 10/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassportObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface PassportFooter : UIView
@property (weak, nonatomic) IBOutlet UIButton *submitbutton;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftButton;
@property PassportObject *passObj;

@end

NS_ASSUME_NONNULL_END
