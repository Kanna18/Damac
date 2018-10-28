//
//  SurveyController.h
//  DamacC
//
//  Created by Gaian on 27/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SurveyController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)taketheSurveyClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
