//
//  PopCell2.h
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopCell2 : UICollectionViewCell<KPDropMenuDelegate>
@property (weak, nonatomic) IBOutlet KPDropMenu *baseDropView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property popObject *popObj;

@end
