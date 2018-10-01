#import <Foundation/Foundation.h>


#ifndef _SoapProtocolVersion_
#define _SoapProtocolVersion_
typedef enum {
    	kSoapProtocolVersionDefault = 0,
    	kSoapProtocolVersionSoap11 = 1,
    	kSoapProtocolVersionSoap12 = 2,
} SoapProtocolVersion;
#endif

#ifndef _TestEnum_
#define _TestEnum_
typedef enum {
    	kTestEnumTestEnum1 = 0,
    	kTestEnumTestEnum2 = 1,
    	kTestEnumTestEnum3 = 2,
    	kTestEnumTestEnum4 = 3,
} TestEnum;
#endif
@interface SampleService_Enums : NSObject
{
}
+(NSString*)SoapProtocolVersionToString:(SoapProtocolVersion)soapVersion;
+(SoapProtocolVersion)StringToSoapProtocolVersion:(NSString*)str;
+(NSString*)TestEnumToString:(TestEnum)enum1;
+(TestEnum)StringToTestEnum:(NSString*)str;
@end
