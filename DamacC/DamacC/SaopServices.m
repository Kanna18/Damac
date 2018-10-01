////
////  SaopServices.m
////  DamacC
////
////  Created by Gaian on 24/09/18.
////  Copyright © 2018 DamacCOrganizationName. All rights reserved.
////
//
//#import "SaopServices.h"
//
//@implementation SaopServices
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//    
//        NSString *strMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DocumentAttachmentMultiple xmlns=\"http://action.com\"><P_REQUEST_NUMBER>%@</P_REQUEST_NUMBER><P_REQUEST_NAME>%@</P_REQUEST_NAME><P_SOURCE_SYSTEM>%@</P_SOURCE_SYSTEM><regTerms><category xmlns=\"http://bean.com/xsd\">%@</category><entityName xmlns=\"http://bean.com/xsd\">%@</entityName><fileBinary xmlns=\"http://bean.com/xsd\"><base64Binary xmlns=\"http://soapencoding.types.databinding.axis2.apache.org/xsd\">%@</base64Binary></fileBinary><fileDescription xmlns=\"http://bean.com/xsd\">%@</fileDescription><fileId xmlns=\"http://bean.com/xsd\">%@</fileId><fileName xmlns=\"http://bean.com/xsd\">%@</fileName><registrationId xmlns=\"http://bean.com/xsd\">%@</registrationId><sourceFileName xmlns=\"http://bean.com/xsd\">%@</sourceFileName><sourceId xmlns=\"http://bean.com/xsd\">%@</sourceId></regTerms></DocumentAttachmentMultiple></soap:Body></soap:Envelope>",kUserProfile.partyId];
//        
//        NSURL *url = [NSURL URLWithString:@""];
//        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//        NSString *msgLenght=[NSString stringWithFormat:@"%d",[strMsg length]];
//        [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
////        [request addValue:@"http://tempuri.org/SaveIPadDownloadstatus" forHTTPHeaderField:@"SOAPAction"];
//        [request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
//        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:[strMsg dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSURLConnection *connection;
//        connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
//        
//        
//        
//
//        
//        
//    }
//    return self;
//}
//
//-(void)formSoapService{
//    
//    SampleServiceProxy *proxy = [[SampleServiceProxy alloc]initWithUrl:@"http://www.wsdl2code.com/sampleservice.asmx" AndDelegate:self];
//    //    [proxy GetByteArray];
//    UIImage * img = [UIImage imageNamed:@""];;
//    [proxy GetBackByteArray:UIImageJPEGRepresentation(img, 1.0)];
//    
//}
//
//- (void)proxyRecievedError:(NSException *)ex InMethod:(NSString *)method {
//    
//}
//
//- (void)proxydidFinishLoadingData:(id)data InMethod:(NSString *)method {
//    
//}
//
//@end
//
//
