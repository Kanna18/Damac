//
//  Sub-SurveyCell.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TappedOnSmiley <NSObject>

-(void)tappedOnSmileyQuestionNumber:(int)qnumber subQuestionOption:(int)subQno comments:(NSString*)comments;

@end


@interface Sub_SurveyCell : UICollectionViewCell<UITextViewDelegate>
- (IBAction)highlyDissatisfiedClick:(id)sender;
- (IBAction)satisfiedClick:(id)sender;
- (IBAction)happyClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
- (IBAction)notApplicableClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *dissatisfiedImage;
@property (weak, nonatomic) IBOutlet UIImageView *satisfiedImage;
@property (weak, nonatomic) IBOutlet UIImageView *happyImage;
@property (weak, nonatomic) IBOutlet UIImageView *notApplicableImage;
@property (nonatomic) UICollectionView *parentCollectionView;
@property NSMutableArray *surveyArray;
@property int cellTagValue;


@property id<TappedOnSmiley>delegate;

@property (weak, nonatomic) IBOutlet UIView *vw1;
@property (weak, nonatomic) IBOutlet UIView *vw2;

@property (weak, nonatomic) IBOutlet UIView *vw3;
@property (weak, nonatomic) IBOutlet UIView *vw4;

-(void)hilightBackgroundView:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
