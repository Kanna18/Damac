//
//  SaopServices.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOPT.h"

@interface SaopServices : NSObject
@property (strong,nonatomic) NSURLConnection *sessionconnection;
@property NSMutableData *webResponseData;
-(void)uploadDocumentTo:(UIImage*)img
       P_REQUEST_NUMBER:(NSString*)preqNum
         P_REQUEST_NAME:(NSString*)preqName
        P_SOURCE_SYSTEM:(NSString*)pSourceSys
               category:(NSString*)cat
             entityName:(NSString*)entityN
        fileDescription:(NSString*)fileDescr
                 fileId:(NSString*)file
               fileName:(NSString*)fileNa
         registrationId:(NSString*)regiId
         sourceFileName:(NSString*)sourceFi
               sourceId:(NSString*)srceId;
@end
