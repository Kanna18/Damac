//
//  SaopServices.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SaopServices.h"

@implementation SaopServices
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//
//        UIImage *img = [UIImage imageNamed:@"settingsicon.png"];
//        NSData *dataImg = UIImagePNGRepresentation(img);
//
//        NSString *strMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DocumentAttachmentMultiple xmlns=\"http://action.com\"><P_REQUEST_NUMBER>%@</P_REQUEST_NUMBER><P_REQUEST_NAME>%@</P_REQUEST_NAME><P_SOURCE_SYSTEM>%@</P_SOURCE_SYSTEM><regTerms><category xmlns=\"http://bean.com/xsd\">%@</category><entityName xmlns=\"http://bean.com/xsd\">%@</entityName><fileBinary xmlns=\"http://bean.com/xsd\"><base64Binary xmlns=\"http://soapencoding.types.databinding.axis2.apache.org/xsd\">%@</base64Binary></fileBinary><fileDescription xmlns=\"http://bean.com/xsd\">%@</fileDescription><fileId xmlns=\"http://bean.com/xsd\">%@</fileId><fileName xmlns=\"http://bean.com/xsd\">%@</fileName><registrationId xmlns=\"http://bean.com/xsd\">%@</registrationId><sourceFileName xmlns=\"http://bean.com/xsd\">%@</sourceFileName><sourceId xmlns=\"http://bean.com/xsd\">%@</sourceId></regTerms></DocumentAttachmentMultiple></soap:Body></soap:Envelope>",kUserProfile.partyId,@"Service Request",@"TEST-1",@"Document",@"Damac Service Requests",dataImg,@"NationalIdCopy",@"IPMS-1036240-NationalIdCopy",@"IPMS-1036240-NationalIdCopy.pdf",@"1036240",@"IPMS-1036240-NationalIdCopy.pdf",@"IPMS-1036240-NationalIdCopy"];
//
//
////        <soap:Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
////        <Body>
////        <DocumentAttachmentMultiple xmlns="http://action.com">
////        <P_REQUEST_NUMBER>666072</P_REQUEST_NUMBER>
////        <P_REQUEST_NAME>Service Request</P_REQUEST_NAME>
////        <P_SOURCE_SYSTEM>TEST-1</P_SOURCE_SYSTEM>
////        <!-- Optional -->
////        <regTerms>
////        <category xmlns="http://bean.com/xsd">Document</category>
////        <entityName xmlns="http://bean.com/xsd">Damac Service Requests</entityName>
////        <!-- Optional -->
////        <fileBinary xmlns="http://bean.com/xsd">
////        <base64Binary xmlns="http://soapencoding.types.databinding.axis2.apache.org/xsd">
////        Base64Doc
////        </base64Binary>
////        </fileBinary>
////        <fileDescription xmlns="http://bean.com/xsd">NationalIdCopy</fileDescription>
////        <fileId xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy</fileId>
////        <fileName xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy.pdf</fileName>
////        <registrationId xmlns="http://bean.com/xsd">21179</registrationId>
////        <sourceFileName xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy.pdf</sourceFileName>
////        <sourceId xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy</sourceId>
////        </regTerms>
////        </DocumentAttachmentMultiple>
////        </Body>
////        </soap:Envelope>
//
//
////        <soap:Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
////        <Body>
////        <DocumentAttachmentMultiple xmlns="http://action.com">
////        <P_REQUEST_NUMBER>666072</P_REQUEST_NUMBER>
////        <P_REQUEST_NAME>Service Request</P_REQUEST_NAME>
////        <P_SOURCE_SYSTEM>TEST-1</P_SOURCE_SYSTEM>
////        <!-- Optional -->
////        <regTerms>
////        <category xmlns="http://bean.com/xsd">Document</category>
////        <entityName xmlns="http://bean.com/xsd">Damac Service Requests</entityName>
////        <!-- Optional -->
////        <fileBinary xmlns="http://bean.com/xsd">
////        <base64Binary xmlns="http://soapencoding.types.databinding.axis2.apache.org/xsd">
////        Base64Doc
////        </base64Binary>
////        </fileBinary>
////        <fileDescription xmlns="http://bean.com/xsd">NationalIdCopy</fileDescription>
////        <fileId xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy</fileId>
////        <fileName xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy.pdf</fileName>
////        <registrationId xmlns="http://bean.com/xsd">21179</registrationId>
////        <sourceFileName xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy.pdf</sourceFileName>
////        <sourceId xmlns="http://bean.com/xsd">IPMS-21179-NationalIdCopy</sourceId>
////        </regTerms>
////        </DocumentAttachmentMultiple>
////        </Body>
////        </soap:Envelope>,
//
//
//
//        NSURL *url = [NSURL URLWithString:@"http://34.236.223.78:8080/CRM_SR_NEW/services/AOPT?wsdl"];
//        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//        NSString *msgLenght=[NSString stringWithFormat:@"%lu",(unsigned long)[strMsg length]];
//        [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request addValue:@"http://action.com" forHTTPHeaderField:@"SOAPAction"];
//        [request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
////        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:[strMsg dataUsingEncoding:NSUTF8StringEncoding]];
//
//
////        param header, param type, param values
//
//        NSURLConnection *connection;
//        connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
//        [connection start];
//
//    }
//    return self;
//}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        p_REQUEST_NUMBER :(NSString *) 1
//        p_REQUEST_NAME :(NSString *)  2
//        p_SOURCE_SYSTEM :(NSString *) 3
//        sourceId :(NSString *)        4
//        registrationId :(NSString *)  5
//        entityName :(NSString *)      6
//        category :(NSString *)        7
//        fileId :(NSString *)          8
//        fileName :(NSString *)        9
//        fileDescription :(NSString *) 10
//        sourceFileName :(NSString *)  11
//        b:(Base64Binary *)            12
        
        UIImage *img = [UIImage imageNamed:@"settingsicon.png"];
        NSData *dataImg = UIImagePNGRepresentation(img);
        NSString *strBase = [dataImg base64EncodedString];
        Base64Binary *binar = [[Base64Binary alloc]init];
        binar.base64Binary = dataImg;

        AOPT *soapReq = [[AOPT alloc]init];
        soapReq.url = @"http://34.236.223.78:8080/CRM_SR_NEW/services/AOPT?wsdl";
        [soapReq DocumentAttachment:kUserProfile.partyId
                                   :@"Service Request"
                                   :@"TEST-1"
                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy",kUserProfile.partyId]
                                   :kUserProfile.partyId
                                   :@"Damac Service Requests"
                                   :@"Document"
                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy",kUserProfile.partyId]
                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy.pdf",kUserProfile.partyId]
                                   :@"NationalIdCopy"
                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy.pdf",kUserProfile.partyId]
                                   :binar];
        
        
        
        
    }
    return self;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"%@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"%@",data);
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str %@",str);
}


-(void)formSoapService{
    
    SampleServiceProxy *proxy = [[SampleServiceProxy alloc]initWithUrl:@"http://www.wsdl2code.com/sampleservice.asmx" AndDelegate:self];
    //    [proxy GetByteArray];
    UIImage * img = [UIImage imageNamed:@""];;
    [proxy GetBackByteArray:UIImageJPEGRepresentation(img, 1.0)];
    
}

- (void)proxyRecievedError:(NSException *)ex InMethod:(NSString *)method {
    
}

- (void)proxydidFinishLoadingData:(id)data InMethod:(NSString *)method {
    
}



@end


