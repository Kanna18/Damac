//
//  SurveyCell4.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell4.h"

@implementation SurveyCell4{
    
    UIButton *currentButton;
}

- (IBAction)oneClick:(id)sender {
    [self oveToNext];
    [self fillRating:0];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
    
}

- (IBAction)twoclick:(id)sender {
    [self oveToNext];
    [self fillRating:1];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}

- (IBAction)threeClick:(id)sender {
    [self oveToNext];
    [self fillRating:2];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}

- (IBAction)fourCLick:(id)sender {
    [self oveToNext];
    [self fillRating:3];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}

- (IBAction)fiveClick:(id)sender {
    [self oveToNext];
    [self setSelectedButtonBackgroundColor:(UIButton*)sender];
}
-(void)oveToNext{
    [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

-(void)fillRating:(int)value{
    
    NSMutableDictionary *dict = _surveyArray[2];
    [dict setValue:[NSString stringWithFormat:@"%d",value] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    
}
-(void)setSelectedButtonBackgroundColor:(UIButton*)sender{
  
    sender.selected = YES;
    currentButton.selected = NO;    
    currentButton = (UIButton*)sender;
    
}
@end
