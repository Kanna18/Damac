//
//  CustomBarOptions.h
//  DamacC
//
//  Created by Gaian on 04/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomBarOptions : NSObject

- (instancetype)initWithNavItems:(UINavigationItem*)nav noOfItems:(int)num navRef:(UINavigationController*)navRef withTitle:(NSString*)title;

@end
