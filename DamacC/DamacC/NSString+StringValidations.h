//
//  NSString+StringValidations.h
//  DamacC
//
//  Created by Gaian on 22/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (StringValidations)
- (BOOL)validateEmailWithString;
-(BOOL)validatewithPhoneNumber;
@end

NS_ASSUME_NONNULL_END
