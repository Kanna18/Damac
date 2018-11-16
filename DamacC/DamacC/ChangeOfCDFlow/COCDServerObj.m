//
//  COCDServerObj.m
//  DamacC
//
//  Created by Gaian on 16/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//


#import "COCDServerObj.h"


@interface COCDServerObj () <TranslatorDelegate>

@property  TranslateEntity *translatingEntity;
@property Translator *translator;

@end


@implementation COCDServerObj{
    
    UserDetailsModel *udm;
    NSString *toastMessage;
    
}
-(instancetype)init{
    self = [super init];
    if(self){
        udm = [DamacSharedClass sharedInstance].userProileModel;
        self.translator = [[Translator alloc] initWithDelegate:self];
        if(!self.translator){
            self.translator = [Translator sharedInstance];
            self.translator.delegate = self;
            _CountobobjectstoTranslate = 1;
        }
    }
    return self;
}


- (void)fullRefreshTranslatewithText:(NSString*)text {
    _translatingEntity = [[TranslateEntity alloc] initWithLangFrom:@"English" andLangOn:@"Arabic" andInput:text];
    [_translator translate:_translatingEntity];
}

- (void)updateTranslatewithText:(NSString*)txt {
    if (_translatingEntity) {
        _translatingEntity.inputText = txt;
        [_translator translate:_translatingEntity];
    } else {
        [self fullRefreshTranslatewithText:txt];
    }
    
}

- (void)receiveTranslate:(TranslateEntity *)translate withError:(NSError *)error {
    
    

    if (error) {
        
        
    } else {
        
        if (_translatingEntity == translate) { // link comparing
            NSLog(@"ArabicText= %@---%@",translate.outputText,translate.inputText);
            [self fillArabicTexts:translate];
        }
    }
    _CountobobjectstoTranslate++;
    [self sendArabicTexts];
}
- (void)receiveLanguagesList:(NSArray<NSString *> *)allLanguages withError:(NSError*)error{
    NSLog(@"%@",allLanguages);
}


-(void)fillCOCDObjectWithOutCaseID{
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    
    self.RecordType = @"Change of Details";
    self.UserName = handleNull(name);
    self.salesforceId = kUserProfile.sfAccountId;
    self.AccountID = handleNull(udm.sfContactId);
    self.AddressLine1 = handleNull(udm.addressLine1);
    self.AddressLine2 = handleNull(udm.addressLine2);
    self.AddressLine3 = handleNull(udm.addressLine3);
    self.AddressLine4 = handleNull(udm.addressLine4);
    self.City = handleNull(udm.city);
    self.State = handleNull(udm.city);
    self.PostalCode = handleNull(udm.postalCode);
    self.Country = handleNull(udm.countryOfResidence);
    self.Mobile = [NSString stringWithFormat:@"%@%@%@",handleNull(udm.phoneCountry),handleNull(udm.phoneAreaCode),handleNull(udm.phoneNumber)];
    self.Email = [NSString stringWithFormat:@"%@",handleNull(udm.emailAddress)];
    self.AddressLine1Arabic = @"";
    self.AddressLine2Arabic = @"";
    self.AddressLine3Arabic = @"";
    self.AddressLine4Arabic = @"";
    self.CityArabic = @"";
    self.StateArabic = @"";
    self.PostalCodeArabic = @"";
    self.CountryArabic = @"";
    self.draft = @"";
    self.Status = @"";
    self.Origin = @"";
    self.fcm = @"";
    self.salesforceId = @"";
    _CountobobjectstoTranslate = 1;
    [self sendArabicTexts];
}
-(void)fillCOCDObjWithCaseID:(ServicesSRDetails*)srd{
    
    self.RecordType = handleNull(srd.RecordTypeId);
    self.UserName = @"";
    self.salesforceId = handleNull(udm.sfAccountId);
    self.AccountID = handleNull(udm.sfContactId);
    self.AddressLine1 = handleNull(srd.Address__c);
    self.AddressLine2 = handleNull(srd.Address_2__c);
    self.AddressLine3 = handleNull(srd.Address_3__c);
    self.AddressLine4 = handleNull(srd.Address_4__c);
    self.City = handleNull(srd.City__c);
    self.State = handleNull(srd.State__c);
    self.PostalCode = handleNull(srd.Postal_Code__c);
    self.Country = handleNull(srd.Country__c);
    self.Mobile = handleNull(srd.Contact_Mobile__c);
    self.Email = handleNull(srd.Contact_Email__c);
    self.AddressLine1Arabic = @"";
    self.AddressLine2Arabic = @"";
    self.AddressLine3Arabic = @"";
    self.AddressLine4Arabic = @"";
    self.CityArabic = @"";
    self.StateArabic = @"";
    self.PostalCodeArabic = @"";
    self.CountryArabic = @"";
    self.draft = @"";
    self.Status = @"";
    self.Origin = @"";
    self.fcm = @"";
    self.salesforceId = handleNull(srd.Id);
    
    self.cocdUploadedImagePath=srd.CRF_File_URL__c;
    self.primaryPassportUploadedImagePath= srd.Passport_File_URL__c;
    self.additionalImageUploadedImagePath = srd.Additional_Doc_File_URL__c;
    
    [self sendArabicTexts];
}

