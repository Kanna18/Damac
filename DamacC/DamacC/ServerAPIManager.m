//
//  ServerAPIManager.m
//  Tripanzee
//
//  Created by Chandrika on 01/10/14.
//  Copyright (c) 2014 Raju Solutions. All rights reserved.
//

#import "ServerAPIManager.h"
#import "AFHTTPRequestOperationManager.h"

enum HTTPMethod {
    HTTPGet = 1729,
    HTTPPost,
    HTTPPut,
    HTTPDelete
};

@implementation ServerAPIManager



+ (instancetype)sharedinstance {
    static dispatch_once_t once;
    static ServerAPIManager *serverAPI = nil;
    dispatch_once(&once,^{
        serverAPI = [[ServerAPIManager alloc] init];
        
    });
    return serverAPI;
}

#define hostPath @"http://192.168.25.244:8080/IncoisRestAPI/ws/"

-(void)processRequest:(NSString*)path params:(id)params requestType:(NSString *)type successBlock:(NetworkManagerCompletionBlock)reqSuccessDic andErrorBlock:(NetworkManagerFailureBlock)reqErrorDic
{
      AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:path]];
    manager.securityPolicy= [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy.allowInvalidCertificates=YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:app_ID forHTTPHeaderField:@"APP_ID"];
//    [manager.requestSerializer setValue:defaultGet(savedAccessTocken)?defaultGet(savedAccessTocken):@" " forHTTPHeaderField:@"ACCESS_TOKEN"];
    manager.responseSerializer.acceptableContentTypes=[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    manager.requestSerializer.timeoutInterval=20;    
    if ([type isEqualToString:@"POST"]) {                
        [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [self completedWithResponse:operation.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
              [self completedWithResponse:operation.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    } else if ([type isEqualToString:@"GET"]){
        [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self completedWithResponse:operation.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
//            [self completedWithResponse:operation.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    } else if ([type isEqualToString:@"PUT"]){
        [manager PUT:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self completedWithResponse:operation.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self completedWithResponse:operation.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    }
    else{
        [manager  DELETE:path parameters:path success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self completedWithResponse:operation.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self completedWithResponse:operation.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    }
    manager=nil;
    
}

 - (void)completedWithResponse:(NSHTTPURLResponse *)response error:(NSError *)error data:(NSData *)returnDict withSuccessBlock:(NetworkManagerCompletionBlock)completeSuccessBlock ErrorBlock:(NetworkManagerFailureBlock)completeErrorBlock
{
    if(response.statusCode == 304){
         completeSuccessBlock(returnDict);
    }
    else if (returnDict){
        completeSuccessBlock(returnDict);
    }
    else{
        completeErrorBlock(error);
    }
    
    
}

- (void)customResponse:(NSHTTPURLResponse *)response error:(NSError *)error data:(NSData *)returnDict withSuccessBlock:(CustomNetworkManagerCompletionBlok)completeSuccessBlock ErrorBlock:(CustomNetworkManagerErrorBlok)completeErrorBlock
{
    
    if(returnDict){
        completeSuccessBlock(returnDict);
    }else{
        completeErrorBlock(error);
    }
}


-(void)getRequestwithUrl:(NSString*)url successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        [self customResponse:nil error:error data:nil withSuccessBlock:success ErrorBlock:errorBlock];
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        [self customResponse:httpResponse error:nil data:data withSuccessBlock:success ErrorBlock:errorBlock];
                                                    }
                                                }];
    [dataTask resume];
    
    
    
    
}

-(void)getRequestwithUrl:(NSString*)url withParameters:(NSDictionary*)dictParam successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSDictionary *headers;
    if(sf.currentUser.credentials.accessToken||[url containsString:@"partial"]){
        headers = @{ @"content-type": @"application/json",
                     @"Authorization":[NSString stringWithFormat:@"Bearer %@",sf.currentUser.credentials.accessToken]};
    }else{
        headers = @{ @"content-type": @"application/json",
                     };
    }
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        [self customResponse:nil error:error data:nil withSuccessBlock:success ErrorBlock:errorBlock];
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        [self customResponse:httpResponse error:nil data:data withSuccessBlock:success ErrorBlock:errorBlock];
                                                    }
                                                }];
    [dataTask resume];
    
}


-(void)postRequestwithUrl:(NSString*)url withParameters:(NSDictionary*)dictParam successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock{
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSLog(@"User sfAccount ID %@",kUserProfile.sfAccountId);
    NSLog(@"User sfAccount ID %@",sf.currentUser.credentials.userId);
    NSDictionary *headers;
    if(sf.currentUser.credentials.accessToken||[url containsString:@"partial"]){
        headers = @{ @"content-type": @"application/json",
                               @"Authorization":[NSString stringWithFormat:@"Bearer %@",sf.currentUser.credentials.accessToken]};
    }else{
        headers = @{ @"content-type": @"application/json",
                                   };
    }
    NSDictionary *parameters = dictParam;
    NSLog(@"BearerToken--%@",[NSString stringWithFormat:@"Bearer %@",sf.currentUser.credentials.accessToken]);
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        [self customResponse:nil error:error data:nil withSuccessBlock:success ErrorBlock:errorBlock];
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        [self customResponse:httpResponse error:nil data:data withSuccessBlock:success ErrorBlock:errorBlock];
                                                    }
                                                }];
    [dataTask resume];
    
}

-(void)postRequestWithOutDict:(NSString*)url withParameters:(NSDictionary*)dictParam successBlock:(CustomNetworkManagerCompletionBlok)success errorBlock:(CustomNetworkManagerErrorBlok)errorBlock{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSDictionary *headers;
    if(sf.currentUser.credentials.accessToken||[url containsString:@"partial"]){
        headers = @{ @"content-type": @"application/json",
                     @"Authorization":[NSString stringWithFormat:@"Bearer %@",sf.currentUser.credentials.accessToken]};
    }else{
        headers = @{ @"content-type": @"application/json",
                     };
    }
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        [self customResponse:nil error:error data:nil withSuccessBlock:success ErrorBlock:errorBlock];
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        [self customResponse:httpResponse error:nil data:data withSuccessBlock:success ErrorBlock:errorBlock];
                                                    }
                                                }];
    [dataTask resume];
    
}
@end
