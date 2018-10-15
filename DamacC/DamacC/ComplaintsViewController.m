//
//  ComplaintsViewController.m
//  DamacC
//
//  Created by Gaian on 14/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ComplaintsViewController.h"

@interface ComplaintsViewController ()

@end

@implementation ComplaintsViewController{
    
    WYPopoverController *popoverController;
    CameraView *camView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self roundCorners:_selectUnitsButton];
    [self roundCorners:_selectComplaintBtn];
    [self roundCorners:_selectSubBtn];
    [self roundCorners:_attachDocButton];
    [self roundCorners:_submitSRButton];
    [self roundCorners:_saveDraftNumber];
    [DamacSharedClass sharedInstance].currentVC = self;
    camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:self];
    [self.view addSubview:camView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [DamacSharedClass sharedInstance].windowButton.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [DamacSharedClass sharedInstance].windowButton.hidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectUnits:(id)sender {
    
    [self showpopover:(UIButton*)sender withArrar:nil];
}

- (IBAction)selectCompleintClick:(id)sender {
    [self showpopover:(UIButton*)sender withArrar:nil];
}

- (IBAction)selectSubComplaint:(id)sender {
    [self showpopover:(UIButton*)sender withArrar:nil];
}
- (IBAction)attachmentClick1:(id)sender {
    [camView frameChangeCameraView];
}

- (IBAction)attachmentClick2:(id)sender {
    [camView frameChangeCameraView];
}

- (IBAction)attachDocument:(id)sender {
}

- (IBAction)submitSRClick:(id)sender {
}

- (IBAction)saveDraftClick:(id)sender {
}

-(void)roundCorners:(UIButton*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
}

-(void)showpopover:(UIButton*)drop withArrar:(NSArray*)arr{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, 600);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}
@end
