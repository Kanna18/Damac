//
//  SurveyCell2.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell2.h"

@implementation SurveyCell2{
    
    int tappedCEllIndex, labelsCount;
    BOOL additionalResponseNeeded;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    tappedCEllIndex = -1;
    _textView.delegate = self;
    _textViewHeightConstraint.constant = 0;
    _continueSurveyBtn.enabled = NO;
    labelsCount = 10;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SurveyRatingCell *cell =[tableView dequeueReusableCellWithIdentifier:@"surveyRatingCell" forIndexPath:indexPath];
    cell.surveyArray =  _surveyArray;
    if(tappedCEllIndex == -1){
        cell.colorPad.backgroundColor = [UIColor grayColor];
    }
    else if(tappedCEllIndex > indexPath.row){
        cell.colorPad.backgroundColor = [UIColor grayColor];
    }else{
        cell.colorPad.backgroundColor = goldColor;
    }
    cell.Nolabel.text = [NSString stringWithFormat:@"%d",labelsCount-(int)indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    /*Logic For Hilighiting*/
    if(tappedCEllIndex == indexPath.row){
        tappedCEllIndex++;
    }else{
        tappedCEllIndex = (int)indexPath.row;
    }
    /*Logic For Hiding TExtView*/
    if(indexPath.row<=1){
        _textViewHeightConstraint.constant = 0;
    }else{
        _textViewHeightConstraint.constant = 40;
    }
    /*Logic For Hilighiting ContinueButton*/
    if(tappedCEllIndex>=10){
        _continueSurveyBtn.backgroundColor = [UIColor lightGrayColor];
        _continueSurveyBtn.enabled = NO;
        _textViewHeightConstraint.constant = 0;
    }else{
        _continueSurveyBtn.backgroundColor = goldColor;
        _continueSurveyBtn.enabled = YES;
    }
    [_tableView reloadData];
    [self fillRating:(10-tappedCEllIndex)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vw = [[UIView alloc]initWithFrame:CGRectZero];
    vw.backgroundColor = [UIColor blackColor];
    return vw;
}

#pragma mark TextField Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"Please tell us the reason for your low rating"]){
        textView.text =@"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text =@"Please tell us the reason for your low rating";
        additionalResponseNeeded = YES;

    }
    if(!(isEmpty(textView.text))){
        NSMutableDictionary *dict = _surveyArray[0];
        [dict setValue:textView.text forKey:@"additionalResponse"];
        additionalResponseNeeded = NO;
    }
    
}


- (IBAction)surveyBtnClick:(id)sender {
    
    if(additionalResponseNeeded){
        [FTIndicator showToastMessage:@"Please enter comments for your low rating"];
    }else{
        [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
    
}


-(void)fillRating:(int)value{
    
    NSMutableDictionary *dict = _surveyArray[0];
    [dict setValue:[NSString stringWithFormat:@"%d",value] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    if(value<8){
        [dict setValue:[NSNumber numberWithBool:YES] forKey:@"renderFreeText"];
        additionalResponseNeeded = YES;
    }else{
        [dict setValue:[NSNumber numberWithBool:NO] forKey:@"renderFreeText"];
        [dict setValue:@"" forKey:@"additionalResponse"];
        additionalResponseNeeded = NO;
    }

}



#pragma Mark Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = CGRectMake(0, (keyboardSize.height-_textView.frame.size.height-_textView.frame.origin.y),self.contentView.frame.size.width,self.contentView.frame.size.height);
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

-(void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"prepar for reuse Cell 2");
    
}

@end
