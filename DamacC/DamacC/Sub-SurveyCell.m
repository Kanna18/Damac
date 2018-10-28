//
//  Sub-SurveyCell.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "Sub-SurveyCell.h"

@implementation Sub_SurveyCell{
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _textView.delegate = self;
    _textView.hidden = YES;
  
    
}


- (IBAction)highlyDissatisfiedClick:(id)sender {
    [self hilightImageView:_dissatisfiedImage];
    [self fillRating:_cellTagValue changeVale:2];
}

- (IBAction)satisfiedClick:(id)sender {
    [self hilightImageView:_satisfiedImage];
    [self fillRating:_cellTagValue changeVale:1];
  
}

- (IBAction)happyClick:(id)sender {
    [self hilightImageView:_happyImage];
    [self fillRating:_cellTagValue changeVale:0];
}

- (IBAction)notApplicableClick:(id)sender {
    [self hilightImageView:_notApplicableImage];
    [self fillRating:_cellTagValue changeVale:3];
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
    if([textView.text isEqualToString:@""]){
        textView.text =@"Please Specify Reason";
    }

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)fillRating:(int)value changeVale:(int)changeVal{
    
    NSMutableArray *dict = [_surveyArray[1] valueForKey:@"subQuestions"];
    NSMutableDictionary *subDict = dict[value];
    [subDict setValue:[NSString stringWithFormat:@"%d",changeVal] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    
}
@end
