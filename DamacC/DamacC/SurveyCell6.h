//
//  SurveyCell6.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyCell6 : UICollectionViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *continueSurveyBtn;
- (IBAction)oneClick:(id)sender;
- (IBAction)twoclick:(id)sender;
- (IBAction)threeClick:(id)sender;
- (IBAction)fourCLick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *uitextView;
@property (nonatomic) UICollectionView *parentCollectionView;
@property NSMutableArray *surveyArray;
@property (weak, nonatomic) IBOutlet UIButton *surveyButton;
- (IBAction)surveyClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
