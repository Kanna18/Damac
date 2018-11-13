//
//  Sub-SurveyCell.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "Sub-SurveyCell.h"

@implementation Sub_SurveyCell{
    BOOL additionalResponseNeeded;
    
    int subQuestionNumber, surveySelectedOption;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _textView.delegate = self;
    _textView.hidden = YES;
        
}


- (IBAction)highlyDissatisfiedClick:(id)sender {
    [self hilightImageView:_dissatisfiedImage withBkgroundView:_vw1];
    [self fillRating:_cellTagValue changeVale:2];
    [_delegate tappedOnSmiley:_TagValue questionNumber:_cellTagValue option:0];
}

- (IBAction)satisfiedClick:(id)sender {
    [self hilightImageView:_satisfiedImage withBkgroundView:_vw2];
    [self fillRating:_cellTagValue changeVale:1];
    [_delegate tappedOnSmiley:_TagValue questionNumber:_cellTagValue option:1];
  
}

- (IBAction)happyClick:(id)sender {
    [self hilightImageView:_happyImage withBkgroundView:_vw3];
    [self fillRating:_cellTagValue changeVale:0];
    [_delegate tappedOnSmiley:_TagValue questionNumber:_cellTagValue option:2];
}

- (IBAction)notApplicableClick:(id)sender {
    [self hilightImageView:_notApplicableImage withBkgroundView:_vw4];
    [self fillRating:_cellTagValue changeVale:3];
    [_delegate tappedOnSmiley:_TagValue questionNumber:_cellTagValue option:3];
}

-(void)hilightImageView:(UIImageView*)imgView withBkgroundView:(UIView*)view{
   
    if((view.tag == _TagValue)&&(imgView.tag == _TagValue)){
    
    _satisfiedImage.highlighted = NO;
    _dissatisfiedImage.highlighted = NO;
    _happyImage.highlighted = NO;
    _notApplicableImage.highlighted = NO;
    _vw1.backgroundColor = rgb(85, 85, 85);
    _vw2.backgroundColor = rgb(85, 85, 85);
    _vw3.backgroundColor = rgb(85, 85, 85);
    _vw4.backgroundColor = rgb(85, 85, 85);
    
    view.backgroundColor = [UIColor blackColor];
    imgView.highlighted = YES;
    if(imgView == _dissatisfiedImage){
        _textView.hidden = NO;        
    }else{
        _textView.hidden = YES;
    }
    }
}

#pragma mark TextField Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"Please Specify Reason"]){
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
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if([textView.text isEqualToString:@""]){
        textView.text =@"Please Specify Reason";
        additionalResponseNeeded = YES;
        
    }
    
     if(!(isEmpty(textView.text))){
         NSMutableArray *dict = [_surveyArray[1] valueForKey:@"subQuestions"];
         NSMutableDictionary *subDict = dict[subQuestionNumber];
         [subDict setValue:[NSNumber numberWithBool:YES] forKey:@"renderFreeText"];
         additionalResponseNeeded = NO;
         
     }
    [_optionsDict setValue:[NSNumber numberWithBool:additionalResponseNeeded] forKey:[NSString stringWithFormat:@"%d",subQuestionNumber]];

    
}
-(void)fillRating:(int)value changeVale:(int)changeVal{
    
    
    subQuestionNumber =value;
    surveySelectedOption = changeVal;
    
    NSMutableArray *dict = [_surveyArray[1] valueForKey:@"subQuestions"];
    NSMutableDictionary *subDict = dict[value];
     [subDict setValue:[NSString stringWithFormat:@"%d",changeVal] forKey:@"selectedOption"];
    
    
    if(changeVal == 2){
        [subDict setValue:[NSNumber numberWithBool:YES] forKey:@"renderFreeText"];
        additionalResponseNeeded = YES;
        
    }else{
        [subDict setValue:[NSNumber numberWithBool:NO] forKey:@"renderFreeText"];
        additionalResponseNeeded = NO;
    }
    
    [_optionsDict setValue:[NSNumber numberWithBool:additionalResponseNeeded] forKey:[NSString stringWithFormat:@"%d",value]];
}
@end
