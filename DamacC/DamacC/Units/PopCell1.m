//
//  PopCell1.m
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PopCell1.h"

@implementation PopCell1{
    
    NSMutableArray *dropItems;
    int unitsIndex;
    NSArray *unitsSFIdsArray;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self webServicetoGetUnitSFIds];
    [self roundCorners:_buttonnext];
    [self roundCorners:_buttonUnits];
    [self roundCornersBase:_kpDropBaseView];
    dropItems = [[NSMutableArray alloc]init];
    for (ResponseLine *res in [DamacSharedClass sharedInstance].unitsArray) {
        [dropItems addObject:res.unitNumber];
    }
    
    [self dropMenu];
    unitsIndex = 0 ;
}

-(void)webServicetoGetUnitSFIds{
    ServerAPIManager *serverAPI = [ServerAPIManager sharedinstance];
    [serverAPI postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            unitsSFIdsArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)roundCorners:(UIButton*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
}
-(void)roundCornersBase:(KPDropMenu*)sender{
    sender.layer.cornerRadius = 20;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
}



-(void)dropMenu{
    
    _kpDropBaseView.backgroundColor = [UIColor clearColor];
    _kpDropBaseView.layer.cornerRadius = 10.0f;
    _kpDropBaseView.layer.borderColor = [UIColor yellowColor].CGColor;
    _kpDropBaseView.layer.borderWidth = 1.0f;
    _kpDropBaseView.backgroundColor = [UIColor clearColor];
    _kpDropBaseView.delegate = self;
    _kpDropBaseView.items = dropItems;
    _kpDropBaseView.title = dropItems[0] ? dropItems[0] : @"";
    _kpDropBaseView.titleColor = goldColor;
//    _kpDropBaseView.titleTextAlignment = NSTextAlignmentLeft;
    _kpDropBaseView.DirectionDown = YES;
    
}
#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    _kpDropBaseView.title = dropItems[atIntedex];
    unitsIndex = atIntedex;
    _popObj.selectedUnit = [DamacSharedClass sharedInstance].unitsArray[atIntedex];
    _popObj.AccountID = unitsSFIdsArray[atIntedex][@"Booking__c"];
    NSLog(@"ID Selected");
}

-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}

- (IBAction)getUnitsClick:(id)sender {
    
    DetailMyUnitsViewController *dm = [DamacSharedClass.sharedInstance.currentVC.storyboard instantiateViewControllerWithIdentifier:@"detailMyUnitsVC"];
    ResponseLine *responseUnit = DamacSharedClass.sharedInstance.unitsArray[unitsIndex];
    dm.responseUnit = responseUnit;
    [DamacSharedClass.sharedInstance.currentVC.navigationController pushViewController:dm animated:YES];
}
@end
