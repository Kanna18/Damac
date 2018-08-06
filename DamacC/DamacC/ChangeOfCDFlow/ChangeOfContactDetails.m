//
//  ChangeOfContactDetails.m
//  DamacC
//
//  Created by Gaian on 03/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ChangeOfContactDetails.h"

@interface ChangeOfContactDetails ()

@end

@implementation ChangeOfContactDetails{
    
    StepperView *sterView;
    CGFloat heightTV,numberOfCells;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _stepperBaseView.backgroundColor = [UIColor clearColor];
    heightTV = 70;
    numberOfCells = 3;
    _tableViewHeight.constant = heightTV;
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    sterView = [[StepperView alloc]initWithFrame:_stepperBaseView.frame];
    [self.view addSubview:sterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numberOfCells;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangeofContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changeofContactCell"];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightTV;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mobileClick:(id)sender {
    numberOfCells = 1;
    _tableViewHeight.constant = heightTV;
    [_tableView reloadData];
}

- (IBAction)emailClick:(id)sender {
    numberOfCells = 2;
    _tableViewHeight.constant = 140;
    [_tableView reloadData];
}

- (IBAction)addressClick:(id)sender {
    numberOfCells = 3;
    _tableViewHeight.constant = 280;
    [_tableView reloadData];
}
- (IBAction)saveDraftClick:(id)sender {
}

- (IBAction)downloadFormClick:(id)sender {
}
@end
