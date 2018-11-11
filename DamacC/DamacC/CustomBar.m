//
//  CustomBar.m
//  DamacC
//
//  Created by Gaian on 30/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "CustomBar.h"
#import "KeyViewController.h"
#import "HelpViewController.h"

@interface CustomBar ()<WYPopoverControllerDelegate,POPDelegate>

@end

@implementation CustomBar{
    
    WYPopoverController* popoverSettings;
    NSArray *pusrposeArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self = [[NSBundle mainBundle]loadNibNamed:@"CustomBar" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}
- (IBAction)backClick:(id)sender {
    if([_backBtn.imageView.image isEqual:[UIImage imageNamed:@"backArrow"]]){
        [DamacSharedClass.sharedInstance.currentVC.navigationController popViewControllerAnimated:YES];        
    }
}
- (IBAction)loadNotifications:(id)sender {
    
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (NotificationsTableVC *nvc in arr) {
        if([nvc isKindOfClass:[NotificationsTableVC class]]){
            return;
        }
    }    
    NotificationsTableVC *nvc = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"notificationsTableVC"];
    [DamacSharedClass.sharedInstance.navigationCustomBar.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:nvc animated:YES];
}
- (IBAction)settingsClick:(id)sender {
    
    [self showpopover:_settingsBtn];
}


-(void)showpopover:(UIButton*)drop{
    
    pusrposeArray = @[@"Help",@"LogOff"];
    
    PopTableViewController *popVC=[DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.thumbNailsArray = @[@"logOff",@"help"];
    popVC.delegate=self;
    popVC.tvData =pusrposeArray;
    popoverSettings = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverSettings.delegate = self;
    popVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    popoverSettings.popoverContentSize=CGSizeMake(140, pusrposeArray.count*50);
    popoverSettings.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverSettings presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}


#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    
    popoverSettings.delegate = nil;
    popoverSettings = nil;
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    
    if(tag == 1){
        
        NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
        
        KeyViewController *kvc = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"keyVC"];
        [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:kvc animated:YES];
//        for (KeyViewController *pvc in arr) {
//            if([pvc isKindOfClass:[KeyViewController class]]){
//                [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:pvc animated:YES];
//            }
//        }
    }
    if(tag == 0){
        HelpViewController *hvc = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"helpViewController"];
        [DamacSharedClass.sharedInstance.currentVC.navigationController presentViewController:hvc animated:YES completion:nil];        
    }
    [popoverSettings dismissPopoverAnimated:YES];
    
}

-(void)setPageTite:(NSString*)str{
    DamacSharedClass.sharedInstance.navigationCustomBar.NavigationTitle.text = str;
    DamacSharedClass.sharedInstance.navigationCustomBar.NavigationTitle.hidden = NO;
    DamacSharedClass.sharedInstance.navigationCustomBar.damacLogo.hidden = YES;
}

@end
