#import "SampleService_Enums.h"

@implementation  SampleService_Enums
+(SoapProtocolVersion)StringToSoapProtocolVersion:(NSString*)str{
    if( NSOrderedSame == [str compare:@"Default" options:NSCaseInsensitiveSearch])
        return kSoapProtocolVersionDefault;
    if( NSOrderedSame == [str compare:@"Soap11" options:NSCaseInsensitiveSearch])
        return kSoapProtocolVersionSoap11;
    if( NSOrderedSame == [str compare:@"Soap12" options:NSCaseInsensitiveSearch])
        return kSoapProtocolVersionSoap12;
    return -1;
}
+(NSString*)SoapProtocolVersionToString:(SoapProtocolVersion)soapVersion;{
    switch (soapVersion){
        case kSoapProtocolVersionDefault:
            return @"Default";
        case kSoapProtocolVersionSoap11:
            return @"Soap11";
        case kSoapProtocolVersionSoap12:
            return @"Soap12";
        default:
            return @"";
    }
}
+(TestEnum)StringToTestEnum:(NSString*)str{
    if( NSOrderedSame == [str compare:@"TestEnum1" options:NSCaseInsensitiveSearch])
        return kTestEnumTestEnum1;
    if( NSOrderedSame == [str compare:@"TestEnum2" options:NSCaseInsensitiveSearch])
        return kTestEnumTestEnum2;
    if( NSOrderedSame == [str compare:@"TestEnum3" options:NSCaseInsensitiveSearch])
        return kTestEnumTestEnum3;
    if( NSOrderedSame == [str compare:@"TestEnum4" options:NSCaseInsensitiveSearch])
        return kTestEnumTestEnum4;
    return -1;
}
+(NSString*)TestEnumToString:(TestEnum)enum1;{
    switch (enum1){
        case kTestEnumTestEnum1:
            return @"TestEnum1";
        case kTestEnumTestEnum2:
            return @"TestEnum2";
        case kTestEnumTestEnum3:
            return @"TestEnum3";
        case kTestEnumTestEnum4:
            return @"TestEnum4";
        default:
            return @"";
    }
}
@end
