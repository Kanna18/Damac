/*
 Copyright (c) 2011-present, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "AppDelegate.h"
#import "InitialViewController1.h"
#import "RootViewController.h"
#import <SalesforceAnalytics/SFSDKLogger.h>
#import <SalesforceSDKCore/SFSDKAppConfig.h>
#import <SalesforceSDKCore/SFPushNotificationManager.h>
#import <SalesforceSDKCore/SFDefaultUserManagementViewController.h>
#import <SalesforceSDKCore/SalesforceSDKManager.h>
#import <SalesforceSDKCore/SFUserAccountManager.h>
#import <SmartSync/SmartSyncSDKManager.h>
#import <SalesforceSDKCore/SFLoginViewController.h>
#import <SalesforceSDKCore/SFSDKLoginViewControllerConfig.h>
#import <UserNotifications/UserNotifications.h>
@import Firebase;
// Fill these in when creating a new Connected Application on Force.com
//static NSString * const RemoteAccessConsumerKey = @"3MVG9Iu66FKeHhINkB1l7xt7kR8czFcCTUhgoA8Ol2Ltf1eYHOU4SqQRSEitYFDUpqRWcoQ2.dBv_a1Dyu5xa";
//static NSString * const OAuthRedirectURI        = @"testsfdc:///mobilesdk/detect/oauth/done";


static NSString * const RemoteAccessConsumerKey = @"3MVG9rKhT8ocoxGn_OEneOzdBE_hGNaAmw0P4q6_2Hr2bEKvTWJPcKlwOhQ2QETA3UNEKjWYxQ1xi3GTHmvDN";
static NSString * const OAuthRedirectURI        = @"sfdc://success";

NSString *const kGCMMessageIDKey = @"gcm.message_id";

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

/**
 * Convenience method for setting up the main UIViewController and setting self.window's rootViewController
 * property accordingly.
 */
- (void)setupRootViewController;

/**
 * (Re-)sets the view state when the app first loads (or post-logout).
 */
- (void)initializeAppViewState;

@end

@implementation AppDelegate

//BOOL touchIDAvailable= NO, faceIDavailable=NO;

@synthesize window = _window;

- (instancetype)init // commented by me -- to load password VC
{
    self = [super init];
    if (self) {
        [SalesforceSDKManager setInstanceClass:[SmartSyncSDKManager class]];
        [SmartSyncSDKManager sharedManager].appConfig.remoteAccessConsumerKey = RemoteAccessConsumerKey;
        [SmartSyncSDKManager sharedManager].appConfig.oauthRedirectURI = OAuthRedirectURI;
        [SmartSyncSDKManager sharedManager].appConfig.oauthScopes = [NSSet setWithArray:@[ @"web", @"api" ]];

        //Uncomment the following line in order to enable/force the use of advanced authentication flow.
        //[SFUserAccountManager sharedInstance].advancedAuthConfiguration = SFOAuthAdvancedAuthConfigurationRequire;
        // OR
        // To  retrieve advanced auth configuration from the org, to determine whether to initiate advanced authentication.
        //[SFUserAccountManager sharedInstance].advancedAuthConfiguration = SFOAuthAdvancedAuthConfigurationAllow;

        // NOTE: If advanced authentication is configured or forced,  it will launch Safari to handle authentication
        // instead of a webview. You must implement application:openURL:options: to handle the callback.

        __weak AppDelegate *weakSelf = self;
        [SmartSyncSDKManager sharedManager].postLaunchAction = ^(SFSDKLaunchAction launchActionList) {
            //
            // If you wish to register for push notifications, uncomment the line below.  Note that,
            // if you want to receive push notifications from Salesforce, you will also need to
            // implement the application:didRegisterForRemoteNotificationsWithDeviceToken: method (below).
            //
            //[[SFPushNotificationManager sharedInstance] registerForRemoteNotifications];
            //
            [SFSDKLogger log:[weakSelf class] level:DDLogLevelInfo format:@"Post-launch: launch actions taken: %@", [SmartSyncSDKManager launchActionsStringRepresentation:launchActionList]];
            [weakSelf setupRootViewController];
        };
        [SmartSyncSDKManager sharedManager].launchErrorAction = ^(NSError *error, SFSDKLaunchAction launchActionList) {
            [SFSDKLogger log:[weakSelf class] level:DDLogLevelError format:@"Error during SDK launch: %@", error.localizedDescription];
            [weakSelf initializeAppViewState];
            [[SmartSyncSDKManager sharedManager] launch];
        };
        [SmartSyncSDKManager sharedManager].postLogoutAction = ^{
            [weakSelf handleSdkManagerLogout];
        };
        [SmartSyncSDKManager sharedManager].switchUserAction = ^(SFUserAccount *fromUser, SFUserAccount *toUser) {
            [weakSelf handleUserSwitch:fromUser toUser:toUser];
        };
        
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            
            statusBar.backgroundColor = [UIColor blackColor];//set whatever color you like
        }
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
        /**Commented By Me****/
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self initializeAppViewState];
    /**Commented By Me****/
    
    
    
