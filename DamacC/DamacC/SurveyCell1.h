//
//  SurveyCell1.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyCell1 : UICollectionViewCell
- (IBAction)emailClick:(id)sender;
- (IBAction)phoneClick:(id)sender;
- (IBAction)walkInClick:(id)sender;
- (IBAction)webChatClick:(id)sender;
- (IBAction)purposeOfChatClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueSurveyButton;

@end

NS_ASSUME_NONNULL_END
