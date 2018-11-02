//
//  SurveyCell3.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell3.h"
#import "Sub-SurveyCell.h"

@interface SurveyCell3()

@end

@implementation SurveyCell3

{
    NSArray *headingLabels;    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    headingLabels = @[@"Please rate our customer service representative on politness and courteousness",
                      @"Please rate our customer service representative on knowledge levels",
                      @"Please rate your overall experience on DAMAC customer service provided",
                      @"How would you rate your overall experience with DAMAC properties"
                      ];
    _continueSurveyBtn.enabled = YES;
    _optionsDict = [[NSMutableDictionary alloc]init];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return headingLabels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Sub_SurveyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sub_SurveyCell" forIndexPath:indexPath];
    cell.cellTagValue = (int)indexPath.row;
    cell.questionLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
    cell.headingLabel.text = headingLabels[indexPath.row];
    cell.surveyArray = _surveyArray;
    cell.optionsDict = _optionsDict;
    return cell;
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(_collectionView.frame.size.width-80, 340);
}
- (IBAction)continueSurveyClick:(id)sender {
    NSNumber *flag1 = [_optionsDict valueForKey:@"0"];
    NSNumber *flag2 = [_optionsDict valueForKey:@"1"];
    NSNumber *flag3 = [_optionsDict valueForKey:@"2"];
    NSNumber *flag4 = [_optionsDict valueForKey:@"3"];    
    if(flag1.boolValue||flag2.boolValue||flag3.boolValue||flag4.boolValue){
        [FTIndicator showToastMessage:@"Please specify reason"];
    }else{
     [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}
@end
