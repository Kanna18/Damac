//
//  PassportHeader.h
//  DamacC
//
//  Created by Gaian on 10/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassportObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface PassportHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property PassportObject *passObj;
@end

NS_ASSUME_NONNULL_END
