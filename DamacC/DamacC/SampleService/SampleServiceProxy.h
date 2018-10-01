//------------------------------------------------------------------------------
// <wsdl2code-generated>
// This code was generated by http://www.wsdl2code.com iPhone version 1.1
// Date Of Creation: 2/21/2013 12:56:44 PM
//
//  Please dont change this code, regeneration will override your changes
//</wsdl2code-generated>
//
//------------------------------------------------------------------------------
//
//This source code was auto-generated by Wsdl2Code Version
//

#import <Foundation/Foundation.h>
#import "xpathquery.h"
#import "SampleService.h"
#import "NSData+Base64.h"
#import "Request.h"
#import "Response.h"

#ifndef _Wsdl2CodeProxyDelegate
#define _Wsdl2CodeProxyDelegate
@protocol Wsdl2CodeProxyDelegate
//if service recieve an error this method will be called
-(void)proxyRecievedError:(NSException*)ex InMethod:(NSString*)method;
//proxy finished, (id)data is the object of the relevant method service
-(void)proxydidFinishLoadingData:(id)data InMethod:(NSString*)method;
@end
#endif

@interface SampleServiceProxy : NSObject
@property (nonatomic,assign) id<Wsdl2CodeProxyDelegate> proxyDelegate;
@property (nonatomic,copy)   NSString* url;
@property (nonatomic,retain) SampleService* service;

-(id)initWithUrl:(NSString*)url AndDelegate:(id<Wsdl2CodeProxyDelegate>)delegate;
///Origin Return Type:NSString
-(void)HelloWorld;
///Origin Return Type:NSData
-(void)GetByteArray;
///Origin Return Type:NSData
-(void)GetBackByteArray:(NSData*)data ;
///Origin Return Type:Response
-(void)ServiceSample:(Request *)req ;
///Origin Return Type:NSMutableArray
-(void)getListStrings;
///Origin Return Type:NSMutableArray
-(void)GetListOfCustomObject;
///Origin Return Type:NSString
-(void)GetString;
///Origin Return Type:int
-(void)GetInt32;
///Origin Return Type:short
-(void)GetInt16;
///Origin Return Type:long
-(void)GetInt64;
///Origin Return Type:double
-(void)GetDouble;
///Origin Return Type:long
-(void)GetLong;
///Origin Return Type:WSPerson
-(void)GetPerson;
///Origin Return Type:TestEnum
-(void)GetEnum;
///Origin Return Type:
-(void)GetVoid;
///Origin Return Type:NSString
-(void)sendEnum:(TestEnum)enum1 ;
///Origin Return Type:TestEnum
-(void)getEnum:(TestEnum)enum2 ;
@end
