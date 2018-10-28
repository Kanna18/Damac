//
//  SurveyCell5.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell5.h"

@implementation SurveyCell5

- (IBAction)oneClick:(id)sender{
    [self oveToNext];
    [self fillRating:1];
}

- (IBAction)twoclick:(id)sender{
    [self oveToNext];
    [self fillRating:2];
}
- (IBAction)threeClick:(id)sender{
    [self oveToNext];
    [self fillRating:3];
}
- (IBAction)fourCLick:(id)sender{
    [self oveToNext];
    [self fillRating:4];
}
- (IBAction)fiveClick:(id)sender{
    [self oveToNext];
    [self fillRating:5];
}

-(void)oveToNext{
    [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}
-(void)fillRating:(int)value{
    
    NSMutableDictionary *dict = _surveyArray[3];
    [dict setValue:[NSString stringWithFormat:@"%d",value] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    
}
@end
