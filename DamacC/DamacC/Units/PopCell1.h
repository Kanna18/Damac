//
//  PopCell1.h
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopCell1 : UICollectionViewCell<KPDropMenuDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buttonnext;
@property (weak, nonatomic) IBOutlet UIButton *buttonUnits;
@property (weak, nonatomic) IBOutlet KPDropMenu *kpDropBaseView;

@end
