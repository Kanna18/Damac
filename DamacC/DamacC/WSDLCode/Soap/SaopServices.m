//
//  SaopServices.m
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SaopServices.h"
#import "Base64Binary.h"
#import "XPathQuery.h"

@implementation SaopServices{
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {


        UIImage *img = [UIImage imageNamed:@"settingsicon.png"];
        NSData *dataImg = UIImageJPEGRepresentation(img, 1.0);
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                                 "<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://action.com\" xmlns:ns2=\"http://bean.com/xsd\" xmlns:ns3=\"http://soapencoding.types.databinding.axis2.apache.org/xsd\">"
                                 "<SOAP-ENV:Body>"
                                 "<ns1:DocumentAttachmentMultiple>"
                                 "<ns1:P_REQUEST_NUMBER>%@</ns1:P_REQUEST_NUMBER>"
                                 "<ns1:P_REQUEST_NAME>%@</ns1:P_REQUEST_NAME>"
                                 "<ns1:P_SOURCE_SYSTEM>%@</ns1:P_SOURCE_SYSTEM>"
                                 "<ns1:regTerms>"
                                 "<ns2:category>%@</ns2:category>"
                                 "<ns2:entityName>%@</ns2:entityName>"
                                 "<ns2:fileBinary>"
                                 "<ns3:base64Binary>%@</ns3:base64Binary>"
                                 "</ns2:fileBinary>"
                                 "<ns2:fileDescription>%@</ns2:fileDescription>"
                                 "<ns2:fileId>%@</ns2:fileId>"
                                 "<ns2:fileName>%@</ns2:fileName>"
                                 "<ns2:registrationId>%@</ns2:registrationId>"
                                 "<ns2:sourceFileName>%@</ns2:sourceFileName>"
                                 "<ns2:sourceId>%@</ns2:sourceId>"
                                 "</ns1:regTerms>"
                                 "</ns1:DocumentAttachmentMultiple>"
                                 "</SOAP-ENV:Body>"                                 "</SOAP-ENV:Envelope>",
                                 kUserProfile.partyId,
                                 @"Service Request",
                                 @"TEST-1",
                                 @"Document",
                                 @"Damac Service Requests",
                                 dataImg.base64Encode,@"NationalIdCopy",
                                 [NSString stringWithFormat:@"IPMS-%@-NationalIdCopy",
                                  kUserProfile.partyId],
                                 [NSString stringWithFormat:@"IPMS-%@-NationalIdCopy.pdf",kUserProfile.partyId],
                                 kUserProfile.partyId,
                                 [NSString stringWithFormat:@"IPMS-%@-NationalIdCopy.pdf",kUserProfile.partyId],
                                 [NSString stringWithFormat:@"IPMS-%@NationalIdCopy",kUserProfile.partyId]];
        
        
        
        
        NSURL *url = [NSURL URLWithString:@"http://34.236.223.78:8080/CRM_SR_NEW/services/AOPT?wsdl"]; // Copy here the URL
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
        
        //add required headers to the request
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"urn:DocumentAttachmentMultiple" forHTTPHeaderField:@"SOAPAction"]; // copy here the SOAP_ACTION
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        //initiate the request
        self.sessionconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if(self.sessionconnection)
        {
            self.webResponseData = [NSMutableData data] ;
        }
        else
        {
            NSLog(@"Connection is NULL");
        }

    
    }
    return self;
}


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
////        p_REQUEST_NUMBER :(NSString *) 1
////        p_REQUEST_NAME :(NSString *)  2
////        p_SOURCE_SYSTEM :(NSString *) 3
////        sourceId :(NSString *)        4
////        registrationId :(NSString *)  5
////        entityName :(NSString *)      6
////        category :(NSString *)        7
////        fileId :(NSString *)          8
////        fileName :(NSString *)        9
////        fileDescription :(NSString *) 10
////        sourceFileName :(NSString *)  11
////        b:(Base64Binary *)            12
//
//
//
//
//        UIImage * img = [UIImage imageNamed:@"settingsicon.png"];
//        NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
//        NSString *base64Encoded = [imgData base64EncodedStringWithOptions:0];
//        NSData *dt = [NSData dataFromBase64String:base64Encoded];
//
////        NSArray *arr = [NSArray alloc]initWithCoder:<#(nonnull NSCoder *)#>
////        Base64Binary *b =  [[Base64Binary alloc]initWithArray:arr];
//
//        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
//        NSString * query = [NSString stringWithFormat:@"http://34.236.223.78:8080/CRM_SR_NEW/services/AOPT?wsdl"];
//        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:imgData andQuery:query];
//        Base64Binary *b =  [[Base64Binary alloc]initWithArray:arrayOfWSData];
//
//
//
//        AOPT *soapReq = [[AOPT alloc]init];
//        soapReq.url = @"http://34.236.223.78:8080/CRM_SR_NEW/services/AOPT?wsdl";
//        [soapReq DocumentAttachment:kUserProfile.partyId
//                                   :@"Service Request"
//                                   :@"TEST-1"
//                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy",kUserProfile.partyId]
//                                   :kUserProfile.partyId
//                                   :@"Damac Service Requests"
//                                   :@"Document"
//                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy",kUserProfile.partyId]
//                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy.pdf",kUserProfile.partyId]
//                                   :@"NationalIdCopy"
//                                   :[NSString stringWithFormat:@"IPMS-%@-NationalIdCopy.pdf",kUserProfile.partyId]
//                                   :b];
//
//
//
//
//    }
//    return self;
//}

#pragma Mark Implement the connection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.webResponseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.webResponseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Some error in your Connection. Please try again.");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    if(connection == self.sessionconnection)
    {
        NSString *theXML = [[NSString alloc] initWithBytes:
                            [self.webResponseData mutableBytes] length:[self.webResponseData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"my data is %@", theXML);
        
        //now parse the xml
        
    }
}
@end


