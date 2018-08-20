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
    NSArray *tvArr ;
    UserDetailsModel *udm;
    
    UIColor *selectedColor;
    

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
    udm = [DamacSharedClass sharedInstance].userProileModel;
    
    selectedColor = _view1.backgroundColor;
    [self mobileClick:nil];
    
    [self layerRadius:_view1];
    [self layerRadius:_view2];
    [self layerRadius:_view3];
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
    return tvArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangeofContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changeofContactCell"];
    cell.subLabel.text = tvArr[indexPath.row][@"key"];
    cell.textField.text = tvArr[indexPath.row][@"value"];

    return cell;
}
-(void)layerRadius:(UIView*)vw{
    vw.layer.cornerRadius = 5.0f;
    vw.layer.borderWidth = 1.0f;
    vw.layer.borderColor = selectedColor.CGColor;
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
    
    NSLog(@"%@",[DamacSharedClass sharedInstance].userProileModel);
    
    tvArr = @[@{@"key":@"Mobile No.",
                @"value":[NSString stringWithFormat:@"%@%@%@",udm.countryCode,udm.phoneAreaCode,udm.phoneNumber]}
              ];
    [_tableView reloadData];
    [self setColorsForSelectedButton:_view1];
    
}
-(void)setColorsForSelectedButton:(UIView*)v{
    _view1.backgroundColor = [UIColor clearColor];
    _view2.backgroundColor = [UIColor clearColor];
    _view3.backgroundColor = [UIColor clearColor];
    
    v.backgroundColor = selectedColor;
    
}

- (IBAction)emailClick:(id)sender {
    numberOfCells = 1;
    _tableViewHeight.constant = 140;
    tvArr = @[@{@"key":@"Email",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]}];
    [_tableView reloadData];
    [self setColorsForSelectedButton:_view2];
}

- (IBAction)addressClick:(id)sender {
    numberOfCells = 3;
    _tableViewHeight.constant = 280;
    tvArr = @[@{@"key":@"Address1",
                @"value":[NSString stringWithFormat:@"%@",udm.emailAddress]},
              @{@"key":@"City",
                @"value":[NSString stringWithFormat:@"%@",udm.city]},
              @{@"key":@"Country",
                @"value":[NSString stringWithFormat:@"%@",udm.countryOfResidence]},
              @{@"key":@"State",
                @"value":[NSString stringWithFormat:@"%@",udm.countryCode]},
              @{@"key":@"Postal Code",
                @"value":[NSString stringWithFormat:@"%@",udm.countryCode]}];
    [self setColorsForSelectedButton:_view3];
    [_tableView reloadData];
}
- (IBAction)saveDraftClick:(id)sender {
}

- (IBAction)downloadFormClick:(id)sender {
}
@end