//    [[UILabel appearance] setFont:[UIFont fontWithName:@"Helvetica Neuel" size:16]];
//    [[UILabel appearance] setTextColor:rgb(174, 134, 73)];

    
    //Uncomment the code below to see how you can customize the color, textcolor, font and   fontsize of the navigation bar
    //SFSDKLoginViewControllerConfig *loginViewConfig = [[SFSDKLoginViewControllerConfig  alloc] init];
    //Set showSettingsIcon to NO if you want to hide the settings icon on the nav bar
    //loginViewConfig.showSettingsIcon = YES;
    //Set showNavBar to NO if you want to hide the top bar
    //loginViewConfig.showNavbar = YES;
    //loginViewConfig.navBarColor = [UIColor colorWithRed:0.051 green:0.765 blue:0.733 alpha:1.0];
    //loginViewConfig.navBarTextColor = [UIColor whiteColor];
    //loginViewConfig.navBarFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    //[SFUserAccountManager sharedInstance].loginViewControllerConfig = loginViewConfig;
    
    [[SmartSyncSDKManager sharedManager] launch];
    
    [FIRApp configure];
    // [END configure_firebase]
    
    // [START set_messaging_delegate]
    [FIRMessaging messaging].delegate = self;
    // [END set_messaging_delegate]
    
    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [application registerForRemoteNotifications];
    // [END register_for_notifications]

    return YES;
}


#pragma Mark Delegates FCM

// [START receive_message]
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}
// [END receive_message]

// [START ios_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}

// [END ios_10_message_handling]




// [START refresh_token]
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// [END refresh_token]



// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
// With "FirebaseAppDelegateProxyEnabled": NO
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Uncomment the code below to register your device token with the push notification manager
    //
    //[[SFPushNotificationManager sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    //if ([SFUserAccountManager sharedInstance].currentUser.credentials.accessToken != nil) {
    //    [[SFPushNotificationManager sharedInstance] registerForSalesforceNotifications];
    //}
    //
    
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    
    // With swizzling disabled you must set the APNs device token here.
    [FIRMessaging messaging].APNSToken = deviceToken;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

    // If you're using advanced authentication:
    // --Configure your app to handle incoming requests to your
    //   OAuth Redirect URI custom URL scheme.
    // --Uncomment the following line and delete the original return statement:

    // return [[SFUserAccountManager sharedInstance] handleAdvancedAuthenticationResponse:url options:options];
    return NO;
}

#pragma mark - Private methods

- (void)initializeAppViewState
{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initializeAppViewState];
        });
        return;
    }

    self.window.rootViewController = [[InitialViewController1 alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];
}

