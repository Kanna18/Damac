//
//  PasswordViewController.m
//  DamacC
//
//  Created by Gaian on 01/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PasswordViewController.h"
#import "DamacC-Bridging-Header.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface PasswordViewController (){
    
    PinView *mpin, *confirmPin;
    CGFloat screen_width, screen_height;
    
}

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    screen_width = [UIScreen mainScreen].bounds.size.width;
    screen_height = [UIScreen mainScreen].bounds.size.height;
    
    _resetButton.layer.borderWidth = 1.0f;
    _resetButton.layer.borderColor = rgb(191, 154, 88).CGColor;
    
    [self loadPinViews];
    
    
}

-(void)loadPinViews{
    
    mpin =[[PinView alloc]initWithFrame:CGRectMake(screen_width/2-144, screen_height/2-100, 0, 0)];
    mpin.type = kMPin;
    mpin.pinheadingLabel.text = @"SET MPIN";
    [self.view addSubview:mpin];
    
    
    confirmPin = [[PinView alloc]initWithFrame:CGRectMake(screen_width/2-144, screen_height/2+30, 0, 0)];
    confirmPin.type = kconfirmMpin;
    confirmPin.pinheadingLabel.text = @"CONFIRM MPIN";
    [self.view addSubview:confirmPin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitClick:(id)sender {
    
    NSString *mpin = [defaultGet(kMPin) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *confirm = [defaultGet(kconfirmMpin) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([mpin isEqualToString:confirm]){
        [FTIndicator showToastMessage:@"MPIN Successfully created"];
        KeyViewController *key =[self.storyboard instantiateViewControllerWithIdentifier:@"keyVC"];
        [self.navigationController pushViewController:key animated:YES];
        
    }else{
        [FTIndicator showToastMessage:@"Pins are not Matching"];
    }
}

-(void)biometricOrFaceIDrecognition{
    
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    
    LAContext *context = [[LAContext alloc] init];
    // Test if fingerprint authentication is available on the device and a fingerprint has been enrolled.
    if ([context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil])
    {
        if (@available(iOS 11.0, *))
        {
            if(context.biometryType == LABiometryTypeTouchID){
                NSLog(@"Fingerprint authentication available.");
            }
            if(context.biometryType == LABiometryTypeFaceID){
                NSLog(@"Fingerprint authentication available.");
            }
        }
        
    }
    
    NSString *myLocalizedReasonString = @"Authenticate using your finger";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    NSLog(@"User is authenticated successfully");
                                } else {
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                            NSLog(@"Authentication Failed");
                                            break;
                                            
                                        case LAErrorUserCancel:
                                            NSLog(@"User pressed Cancel button");
                                            break;
                                            
                                        case LAErrorUserFallback:
                                            NSLog(@"User pressed \"Enter Password\"");
                                            break;
                                            
                                        default:
                                            NSLog(@"Touch ID is not configured");
                                            break;
                                    }
                                    NSLog(@"Authentication Fails");
                                }
                            }];
    } else {
        NSLog(@"Can not evaluate Touch ID");
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
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
