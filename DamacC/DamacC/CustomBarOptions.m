//
//  CustomBarOptions.m
//  DamacC
//
//  Created by Gaian on 04/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CustomBarOptions.h"

#define heig 30
#define widt 30

@implementation CustomBarOptions

- (instancetype)initWithNavItems:(UINavigationItem*)nav noOfItems:(int)num navRef:(UINavigationController*)navRef withTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        
        NSArray *imgsArr = @[/*@"menu.png",@"logout.png",@"help.png",*/@"iconBell",@"iconSettings"/*@"home.png"*/];
        NSMutableArray *arr =[[NSMutableArray alloc]init];
        for (int i = 0 ; i<num&&num<=imgsArr.count; i++){
            [arr addObject:[self customNavigationBarButtonsimageName:imgsArr[i] withTag:i]];
        }
        nav.rightBarButtonItems = arr;
        
//        if(bord){
//            UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, 1)];
//            vw.backgroundColor = rgb(174, 134, 73);
//            [navRef.navigationBar addSubview:vw];
//        }else{
//            UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, 1)];
//            vw.backgroundColor = [UIColor clearColor];
//            [navRef.navigationBar addSubview:vw];
//        }
        
////        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON.png"]];
////        imageView.frame = CGRectMake(0, 0, 100, 30);
////        imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
//        nav.leftBarButtonItem = barButtonItem;
        navRef.navigationBar.topItem.title = title;
        navRef.navigationBar.barTintColor = [UIColor blackColor];

//        navRef.navigationBar.backItem.title = @"Changing ";
//        for (NSString *fNam in [UIFont familyNames]) {
//            NSLog(@"%@",fNam);
//        }
        [navRef.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:rgb(191, 154, 88),
           NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Medium" size:15]}];
    }
    return self;
}

-(UIBarButtonItem*)customNavigationBarButtonsimageName:(NSString*)imgName withTag:(int)tag{
    UIButton *home = [UIButton buttonWithType:UIButtonTypeSystem];
    [home setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    home.frame = CGRectMake(0, 0, heig, widt);
    
//    if(tag == 1){
//        [home addTarget:self action:@selector(loadNotifications) forControlEvents:UIControlEventTouchUpInside];
//    }
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:home];
    btn.target = self;
    if(tag == 1){
        btn.action = @selector(loadNotifications);
    }
    return btn;
}
-(void)loadNotifications{
    NotificationsTableVC *nvc = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"notificationsTableVC"];
    
    [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:nvc animated:YES];
}
@end
