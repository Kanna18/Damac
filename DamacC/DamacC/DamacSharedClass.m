//
//  DamacSharedClass.m
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "DamacSharedClass.h"

@implementation DamacSharedClass

+ (DamacSharedClass *)sharedInstance
{
    static DamacSharedClass *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DamacSharedClass alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _sfidsForJointBuyersArray = [[NSMutableArray alloc]init];
        _unitsArray = [[NSMutableArray alloc]init];
    }
    return self;
}


@end


