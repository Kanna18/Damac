//
//  SurveyCell5.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell5.h"

@implementation SurveyCell5{
    
    UIButton *currentButton;
}

- (IBAction)oneClick:(id)sender{
    [self oveToNext];
    [self fillRating:1];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}

- (IBAction)twoclick:(id)sender{
    [self oveToNext];
    [self fillRating:2];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}
- (IBAction)threeClick:(id)sender{
    [self oveToNext];
    [self fillRating:3];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}
- (IBAction)fourCLick:(id)sender{
    [self oveToNext];
    [self fillRating:4];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}
- (IBAction)fiveClick:(id)sender{
    [self oveToNext];
    [self fillRating:5];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}

-(void)oveToNext{
    [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}
-(void)fillRating:(int)value{
    
    NSMutableDictionary *dict = _surveyArray[3];
    [dict setValue:[NSString stringWithFormat:@"%d",value] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    
}

-(void)setSelectedButtonBackgroundColor:(UIButton*)sender{
    
    sender.selected = YES;
    currentButton.selected = NO;
    currentButton = (UIButton*)sender;
    
}

-(void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"prepar for reuse Cell 5");
    
}
@end
