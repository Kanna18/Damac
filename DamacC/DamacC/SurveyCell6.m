//
//  SurveyCell6.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell6.h"
#import "FinishSurveyViewController.h"

@implementation SurveyCell6

-(void)awakeFromNib{
    
    [super awakeFromNib];
    _surveyButton.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _uitextView.delegate = self;
}
- (IBAction)oneClick:(id)sender{
    [self oveToNext];
    [self fillRating:0];
}

- (IBAction)twoclick:(id)sender{
    [self oveToNext];
    [self fillRating:1];
}
- (IBAction)threeClick:(id)sender{
    [self oveToNext];
    [self fillRating:2];
}
- (IBAction)fourCLick:(id)sender{
    [self oveToNext];
    [self fillRating:3];
}

-(void)oveToNext{
//    [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    _surveyButton.enabled = YES;
    _surveyButton.backgroundColor = goldColor;
}
-(void)fillRating:(int)value{
    
    NSMutableDictionary *dict = _surveyArray[4];
    [dict setValue:[NSString stringWithFormat:@"%d",value] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    
}
- (IBAction)surveyClick:(id)sender {
    
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    NSDictionary *dict = @{@"allQuestions":_surveyArray};
    NSString *Data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:Data encoding:NSUTF8StringEncoding];
    [server postRequestwithUrl:@"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/Customer/services/apexrest/surveyResponse/" withParameters:dict successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"resp -%@",resp);
            [self performSelectorOnMainThread:@selector(finishSurveyViewController) withObject:nil waitUntilDone:YES];
        }
        
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
}
-(void)finishSurveyViewController{
    
    FinishSurveyViewController *finish = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"finishSurveyViewController"];
    [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:finish animated:YES];
}


#pragma Mark Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = CGRectMake(0, (keyboardSize.height-_uitextView.frame.size.height-_uitextView.frame.origin.y),self.contentView.frame.size.width,self.contentView.frame.size.height);
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

#pragma mark TextField Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"Please share any other comments you have"]){
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
        textView.text =@"Please share any other comments you have";
    }
}


@end
