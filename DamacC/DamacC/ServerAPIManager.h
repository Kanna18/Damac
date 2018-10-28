//
//  ServerAPIManager.h
//  Tripanzee
//
//  Created by Chandrika on 01/10/14.
//  Copyright (c) 2014 Raju Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^NetworkManagerCompletionBlock)(id responseObj);
typedef void ( ^NetworkManagerFailureBlock)(NSError *error);

typedef void (^CustomNetworkManagerCompletionBlok)(id responseObj);
typedef void (^CustomNetworkManagerErrorBlok)(NSError *error);

@interface ServerAPIManager : NSObject{
    
 }

@property (nonatomic, copy) NetworkManagerCompletionBlock completionBlock;
@property (nonatomic, copy) NetworkManagerFailureBlock failureBlock;

+ (instancetype)sharedinstance;
- (void)processRequest:(NSString*)path params:(id)params requestType:(NSString *)type successBlock:(NetworkManagerCompletionBlock)reqSuccessDic andErrorBlock:(NetworkManagerFailureBlock)reqErrorDic;
-(void)getRequestwithUrl:(NSString*)url successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock;
-(void)postRequestwithUrl:(NSString*)url withParameters:(NSDictionary*)dictParam successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock;
-(void)getRequestwithUrl:(NSString*)url withParameters:(NSDictionary*)dictParam successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock;
-(void)postRequestWithOutDict:(NSString*)url withParameters:(NSDictionary*)dictParam successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock;
 @end
