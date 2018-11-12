//
//  SurveyRatingCell.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyRatingCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIButton *ratingButton;
@property (weak, nonatomic) IBOutlet UIView *colorPad;
@property (nonatomic) UICollectionView *parentCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *Nolabel;
@property NSMutableArray *surveyArray;

@end

NS_ASSUME_NONNULL_END
