//
//  shipingObject.m
//  DamacC
//
//  Created by Gaian on 05/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "BillingObject.h"

@implementation BillingObject

-(instancetype)init{
    self = [super init];
    if(self){
     
    }
    return self;
}
-(void)setDefaultValues:(NSArray*)arr{
    
    for (int i = 0; i<arr.count; i++) {
        if(i == 0){
            self.shipName = handleNull(arr[i]);
            self.billName = handleNull(arr[i]);
        }
        if(i == 1){
            self.shipAddress = handleNull(arr[i]);
            self.billAddress = handleNull(arr[i]);
        }
        if(i == 2){
            self.shipCity = handleNull(arr[i]);
            self.billCity = handleNull(arr[i]);
        }
        if(i == 3){
            self.shipCountry = handleNull(arr[i]);
            self.billCountry = handleNull(arr[i]);
        }
        if(i == 4){
            self.shipState = handleNull(arr[i]);
            self.billState = handleNull(arr[i]);
        }
        if(i == 5){
            self.shipTelephone = handleNull(arr[i]);
            self.billTelephone = handleNull(arr[i]);
        }
        if(i == 6){
            self.shipemailID = handleNull(arr[i]);
            self.billemailID = handleNull(arr[i]);
        }
    }
    
    
}
@end