-(void)sendArabicTexts{
    if(_CountobobjectstoTranslate==1){
        [self updateTranslatewithText:self.AddressLine1];
    }else if (_CountobobjectstoTranslate==2){
        [self updateTranslatewithText:self.AddressLine2];
    }else if (_CountobobjectstoTranslate==3){
        [self updateTranslatewithText:self.AddressLine3];
    }else if (_CountobobjectstoTranslate==4){
        [self updateTranslatewithText:self.AddressLine4];
    }else if (_CountobobjectstoTranslate==5){
        [self updateTranslatewithText:self.State];
    }else if (_CountobobjectstoTranslate==6){
        [self updateTranslatewithText:self.Country];
    }else if (_CountobobjectstoTranslate==7){
        [self updateTranslatewithText:self.PostalCode];
    }else if (_CountobobjectstoTranslate==8){
        [self updateTranslatewithText:self.City];
    }
    
    
}

-(void)fillArabicTexts:(TranslateEntity*)trans{
    if([trans.inputText isEqualToString:self.AddressLine1])
    {
        self.AddressLine1Arabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.AddressLine2])
    {
        self.AddressLine2Arabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.AddressLine3])
    {
        self.AddressLine3Arabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.AddressLine4])
    {
        self.AddressLine4Arabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.State])
    {
        self.StateArabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.Country])
    {
        self.CountryArabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.City])
    {
        self.CityArabic = trans.outputText;
    }
    if([trans.inputText isEqualToString:self.PostalCode])
    {
        self.PostalCodeArabic = trans.outputText;
        [_delegate arabicConversionDone];
    }
    
    
}


