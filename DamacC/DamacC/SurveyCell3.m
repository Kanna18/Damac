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
    NSMutableArray *allOptionsSelectedArray;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    allOptionsSelectedArray = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0", nil];
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
    cell.TagValue = indexPath.row;
    cell.optionsDict = _optionsDict;
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
-(void)tappedOnSmiley:(int)cellIndex{
    [allOptionsSelectedArray replaceObjectAtIndex:cellIndex withObject:@"1"];
    if([allOptionsSelectedArray containsObject:@"0"]){
        _continueSurveyBtn.enabled = NO;
    }else{
        _continueSurveyBtn.enabled = YES;
        _continueSurveyBtn.backgroundColor = goldColor;
        
    }
    
}
-(void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"prepar for reuse Cell 3");
    
}


@end
