//
//  JointBuyerObject.m
//  DamacC
//
//  Created by Gaian on 24/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "JointBuyerObject.h"

@implementation JointBuyerObject
-(instancetype)init{
    self =  [super init];
    if(self){
        
    }
    return self;
}

-(void)fillObjectWithDict:(NSDictionary*)dict{
    
    self.AccountID = @"";
    self.AdditionalDocFileUrl = @"";
    self.address1 = @"";
    self.address2 = @"";
    self.address3 = @"";
    self.address4 = @"";
    self.city = @"";
    self.country = @"";
    self.email = @"";
    self.mobileCountryCode = @"";
    self.origin = @"";
    self.PassportFileUrl = @"";
    self.phone = @"";
    self.postalCode = @"";
    self.RecordType = @"";
    self.state = @"";
    self.status = @"";
    self.UploadSignedChangeofDetails = @"";
    
}
-(void)changeValueBasedonTag:(UITextField*)textField withValue:(NSString*)str{
    
    int tagValue = textField.tag;
    if(tagValue == MobileJ){
        self.phone = str;
        return;
    }
    if(tagValue == EmailJ){
        self.email = str;
        return;
    }
    if(tagValue == Address1J){
        self.address1 = str;
        return;
    }
    if(tagValue == Address2J){
        self.address2 = str;
        return;
    }
    if(tagValue == Address3J){
        self.address3 = str;
        return;
    }
    if(tagValue == Address4J){
        self.address4 = str;
        return;
    }
    if(tagValue == CityJ){
        self.city = str;
        return;
    }
    if(tagValue == StateJ){
        self.state = str;
        return;
    }
    if(tagValue == PostalCodeJ){
        self.postalCode = str;
        return;
    }
   
}
-(void)yyy{
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:self.AccountID forKey:@"AccountID"];
    [dict setValue:self.AdditionalDocFileUrl forKey:@"AdditionalDocFileUrl"];
    [dict setValue:self.address1 forKey:@"address1"];
    [dict setValue:self.address2 forKey:@"address2"];
    [dict setValue:self.address3 forKey:@"address3"];
    [dict setValue:self.address4 forKey:@"address4"];
    [dict setValue:self.city forKey:@"city"];
    [dict setValue:self.country forKey:@"country"];
    [dict setValue:self.email forKey:@"email"];
    [dict setValue:self.mobileCountryCode forKey:@"mobileCountryCode"];
    [dict setValue:self.origin forKey:@"origin"];
    [dict setValue:self.PassportFileUrl forKey:@"PassportFileUrl"];
    [dict setValue:self.phone forKey:@"phone"];
    [dict setValue:self.postalCode forKey:@"postalCode"];
    [dict setValue:self.RecordType forKey:@"RecordType"];
    [dict setValue:self.state forKey:@"state"];
    [dict setValue:self.status forKey:@"status"];
    [dict setValue:self.UploadSignedChangeofDetails forKey:@"UploadSignedChangeofDetails"];
    
    NSDictionary *response = @{@"joinBuyerWraper":dict};
    
}

@end
