//------------------------------------------------------------------------------
// <wsdl2code-generated>
// This code was generated by http://www.wsdl2code.com iPhone version 2.1
// Date Of Creation: 10/3/2018 10:15:47 AM
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
#import "AOPT.h"
#import "APPSXXDC_AOPT_PKG_WSX1843128X6X5.h"
#import "DocUploadDTO.h"
#import "Base64Binary.h"

#ifndef _Wsdl2CodeProxyDelegate
#define _Wsdl2CodeProxyDelegate
@protocol Wsdl2CodeProxyDelegate
//if service recieve an error this method will be called
-(void)proxyRecievedError:(NSException*)ex InMethod:(NSString*)method;
//proxy finished, (id)data is the object of the relevant method service
-(void)proxydidFinishLoadingData:(id)data InMethod:(NSString*)method;
@end
#endif

@interface AOPTProxy : NSObject
@property (nonatomic,assign) id<Wsdl2CodeProxyDelegate> proxyDelegate;
@property (nonatomic,copy)   NSString* url;
@property (nonatomic,retain) AOPT* service;

-(id)initWithUrl:(NSString*)url AndDelegate:(id<Wsdl2CodeProxyDelegate>)delegate;
///Origin Return Type:NSString
-(void)EarlyHandoverPaymentPlanCreation:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER :(NSString *)P_SR_TYPE :(NSString *)REGISTRATION_ID :(NSString *)INSTALLMENT :(NSString *)DESCRIPTION :(NSString *)PAYMENT_DATE :(NSString *)EXPECTED_DATE :(NSString *)MILESTONE_EVENT :(NSString *)PERCENT_VALUE :(NSString *)TRANSFER_AR_INTER_FLAG :(NSString *)PAYMENT_AMOUNT ;
///Origin Return Type:NSString
-(void)PaymentPlanReversalMultiple:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER ;
///Origin Return Type:NSString
-(void)PaymentPlanCreation:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER :(NSString *)P_SR_TYPE :(NSMutableArray *)regTerms ;
///Origin Return Type:NSString
-(void)PaymentPlanReversal:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER ;
///Origin Return Type:NSString
-(void)DocumentAttachmentMultiple:(NSString *)P_REQUEST_NUMBER :(NSString *)P_REQUEST_NAME :(NSString *)P_SOURCE_SYSTEM :(NSMutableArray *)regTerms ;
///Origin Return Type:NSString
-(void)DocumentAttachment:(NSString *)P_REQUEST_NUMBER :(NSString *)P_REQUEST_NAME :(NSString *)P_SOURCE_SYSTEM :(NSString *)SourceId :(NSString *)RegistrationId :(NSString *)EntityName :(NSString *)Category :(NSString *)FileId :(NSString *)FileName :(NSString *)FileDescription :(NSString *)SourceFileName :(Base64Binary *)b ;
///Origin Return Type:NSString
-(void)getMilestonePaymentDetails:(NSString *)REGISTRATION_ID ;
///Origin Return Type:NSString
-(void)RegistrationDetails:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER ;
///Origin Return Type:NSString
-(void)PaymentPlanHistory:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER ;
///Origin Return Type:NSString
-(void)PaymentPlanReversalCurrent:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER ;
///Origin Return Type:NSString
-(void)getMasterMilestone:(NSString *)REGISTRATION_ID ;
@end