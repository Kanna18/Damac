//
//  Sub-SurveyCell.h
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sub_SurveyCell : UICollectionViewCell
- (IBAction)highlyDissatisfiedClick:(id)sender;
- (IBAction)satisfiedClick:(id)sender;
- (IBAction)happyClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
- (IBAction)notApplicableClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

NS_ASSUME_NONNULL_END
