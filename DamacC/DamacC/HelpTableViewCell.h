//
//  HelpTableViewCell.h
//  DamacC
//
//  Created by Gaian on 04/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelSub ;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSub;
@property (weak, nonatomic) IBOutlet UIView *borderView;

@end

NS_ASSUME_NONNULL_END
