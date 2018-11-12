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
    [self hilightImageView:_dissatisfiedImage];
    [self fillRating:_cellTagValue changeVale:2];
    [_delegate tappedOnSmiley:_TagValue];
}

- (IBAction)satisfiedClick:(id)sender {
    [self hilightImageView:_satisfiedImage];
    [self fillRating:_cellTagValue changeVale:1];
    [_delegate tappedOnSmiley:_TagValue];
  
}

- (IBAction)happyClick:(id)sender {
    [self hilightImageView:_happyImage];
    [self fillRating:_cellTagValue changeVale:0];
    [_delegate tappedOnSmiley:_TagValue];
}

- (IBAction)notApplicableClick:(id)sender {
    [self hilightImageView:_notApplicableImage];
    [self fillRating:_cellTagValue changeVale:3];
    [_delegate tappedOnSmiley:_TagValue];
}

-(void)hilightImageView:(UIImageView*)imgView{
    
    _satisfiedImage.highlighted = NO;
    _dissatisfiedImage.highlighted = NO;
    _happyImage.highlighted = NO;
    _notApplicableImage.highlighted = NO;
    
    imgView.highlighted = YES;
    if(imgView == _dissatisfiedImage){
        _textView.hidden = NO;
    }else{
        _textView.hidden = YES;
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
