//
//  PopCell3.m
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PopCell3.h"

@implementation PopCell3{
    
    CameraView *camView;
    int countoFImagestoUplaod,countoFImagesUploaded;
    int clickedImage;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self roundCorners:_buttonSubmit];
    [self roundCorners:_buttonDocument];
    CGRect fra = [UIScreen mainScreen].bounds;
    camView = [[CameraView alloc]initWithFrame:CGRectZero parentViw:[DamacSharedClass sharedInstance].currentVC];
    [[DamacSharedClass sharedInstance].currentVC.view addSubview:camView];
    camView.delegate = self;
    [self roundCorners:_buttonSubmit];
    [self roundCorners:_buttonDocument];
    countoFImagestoUplaod =0 ;
    countoFImagesUploaded = 0;
    clickedImage = 0;
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
    
}

- (IBAction)uploadProofClick1:(id)sender {
    [camView frameChangeCameraView];
    clickedImage =100;
}
- (IBAction)uploadProofClick2:(id)sender {
    [camView frameChangeCameraView];
    clickedImage =200;
}

- (IBAction)submitClick:(id)sender {
    
    if(_popObj.popImage == nil){
        [FTIndicator showToastMessage:@"Proof Document not attached"];
    }else{
        
        _popObj.status = @"Submitted";
        [FTIndicator showProgressWithMessage:@""];
        [self uploadImagesToServer];
    }
}

- (IBAction)atatchDocClick:(id)sender {
    
    
}

-(void)imagePickerSelectedImage:(UIImage *)image{
    if(image&&clickedImage ==100){
        _uploadDocLabel.text = @"cahceJPEG1.jpg";
        _popObj.popImage = image;
    }
    if(image&&clickedImage ==200){
        _otherDocLAbel.text = @"cahceJPEG2.jpg";
        _popObj.otherImage = image;
    }
}

-(void)uploadImagesToServer{
    
    _soap = [[SaopServices alloc]init];
    _soap.delegate = self;
    if(_popObj.popImage){
        [_soap uploadDocumentTo:_popObj.popImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"POP" fileId:@"POP" fileName:@"POP" registrationId:nil sourceFileName:@"POP" sourceId:@"POP"];
        countoFImagestoUplaod++;
    }
    _soap2 = [[SaopServices alloc]init];
    _soap2.delegate = self;
    if(_popObj.otherImage){
        NSString *str = @"POP1";
        [_soap2 uploadDocumentTo:_popObj.otherImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    SaopServices *soap3 = [[SaopServices alloc]init];    
}


#pragma mark Soap Image uploaded Delegate

-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    countoFImagesUploaded ++;
    
    if ([path rangeOfString:@"POP"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _popObj.popImagePath = path;
        
    }
    
    if ([path rangeOfString:@"POP1"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        _popObj.otherImagePath = path;
    }
    
    if(countoFImagestoUplaod == countoFImagesUploaded){
        [_popObj subMitPOPfromServicesSRDetails];
    }
}

@end
