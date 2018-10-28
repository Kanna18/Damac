//
//  SurveyCell2.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyRatingCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SurveyCell2 : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *continueSurveyBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UICollectionView *parentCollectionView;
- (IBAction)surveyBtnClick:(id)sender;
@property NSMutableArray *surveyArray;
@end

NS_ASSUME_NONNULL_END
