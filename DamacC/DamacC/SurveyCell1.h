//
//  SurveyCell1.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyCell1 : UICollectionViewCell<WYPopoverControllerDelegate,POPDelegate,UITextViewDelegate>
- (IBAction)emailClick:(id)sender;
- (IBAction)phoneClick:(id)sender;
- (IBAction)walkInClick:(id)sender;
- (IBAction)webChatClick:(id)sender;
- (IBAction)purposeOfChatClick:(id)sender;
- (IBAction)continueSurveyClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *walkInBtn;
@property (weak, nonatomic) IBOutlet UIButton *webChatBtn;

@property (weak, nonatomic) IBOutlet UIButton *continuSurveyBtn;
@property (weak, nonatomic) IBOutlet UIButton *purposeCntctBtn;

@property (nonatomic) UICollectionView *parentCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property NSMutableArray *surveyArray;

@end

NS_ASSUME_NONNULL_END