-(void)changeValueBasedonTag:(UITextField*)textField withValue:(NSString*)str{
    
    _CountobobjectstoTranslate = 1;
    
    int tagValue = textField.tag;
    if(tagValue == Mobile){
        self.Mobile = str;
        return;
    }
    if(tagValue == Email){
        self.Email = str;
        return;
    }
    if(tagValue == Address1){
        self.AddressLine1 = str;
        [self updateTranslatewithText:str];
        return;
    }
    if(tagValue == Address2){
        self.AddressLine2 = str;
        return;
    }
    if(tagValue == Address3){
        self.AddressLine3 = str;
        return;
    }
    if(tagValue == Address4){
        self.AddressLine4 = str;
        return;
    }
    if(tagValue == City){
        self.City = str;
        [self updateTranslatewithText:str];
        return;
    }
    if(tagValue == State){
        self.State = str;
        [self updateTranslatewithText:str];
        return;
    }
    if(tagValue == PostalCode){
        self.PostalCode = str;
        return;
    }
    if(tagValue == Address1Arabic){
        self.AddressLine1Arabic = str;
        return;
    }
    if(tagValue == CityArabic){
        self.CityArabic = str;
        return;
    }
    if(tagValue == CountryArabic){
        self.CountryArabic = str;
        return;
    }
    if(tagValue == StateInArabic){
        self.StateArabic = str;
        return;
    }
    

}
-(void)sendDraftStatusToServer{
    
    ServerAPIManager *serverAp = [ServerAPIManager sharedinstance];
    NSNumber *boo;
    
    if([self.Status isEqualToString:@"Draft Request"])
    {
        boo = [NSNumber numberWithBool:YES];
    }
    if([self.Status isEqualToString:@"Cancelled"]||[self.Status isEqualToString:@"Submitted"])
    {
        boo = [NSNumber numberWithBool:NO];
    }
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSMutableDictionary *wrapperDict = [[NSMutableDictionary alloc]init];
    [wrapperDict setValue:@"Change of Details" forKey:@"RecordType"];
    [wrapperDict setValue:handleNull(sf.currentUser.userName) forKey:@"UserName"];
    [wrapperDict setValue:kUserProfile.sfAccountId forKey:@"AccountID"];
    [wrapperDict setValue:self.AddressLine1 forKey:@"AddressLine1"];
    [wrapperDict setValue:self.AddressLine2 forKey:@"AddressLine2"];
    [wrapperDict setValue:self.AddressLine3 forKey:@"AddressLine3"];
    [wrapperDict setValue:self.AddressLine4 forKey:@"AddressLine4"];
    [wrapperDict setValue:self.City forKey:@"City"];
    [wrapperDict setValue:self.State forKey:@"State"];
    [wrapperDict setValue:self.PostalCode forKey:@"PostalCode"];
    [wrapperDict setValue:self.Country forKey:@"Country"];
    [wrapperDict setValue:self.Mobile forKey:@"Mobile"];
    [wrapperDict setValue:self.Email forKey:@"Email"];
    [wrapperDict setValue:self.AddressLine1Arabic forKey:@"AddressLine1Arabic"];
    [wrapperDict setValue:self.AddressLine2Arabic forKey:@"AddressLine2Arabic"];
    [wrapperDict setValue:self.AddressLine3Arabic forKey:@"AddressLine3Arabic"];
    [wrapperDict setValue:self.AddressLine4Arabic forKey:@"AddressLine4Arabic"];
    [wrapperDict setValue:self.CityArabic forKey:@"CityArabic"];
    [wrapperDict setValue:self.StateArabic forKey:@"StateArabic"];
    [wrapperDict setValue:self.PostalCodeArabic forKey:@"PostalCodeArabic"];
    [wrapperDict setValue:self.CountryArabic forKey:@"CountryArabic"];
    [wrapperDict setValue:boo forKey:@"draft"];
    [wrapperDict setValue:self.Status forKey:@"Status"];
    [wrapperDict setValue:@"Mobile app" forKey:@"Origin"];
    [wrapperDict setValue:handleNull(self.cocdUploadedImagePath) forKey:@"crfFormUrl"];
    [wrapperDict setValue:handleNull(self.additionalImageUploadedImagePath) forKey:@"additionalDocUrl"];
    [wrapperDict setValue:handleNull(self.primaryPassportUploadedImagePath) forKey:@"passportFileUrl"];
    
    [wrapperDict setValue:@"" forKey:@"fcm"];
    if(self.salesforceId.length>0){
    [wrapperDict setValue:self.salesforceId forKey:@"salesforceId"];
    }
    
  NSDictionary *dict = @{
        @"codCaseWrapper": wrapperDict
        };
    
    [serverAp postRequestwithUrl:ChangeofDetailsServicesUrl withParameters:dict successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dic);
        }
        [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
    } errorBlock:^(NSError *error) {
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
        [FTIndicator showToastMessage:error.localizedDescription];
    }];
}
-(void)popToMainVC{
    
    if([self.Status isEqualToString:@"Draft Request"]){
        toastMessage= @"SR has been successfully saved";
    }
    if([self.Status isEqualToString:@"Submitted"]){
        toastMessage= @"SR has been successfully Submitted";
    }
    if([self.Status isEqualToString:@"Cancelled"]){
       toastMessage= @"SR has been successfully Cancelled";
    }
    [FTIndicator dismissProgress];
    [FTIndicator showToastMessage:toastMessage];    
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}


@end