- (void)setupRootViewController
{
        /*Commented by Me*/
    [self findFingerPrintAndFaceIDisavailableorNot];
    /*Commented by Me*/
//    RootViewController *rootVC = [[RootViewController alloc] initWithNibName:nil bundle:nil];
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
//    self.window.rootViewController = navVC;
    /*Commented by Me*/

//    UIStoryboard *appStoryboard =
//    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *navigationController =
//    [appStoryboard instantiateViewControllerWithIdentifier:@"mainNavigation"];
//    self.window.rootViewController = navigationController;


    UIStoryboard *appStoryboard =
    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(defaultGet(kMPin)&&defaultGet(kconfirmMpin)){
        
        KeyViewController *key =[appStoryboard instantiateViewControllerWithIdentifier:@"keyVC"];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:key];
        navVC.navigationBar.hidden=YES;
        self.window.rootViewController = navVC;
    }else if(defaultGetBool(kFingerPrintAvailabe)){
        FingerPrintViewController *rootVC = [appStoryboard instantiateViewControllerWithIdentifier:@"fingerPrintVC"];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
        navVC.navigationBar.hidden=YES;
        self.window.rootViewController = navVC;
    }else if(!defaultGetBool(kFingerPrintAvailabe)){
        PasswordViewController *rootVC = [appStoryboard instantiateViewControllerWithIdentifier:@"passwordVC"];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
        navVC.navigationBar.hidden=YES;
        self.window.rootViewController = navVC;
    }
}


- (void)resetViewState:(void (^)(void))postResetBlock
{
    if ((self.window.rootViewController).presentedViewController) {
        [self.window.rootViewController dismissViewControllerAnimated:NO completion:^{
            postResetBlock();
        }];
    } else {
        postResetBlock();
    }
}

- (void)handleSdkManagerLogout
{
    [SFSDKLogger log:[self class] level:DDLogLevelDebug format:@"SFUserAccountManager logged out. Resetting app."];
    [self resetViewState:^{
        [self initializeAppViewState];

        // Multi-user pattern:
        // - If there are two or more existing accounts after logout, let the user choose the account
        //   to switch to.
        // - If there is one existing account, automatically switch to that account.
        // - If there are no further authenticated accounts, present the login screen.
        //
        // Alternatively, you could just go straight to re-initializing your app state, if you know
        // your app does not support multiple accounts.  The logic below will work either way.
        NSArray *allAccounts = [SFUserAccountManager sharedInstance].allUserAccounts;
        if (allAccounts.count > 1) {
            SFDefaultUserManagementViewController *userSwitchVc = [[SFDefaultUserManagementViewController alloc] initWithCompletionBlock:^(SFUserManagementAction action) {
                [self.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
            }];
            [self.window.rootViewController presentViewController:userSwitchVc animated:YES completion:NULL];
        } else {
            if (allAccounts.count == 1) {
                [SFUserAccountManager sharedInstance].currentUser = ([SFUserAccountManager sharedInstance].allUserAccounts)[0];
            }
            [[SmartSyncSDKManager sharedManager] launch];
        }
    }];
}

- (void)handleUserSwitch:(SFUserAccount *)fromUser
                  toUser:(SFUserAccount *)toUser
{
    [SFSDKLogger log:[self class] level:DDLogLevelDebug format:@"SFUserAccountManager changed from user %@ to %@.  Resetting app.",
     fromUser.userName, toUser.userName];
    [self resetViewState:^{
        [self initializeAppViewState];
        [[SmartSyncSDKManager sharedManager] launch];
    }];
}


-(void)findFingerPrintAndFaceIDisavailableorNot{

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
//                touchIDAvailable=YES;
                defaultSetBool(YES, kFingerPrintAvailabe);
            }else{
                defaultSetBool(NO, kFingerPrintAvailabe);
//                touchIDAvailable = NO;
            }
            if(context.biometryType == LABiometryTypeFaceID){
                NSLog(@"Fingerprint authentication available.");
//                faceIDavailable=YES;
                defaultSetBool(YES, kFaceIDAvailabe);
            }else{
//                faceIDavailable = NO;
                defaultSetBool(NO, kFaceIDAvailabe);
            }
        }
    }
}
@end
