//
//  FinishSurveyViewController.m
//  DamacC
//
//  Created by Gaian on 28/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "FinishSurveyViewController.h"

@interface FinishSurveyViewController ()

@end

@implementation FinishSurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okCLick:(id)sender {
    [self popToMainVC];
}

-(void)popToMainVC{
    [FTIndicator dismissProgress];
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}
@end
