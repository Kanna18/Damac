//
//  UnitsCell.m
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "UnitsCell.h"
#import "BillingViewController.h"
@implementation UnitsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self labelsAdjustment:_stackView1];
    [self labelsAdjustment:_stackView2];
    [self labelsAdjustment:_stackView3];
    [self buttonsRadius:_payNowButton];
    [self buttonsRadius:_printDocButton];
    _printDocButton.layer.borderColor = rgb(191, 154, 88).CGColor;
    [_payNowButton addTarget:self action:@selector(payNow:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setProgressView{
    
    _progressView.backgroundColor = [UIColor clearColor];
    [self.progressView.sliceItems removeAllObjects];
    
    SliceItem *item1 = [SliceItem new];
    item1.itemValue = _percentValue;
    item1.itemColor = goldColor;

    SliceItem *item2 = [[SliceItem alloc] init];
    item2.itemValue = 100-_percentValue;
    item2.itemColor = [UIColor grayColor];

    [self.progressView.sliceItems addObject:item1];
    [self.progressView.sliceItems addObject:item2];
    
   [self.progressView setLineWidth:10.0]; // Set Line thickness of the chart.
    [self.progressView setAnimationDuration:1]; // Set Animation Duration.
    [self.progressView reloadData];
    
 
}
-(void)buttonsRadius:(UIButton*)btn{
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1.0f;
}
-(void)labelsAdjustment:(UIStackView*)sv{
    
    for (UILabel *lbl in sv.arrangedSubviews) {
        if([lbl isKindOfClass:[UILabel class]]){
            [lbl setAdjustsFontSizeToFitWidth:YES];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)payNow:(id)sender{
 
    if([_dueAmount integerValue]>0){
        BillingViewController *bvc = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"billVC"];
        bvc.dueAmount = _dueAmount;
        [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:bvc animated:YES];
        
        [FIRAnalytics logEventWithName:kFIREventSelectContent
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"MyUnit_EStatements"],
                                         kFIRParameterItemName:@"MyUnit_PayNow",
                                         kFIRParameterContentType:@"Button Clicks"
                                         }];
        
    }
    else{
        [FTIndicator showToastMessage:@"No OutStanding Amount"];
    }
//    ErrorViewController *errvc =[self.storyboard instantiateViewControllerWithIdentifier:@"errorVC"];
//    [self presentViewController:errvc animated:YES completion:nil];

}
@end
