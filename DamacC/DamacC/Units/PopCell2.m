//
//  PopCell2.m
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PopCell2.h"
#import "POPTableCell.h"

@interface PopCell2()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PopCell2{
    
    NSArray *dropItems;
    NSArray *tvItems;
}



-(void)awakeFromNib{
    [super awakeFromNib];
    [self roundCorners:_buttonNext];       
    dropItems = @[@"Bank Transfer",@"Cash",@"Cheque",@"Credit Card"];
    [self dropMenu];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    tvItems = @[@"Payment Date*",@"Payment Allocation remarks",@"Total Amount*",@"Sender Name",@"Bank Name",@"Swift Code"];
    
}

-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
    
}

-(void)dropMenu{
    
    _baseDropView.backgroundColor = [UIColor clearColor];
    _baseDropView.layer.cornerRadius = 10.0f;
    _baseDropView.layer.borderColor = [UIColor yellowColor].CGColor;
    _baseDropView.layer.borderWidth = 1.0f;
    _baseDropView.backgroundColor = [UIColor clearColor];
    _baseDropView.delegate = self;
    _baseDropView.items = dropItems;
    _baseDropView.title = dropItems[0];
    _baseDropView.titleColor = [UIColor yellowColor];
    _baseDropView.titleTextAlignment = NSTextAlignmentLeft;
    _baseDropView.DirectionDown = YES;
    
}

#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    _baseDropView.title = dropItems[atIntedex];
}

-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    POPTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pOPTableCell" forIndexPath:indexPath];
    cell.popTF.text = tvItems[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tvItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


@end
