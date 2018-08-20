//
//  CustomBarOptions.m
//  DamacC
//
//  Created by Gaian on 04/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CustomBarOptions.h"

#define height 30
#define width 30

@implementation CustomBarOptions

- (instancetype)initWithNavItems:(UINavigationItem*)nav noOfItems:(int)num
{
    self = [super init];
    if (self) {
        
        NSArray *imgsArr = @[/*@"menu.png",@"logout.png",@"help.png",*/@"iconSettings",@"iconBell"/*@"home.png"*/];
        NSMutableArray *arr =[[NSMutableArray alloc]init];
        for (int i = 0 ; i<num&&num<=imgsArr.count; i++){
            [arr addObject:[self customNavigationBarButtonsimageName:imgsArr[i]]];
        }
        nav.rightBarButtonItems = arr;
        
        
////        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON.png"]];
////        imageView.frame = CGRectMake(0, 0, 100, 30);
////        imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
//        nav.leftBarButtonItem = barButtonItem;
    }
    return self;
}

-(UIBarButtonItem*)customNavigationBarButtonsimageName:(NSString*)imgName{
    UIButton *home = [UIButton buttonWithType:UIButtonTypeSystem];
    [home setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    home.frame = CGRectMake(0, 0, height, width);
    return [[UIBarButtonItem alloc]initWithCustomView:home];
}

@end
