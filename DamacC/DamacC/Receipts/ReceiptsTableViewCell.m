//
//  ReceiptsTableViewCell.m
//  DamacC
//
//  Created by Gaian on 04/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ReceiptsTableViewCell.h"

@implementation ReceiptsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = YES;
    [_label2 setAdjustsFontSizeToFitWidth:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)receiptsClick:(id)sender {
    
    ReceiptActions *rcpt = _rs.actions[0];
    [self generateReceiptAction:rcpt.url];
    [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
}

-(void)generateReceiptAction:(NSString*)str{
    ServerAPIManager *rvr = [ServerAPIManager sharedinstance];
    [rvr getRequestwithUrl:str successBlock:^(id responseObj) {
        if(responseObj){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSLog(@"%@",dict);
            [self openReceiptinSafari:dict[@"actions"][0][@"url"]];
            
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
