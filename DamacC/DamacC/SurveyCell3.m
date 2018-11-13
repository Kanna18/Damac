//
//  SurveyCell3.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell3.h"
#import "Sub-SurveyCell.h"

@interface SurveyCell3()<TappedOnSmiley>

@end

@implementation SurveyCell3

{
    NSArray *headingLabels;

}

- (void)awakeFromNib{
    [super awakeFromNib];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    headingLabels = @[@"Please rate our customer service representative on politeness and courteousness",
                      @"Please rate our customer service representative on knowledge levels",
                      @"Please rate your overall experience on DAMAC customer service provided",
                      @"How would you rate your overall experience with DAMAC properties"
                      ];
    _continueSurveyBtn.enabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _arrayOfDictionary = [[NSMutableArray alloc]init];
    for (int i=0; i<4; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"-1" forKey:surveyQuestionDictKey];
        [dict setValue:@"-1" forKey:surveyAnsDictKey];
        [dict setValue:@"Please Specify Reason " forKey:surveyCommentDictKey];
        [_arrayOfDictionary addObject:dict];
    }
    
    
    _continueSurveyBtn.enabled = NO;    
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
    cell.delegate = self;
    [cell hilightBackgroundView:_arrayOfDictionary[indexPath.row]];
    return cell;
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Highlighting CollectionView CEll");
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapping on CollectionView CEll");
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(_collectionView.frame.size.width-20, 340);
}

- (IBAction)continueSurveyClick:(id)sender {

    NSArray *arr = [_arrayOfDictionary valueForKey:surveyCommentDictKey];    
    if([arr containsObject:@"1"]){
        [FTIndicator showToastMessage:@"Please specify reason"];
    }else{
     [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

#pragma Mark Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = CGRectMake(0, -100,self.contentView.frame.size.width,self.contentView.frame.size.height);
    } else {
        contentInsets = CGRectMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.contentView.frame = contentInsets;
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.contentView.frame = CGRectMake(0, 0,self.contentView.frame.size.width,self.contentView.frame.size.height);;
    }];
}


#pragma subCell Delegate
-(void)tappedOnSmileyQuestionNumber:(int)qnumber subQuestionOption:(int)subQno comments:(NSString *)comments{
    
    NSMutableDictionary *dict = _arrayOfDictionary[qnumber];
    [dict setObject:[NSString stringWithFormat:@"%d",qnumber] forKey:surveyQuestionDictKey];
    [dict setObject:[NSString stringWithFormat:@"%d",subQno] forKey:surveyAnsDictKey];
    [dict setObject:comments forKey:surveyCommentDictKey];
    NSLog(@"%@",_arrayOfDictionary[qnumber]);
    
    NSArray *arr = [_arrayOfDictionary valueForKey:surveyAnsDictKey];
    if([arr containsObject:@"-1"]){
        _continueSurveyBtn.enabled = NO;
    }else{
        _continueSurveyBtn.enabled = YES;
        _continueSurveyBtn.backgroundColor = goldColor;
    }
    [_collectionView reloadData];

}
-(void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"prepar for reuse Cell 3");
    
}


@end
