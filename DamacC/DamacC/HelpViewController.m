//
//  HelpViewController.m
//  DamacC
//
//  Created by Gaian on 04/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewCell.h"
@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HelpViewController{
    
    VCFloatingActionButton *addButton;
    CGFloat scr_width, scr_height;
    NSArray *tvData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    tvData = @[@"HOW TO BOOK APPOINTMENTS",@"HELLO DAMAC USER GUIDE",@"HOW TO MAKE PAYMENT TO DAMAC",@"USEFUL INFORMATION",@""];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)skipClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Mark tableView Delagates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tvData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"helpTableViewCell"];
    cell.labelSub.text = tvData[indexPath.row];
    cell.imageViewSub.image = [UIImage imageNamed:[NSString stringWithFormat:@"help%d",(int)(indexPath.row+1)]];
    if(indexPath.row == 3){
        cell.borderView.hidden = NO;
    }
    else{
        cell.borderView.hidden = YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==4){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==4){
        return 70;
    }else{
    return 50;
    }
}
@end

