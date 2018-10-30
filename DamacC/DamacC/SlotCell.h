//
//  SlotCell.h
//  DamacC
//
//  Created by Gaian on 29/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SlotCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeSLotLabel;
@property AppointmentObject *appointObj;
@end

NS_ASSUME_NONNULL_END
