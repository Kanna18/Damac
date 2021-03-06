//
//  NSString+StringValidations.m
//  DamacC
//
//  Created by Gaian on 22/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "NSString+StringValidations.h"

@implementation NSString (StringValidations)

- (BOOL)validateEmailWithString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)validatewithPhoneNumber{
    NSString *str1 = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"!~`@#$%^&*-+();:={}[],.<>?\\/\"\'"] invertedSet];
    if(str1.length>3)
    {
        NSString *str = [str1 substringToIndex:3];
        if([str isEqualToString:@"000"]){
            return NO;
        }
//        if ([str rangeOfCharacterFromSet:set].location != NSNotFound) {
//            NSLog(@"This string contains illegal characters");
//            return NO;
//        }
        else{
            return YES;
        }
    }
    return NO;
}
@end
