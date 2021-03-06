//
//  KeyViewController.m
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "KeyViewController.h"
#import "LoadingLogoVC.h"
@interface KeyViewController ()

@end

@implementation KeyViewController{
    PinView *mpin, *confirmPin;
    CGFloat screen_width, screen_height;
    __weak IBOutlet UILabel *accessDeniedLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.barTintColor = rgb(230, 193, 0);
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = rgb(174, 134, 73);
    if(defaultGetBool(kfingerPrintAccessGranted)){
        accessDeniedLabel.hidden = YES;
    }else{
        accessDeniedLabel.hidden = NO;
    }
}

- (IBAction)biometric:(id)sender {
    if(defaultGetBool(kfingerPrintAccessGranted)){
        [self biometricOrFaceIDrecognition];
    }else{
        [FTIndicator showToastMessage:@"Finger Print Access is not registered"];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(compareMpin) name:MPIN_ENTERED_NOTIFICATION object:nil];
    screen_width = [UIScreen mainScreen].bounds.size.width;
    screen_height = [UIScreen mainScreen].bounds.size.height;
    [self loadPinViews];
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    for (CustomBar *cstB in self.navigationController.view.subviews) {
        if([cstB isKindOfClass:[CustomBar class]]){
            [cstB removeFromSuperview];
        }
    }
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPIN_ENTERED_NOTIFICATION object:nil];
}


-(void)compareMpin{
    NSString *str = [defaultGet(kenterMpin) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *s = [defaultGet(kMPin) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([str isEqualToString: s]){
//        MainViewController *m =[self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
//        [self.navigationController pushViewController:m animated:YES];
        [self loadNextVC];
        
    }else{
        [FTIndicator showToastMessage:@"MPIN is not correct"];
    }
    
}
-(void)loadNextVC{
    LoadingLogoVC *lc = [self.storyboard instantiateViewControllerWithIdentifier:@"loadingLogoVC"];
    [self.navigationController pushViewController:lc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPinViews{
//    288
//    120
    mpin =[[PinView alloc]initWithFrame:CGRectMake(screen_width/2-144, screen_height/2-120, 0, 0)];
    mpin.type = kenterMpin;
    mpin.pinheadingLabel.text = @"ENTER MPIN";
    [self.view addSubview:mpin];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

-(void)biometricOrFaceIDrecognition{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authenticate using your finger";
//    myContext.localizedFallbackTitle=@"";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    [self performSelectorOnMainThread:@selector(loadNextVC) withObject:nil waitUntilDone:YES];
                                } else {
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                            NSLog(@"Authentication Failed");
                                            [self biometricOrFaceIDrecognition];
                                            break;
                                        case LAErrorUserCancel:
                                            NSLog(@"User pressed Cancel button");
                                            //                                            [self performSelectorOnMainThread:@selector(gotoSetMpinViewController) withObject:nil waitUntilDone:YES];
                                            break;
                                        case LAErrorUserFallback:
                                            NSLog(@"User pressed \"Enter Password\"");
                                            [self biometricOrFaceIDrecognition];
                                            break;
                                        default:
                                            NSLog(@"Touch ID is not configured");
                                            [self biometricOrFaceIDrecognition];
                                            break;
                                    }
                                    NSLog(@"Authentication Fails");
                                }
                            }];
    } else {
        NSLog(@"Can not evaluate Touch ID");
    }
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
