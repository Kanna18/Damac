//
//  ErrorViewController.m
//  DamacC
//
//  Created by Gaian on 23/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ErrorViewController.h"

@interface ErrorViewController ()

@end

@implementation ErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FTIndicator showProgressWithMessage:@"Loading"];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [FTIndicator showToastMessage:@"Error Loading"];
            [FTIndicator dismissProgress];
            [self dismissViewControllerAnimated:YES completion:nil];
       
            if([DamacSharedClass.sharedInstance.currentVC isKindOfClass:[RentalPoolViewCellViewController class]])
            {
                [self offSetOFRentalPool];
            }
        });        
    });
}
-(void)offSetOFRentalPool{
    
        RentalPoolViewCellViewController *rvc = (RentalPoolViewCellViewController*)DamacSharedClass.sharedInstance.currentVC;
        [rvc.scrollView setContentOffset:CGPointMake(rvc.scrollView.frame.size.width+3, 0)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
