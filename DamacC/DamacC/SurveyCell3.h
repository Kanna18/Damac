//
//  SurveyCell3.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyCell3 : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *continueSurveyBtn;
- (IBAction)continueSurveyClick:(id)sender;
@property (nonatomic) UICollectionView *parentCollectionView;
@property NSMutableArray *surveyArray;

@property NSMutableArray *arrayOfDictionary;

@end
NS_ASSUME_NONNULL_END
