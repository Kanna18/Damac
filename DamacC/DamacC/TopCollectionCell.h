//
//  TopCollectionCell.h
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

@interface TopCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet MarqueeLabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;

@end
