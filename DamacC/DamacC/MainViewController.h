//
//  MainViewController.h
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface MainViewController : UIViewController <iCarouselDelegate, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UICollectionView *gridCollectionView;
@end
