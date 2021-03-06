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
#import "AOPTProxy.h"

@implementation AOPTProxy

-(id)initWithUrl:(NSString*)url AndDelegate:(id<Wsdl2CodeProxyDelegate>)delegate{
    self = [super init];
    if (self != nil){
        self.service = [[AOPT alloc] init];
        [self.service setUrl:url];
        [self setUrl:url];
        [self setProxyDelegate:delegate];
    }
    return self;
}

///Origin Return Type:NSString
-(void)EarlyHandoverPaymentPlanCreation:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER :(NSString *)P_SR_TYPE :(NSString *)REGISTRATION_ID :(NSString *)INSTALLMENT :(NSString *)DESCRIPTION :(NSString *)PAYMENT_DATE :(NSString *)EXPECTED_DATE :(NSString *)MILESTONE_EVENT :(NSString *)PERCENT_VALUE :(NSString *)TRANSFER_AR_INTER_FLAG :(NSString *)PAYMENT_AMOUNT {
    [self.service addTarget:self AndAction:&EarlyHandoverPaymentPlanCreationTarget];
    [self.service EarlyHandoverPaymentPlanCreation:P_REGISTRATION_ID :P_SR_NUMBER :P_SR_TYPE :REGISTRATION_ID :INSTALLMENT :DESCRIPTION :PAYMENT_DATE :EXPECTED_DATE :MILESTONE_EVENT :PERCENT_VALUE :TRANSFER_AR_INTER_FLAG :PAYMENT_AMOUNT ];
}

void EarlyHandoverPaymentPlanCreationTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"EarlyHandoverPaymentPlanCreation"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"EarlyHandoverPaymentPlanCreation"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"EarlyHandoverPaymentPlanCreation"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)PaymentPlanReversalMultiple:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER {
    [self.service addTarget:self AndAction:&PaymentPlanReversalMultipleTarget];
    [self.service PaymentPlanReversalMultiple:P_REGISTRATION_ID :P_SR_NUMBER ];
}

void PaymentPlanReversalMultipleTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"PaymentPlanReversalMultiple"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"PaymentPlanReversalMultiple"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"PaymentPlanReversalMultiple"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)PaymentPlanCreation:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER :(NSString *)P_SR_TYPE :(NSMutableArray *)regTerms {
    [self.service addTarget:self AndAction:&PaymentPlanCreationTarget];
    [self.service PaymentPlanCreation:P_REGISTRATION_ID :P_SR_NUMBER :P_SR_TYPE :regTerms ];
}

void PaymentPlanCreationTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"PaymentPlanCreation"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"PaymentPlanCreation"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"PaymentPlanCreation"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)PaymentPlanReversal:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER {
    [self.service addTarget:self AndAction:&PaymentPlanReversalTarget];
    [self.service PaymentPlanReversal:P_REGISTRATION_ID :P_SR_NUMBER ];
}

void PaymentPlanReversalTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"PaymentPlanReversal"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"PaymentPlanReversal"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"PaymentPlanReversal"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)DocumentAttachmentMultiple:(NSString *)P_REQUEST_NUMBER :(NSString *)P_REQUEST_NAME :(NSString *)P_SOURCE_SYSTEM :(NSMutableArray *)regTerms {
    [self.service addTarget:self AndAction:&DocumentAttachmentMultipleTarget];
    [self.service DocumentAttachmentMultiple:P_REQUEST_NUMBER :P_REQUEST_NAME :P_SOURCE_SYSTEM :regTerms ];
}

void DocumentAttachmentMultipleTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"DocumentAttachmentMultiple"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"DocumentAttachmentMultiple"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"DocumentAttachmentMultiple"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)DocumentAttachment:(NSString *)P_REQUEST_NUMBER :(NSString *)P_REQUEST_NAME :(NSString *)P_SOURCE_SYSTEM :(NSString *)SourceId :(NSString *)RegistrationId :(NSString *)EntityName :(NSString *)Category :(NSString *)FileId :(NSString *)FileName :(NSString *)FileDescription :(NSString *)SourceFileName :(Base64Binary *)b {
    [self.service addTarget:self AndAction:&DocumentAttachmentTarget];
    [self.service DocumentAttachment:P_REQUEST_NUMBER :P_REQUEST_NAME :P_SOURCE_SYSTEM :SourceId :RegistrationId :EntityName :Category :FileId :FileName :FileDescription :SourceFileName :b ];
}

void DocumentAttachmentTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"DocumentAttachment"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"DocumentAttachment"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"DocumentAttachment"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)getMilestonePaymentDetails:(NSString *)REGISTRATION_ID {
    [self.service addTarget:self AndAction:&getMilestonePaymentDetailsTarget];
    [self.service getMilestonePaymentDetails:REGISTRATION_ID ];
}

void getMilestonePaymentDetailsTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"getMilestonePaymentDetails"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"getMilestonePaymentDetails"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"getMilestonePaymentDetails"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)RegistrationDetails:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER {
    [self.service addTarget:self AndAction:&RegistrationDetailsTarget];
    [self.service RegistrationDetails:P_REGISTRATION_ID :P_SR_NUMBER ];
}

void RegistrationDetailsTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"RegistrationDetails"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"RegistrationDetails"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"RegistrationDetails"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)PaymentPlanHistory:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER {
    [self.service addTarget:self AndAction:&PaymentPlanHistoryTarget];
    [self.service PaymentPlanHistory:P_REGISTRATION_ID :P_SR_NUMBER ];
}

void PaymentPlanHistoryTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"PaymentPlanHistory"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"PaymentPlanHistory"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"PaymentPlanHistory"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)PaymentPlanReversalCurrent:(NSString *)P_REGISTRATION_ID :(NSString *)P_SR_NUMBER {
    [self.service addTarget:self AndAction:&PaymentPlanReversalCurrentTarget];
    [self.service PaymentPlanReversalCurrent:P_REGISTRATION_ID :P_SR_NUMBER ];
}

void PaymentPlanReversalCurrentTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"PaymentPlanReversalCurrent"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"PaymentPlanReversalCurrent"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"PaymentPlanReversalCurrent"];
            return;
        }
    }
}

///Origin Return Type:NSString
-(void)getMasterMilestone:(NSString *)REGISTRATION_ID {
    [self.service addTarget:self AndAction:&getMasterMilestoneTarget];
    [self.service getMasterMilestone:REGISTRATION_ID ];
}

void getMasterMilestoneTarget(AOPTProxy* target, id sender, NSString* xml){
    @try{
        NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"http://action.com\"" withString:@""];
        NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
        XPathQuery *xpathQuery = [[XPathQuery alloc] init];
        NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
        NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
        if([arrayOfWSData count] == 0 ){
            NSException *exception = [NSException exceptionWithName:@"Wsdl2Code" reason: @"Response is nil" userInfo: nil];
            if (target.proxyDelegate != nil){
                [target.proxyDelegate proxyRecievedError:exception InMethod:@"getMasterMilestone"];
                return;
            }
        }
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        NSString* result = nil;
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
         if (target.proxyDelegate != nil){
            [target.proxyDelegate proxydidFinishLoadingData:result InMethod:@"getMasterMilestone"];
            return;
        }
    }
    @catch(NSException *ex){
        if (target.proxyDelegate != nil){
            [target.proxyDelegate proxyRecievedError:ex InMethod:@"getMasterMilestone"];
            return;
        }
    }
}
@end
