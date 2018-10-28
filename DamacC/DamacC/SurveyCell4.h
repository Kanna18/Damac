//
//  SurveyCell4.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyCell4 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *continueSurveyBtn;
- (IBAction)oneClick:(id)sender;
- (IBAction)twoclick:(id)sender;
- (IBAction)threeClick:(id)sender;
- (IBAction)fourCLick:(id)sender;
- (IBAction)fiveClick:(id)sender;
@property (nonatomic) UICollectionView *parentCollectionView;
@property NSMutableArray *surveyArray;
@end

NS_ASSUME_NONNULL_END
