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
@end
