//
//  EServicesViewController.h
//  DamacC
//
//  Created by Gaian on 17/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EServicesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *gridCollectionView;
@property (nonatomic,strong) NSString *typOfVC;
@property (nonatomic,strong) NSArray *arrayOflist;
 
@end
