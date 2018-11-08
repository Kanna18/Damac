//
//  FingerPrintViewController.m
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "FingerPrintViewController.h"



@interface FingerPrintViewController ()

@end

@implementation FingerPrintViewController{
    LAContext *myContext;
    double (^simpleBlock)(double,double);
    void (^paramsBlock)(double,double);
}
- (IBAction)fingerPrintTap:(id)sender {
    
    [self biometricOrFaceIDrecognition];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self performSelector:@selector(biometricOrFaceIDrecognition) withObject:nil afterDelay:2];
    myContext = [[LAContext alloc] init];
    
    
    SFUserAccountManager *sf =[SFUserAccountManager sharedInstance];
    NSLog(@"%@",sf.currentUserIdentity);
    if(DamacSharedClass.sharedInstance.windowButton){
        DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    }
}
- (IBAction)skipClick:(id)sender {
    
    defaultSetBool(NO, kfingerPrintAccessGranted);
    [self gotoSetMpinViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)biometricOrFaceIDrecognition{
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authenticate using your finger";
    myContext.localizedFallbackTitle=@"";
    if ([myContext canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    defaultSetBool(YES, kfingerPrintAccessGranted);
                                    [self performSelectorOnMainThread:@selector(gotoSetMpinViewController) withObject:nil waitUntilDone:YES];
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
-(void)gotoSetMpinViewController{
    PasswordViewController *rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"passwordVC"];
    [self.navigationController pushViewController:rootVC animated:YES];
}
@end
