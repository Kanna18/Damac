//
//  SurveyCell1.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyCell1.h"

@implementation SurveyCell1{
    
    WYPopoverController* popoverController;
    NSArray *dropitems;
    UIButton *btn;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    dropitems = @[@"Purpose of Contact",@"Handover", @"Assignment", @"contract", @"NOC", @"Parking", @"Rental Pool", @"Title Deed", @"Mortgage", @"Snagging", @"LOAMS", @"Other"];
    _continuSurveyBtn.backgroundColor = [UIColor grayColor];
    _continuSurveyBtn.enabled = NO;
    _textView.delegate = self;
    _textViewHeight.constant = 0;
}


-(void)showpopover:(UIButton*)drop{
    
    PopTableViewController *popVC=[DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData = dropitems;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, dropitems.count*50);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    [popoverController dismissPopoverAnimated:YES];
    [btn setTitle:str forState:UIControlStateNormal];
    if(tag>0){
        _continuSurveyBtn.backgroundColor = goldColor;
        _continuSurveyBtn.enabled = YES;
    }else{
        _continuSurveyBtn.backgroundColor = [UIColor grayColor];
        _continuSurveyBtn.enabled = NO;
    }
    if([str isEqualToString:@"Other"]){
        _textViewHeight.constant = 40;
    }else{
        _textViewHeight.constant = 0;
    }
    
}


- (IBAction)emailClick:(id)sender {
    [self fillWithOptionNumber:0];
}

- (IBAction)phoneClick:(id)sender {
    [self fillWithOptionNumber:1];
}

- (IBAction)walkInClick:(id)sender {
    [self fillWithOptionNumber:2];
}

- (IBAction)webChatClick:(id)sender {
    [self fillWithOptionNumber:3];
}

- (IBAction)purposeOfChatClick:(id)sender {
    btn = (UIButton*)sender;
    [self showpopover:btn];
    
}
- (IBAction)continueSurveyClick:(id)sender{
    
    [_parentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
}

#pragma mark TextField Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"Please Specify the purpose of contact"]){
        textView.text =@"";
    }
    if([textView.text isEqualToString:@""]){
        textView.text =@"Please Specify the purpose of contact";
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)fillWithOptionNumber:(int)value{
    
    NSMutableDictionary *dict = _surveyArray[4];
    [dict setValue:[NSString stringWithFormat:@"%d",value] forKey:@"selectedOption"];
    NSLog(@"%@",_surveyArray);
    
}
@end
