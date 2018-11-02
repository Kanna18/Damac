//
//  PrintDocView.m
//  DamacC
//
//  Created by Gaian on 17/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PrintDocView.h"

@implementation PrintDocView{
    
    __weak IBOutlet UIImageView *image1;
    __weak IBOutlet UIImageView *image3;
    __weak IBOutlet UIImageView *image2;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self = [[NSBundle mainBundle] loadNibNamed:@"PrintDocView" owner:self options:nil][0];
        [self rectBounds:_serviceBtn];
        [self rectBounds:_soaButton];
        [self rectBounds:_penalityBtn];
    }
    return self;
}

-(void)rectBounds:(UIButton*)img{
    img.layer.cornerRadius = img.frame.size.height/2;
    img.layer.borderColor = [UIColor blackColor].CGColor;
    img.layer.borderWidth = 2.0f;
    img.clipsToBounds = YES;
    
}

- (IBAction)soaClick:(id)sender {
    
    NSLog(@"%@",_currentUnit);
    [self getArrayAndLoadWebService:1];
}

- (IBAction)serviceChargesClick:(id)sender {
    NSLog(@"%@",_currentUnit);
    [self getArrayAndLoadWebService:2];
}

- (IBAction)penalityClick:(id)sender {
    NSLog(@"%@",_currentUnit);
    [self getArrayAndLoadWebService:3];
}


-(void)getArrayAndLoadWebService:(int)index{
    
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
    Action *action = _currentUnit.actions[index];
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server getRequestwithUrl:action.url successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *di = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSString *url = [di[@"actions"][0] valueForKey:@"url"];
            [self openReceiptinSafari:url];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(void)openReceiptinSafari:(NSString*)url{
    dispatch_async(dispatch_get_main_queue(), ^{
        [FTIndicator dismissProgress];
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
        }
    });
}
@end
