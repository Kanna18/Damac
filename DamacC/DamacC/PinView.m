//
//  PinView.m
//  DamacC
//
//  Created by Gaian on 29/04/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PinView.h"

@implementation PinView{
    
    NSMutableString *collectPin;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self=[[NSBundle mainBundle]loadNibNamed:@"PinView" owner:self options:nil][0];
        frame.size.height = 100;
        frame.size.width = 288;
        self.frame = frame;
        
        _pin_tf1.tag=100;
        _pin_tf2.tag=101;
        _pin_tf3.tag=102;
        _pin_tf4.tag=103;
        collectPin = [[NSMutableString alloc]initWithString:@"    "];
        [self roundRadius:_pin_tf1];
        [self roundRadius:_pin_tf2];
        [self roundRadius:_pin_tf3];
        [self roundRadius:_pin_tf4];
    }
    return self;
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length > 0)
    {
        textField.text=string;
        [self getTheText:string ofTf:textField];
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (! nextResponder)
            nextResponder = [textField.superview viewWithTag:1];
            textField.layer.borderColor = rgb(191, 154, 88).CGColor;

        if (nextResponder)
            // Found next responder, so set it.
            textField.layer.borderColor = rgb(191, 154, 88).CGColor;
            [nextResponder becomeFirstResponder];
        return NO;
    }
    return YES;
}

-(void)getTheText:(NSString*)str ofTf:(UITextField*)tf{
    NSRange rang = NSMakeRange(tf.tag-100, 1);
    
    [collectPin replaceCharactersInRange:rang withString:str];
    if([collectPin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==4&&![collectPin containsString:@"*"]){
        [collectPin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([_type isEqualToString: kMPin]){
            defaultSet(collectPin, kMPin);
        }else if ([_type isEqualToString: kconfirmMpin]){
            defaultSet(collectPin, kconfirmMpin);
        }else if([_type isEqualToString:kenterMpin]){
            defaultSet(collectPin, kenterMpin);
            [[NSNotificationCenter defaultCenter]postNotificationName:MPIN_ENTERED_NOTIFICATION object:nil];            
        }
    }
}
-(void)delete:(id)sender{
    
    UITextField *textField = sender;
    textField.text=@"";
    
    NSInteger nextTag = textField.tag - 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (! nextResponder){
        nextResponder = [textField.superview viewWithTag:1];
        [textField resignFirstResponder];
    }
    
    if (nextResponder)
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text=@"";
    [collectPin replaceCharactersInRange:NSMakeRange(textField.tag-100, 1) withString:@"*"];
    
//    [self getTheText:textField.text ofTf:textField];
    textField.layer.borderColor = rgb(35, 22, 35).CGColor;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)roundRadius:(UITextField*)tf{
    tf.layer.cornerRadius=tf.frame.size.height/2;
    tf.layer.borderWidth = 2.0f;
    tf.layer.borderColor = rgb(191, 154, 88).CGColor;
    tf.clipsToBounds=YES;
}
@end
