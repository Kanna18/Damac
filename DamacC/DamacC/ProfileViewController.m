//
//  ProfileViewController.m
//  DamacC
//
//  Created by Gaian on 02/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProfileViewController
{
    
    NSArray *tvArray;
    NSArray *valuesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _detailsTableview.delegate = self;
    _detailsTableview.dataSource = self;
    
    tvArray = @[@[@"Mobile:",@"Email:",@"Address:",@"City:",@"Country:"],
                @[@"Party Id:",@"Nationality:",@"Passport Number:",@"Passport Issue Date:"]];
    [self fillValues];
    _headingButton.layer.cornerRadius = radiusCommon;
    _headingButton.layer.borderWidth = borderWidthCommon;
    _headingButton.layer.borderColor = borderColorCommon;
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    
}
-(void)fillValues{
    
    _partyLabel.text =kUserProfile.partyType;
    _currentLabel.text = kUserProfile.currentPortfolio;
    _portofolioLabel.text = kUserProfile.overallPortfolio;
    _nameLabel.text = kUserProfile.partyName;
    
    NSString *num = [NSString stringWithFormat:@"%@%@%@",kUserProfile.phoneCountry,kUserProfile.phoneAreaCode,kUserProfile.phoneNumber];
    valuesArr = @[@[num,
                    [self fillNill:kUserProfile.emailAddress],
                    [self fillNill:kUserProfile.addressLine1],
                    [self fillNill:kUserProfile.city],
                    [self fillNill:kUserProfile.countryOfResidence]],
                  @[[self fillNill:kUserProfile.partyId],
                    [self fillNill:kUserProfile.nationality],
                    [self fillNill:kUserProfile.passportNumber],
                    [self fillNill:kUserProfile.ppIssueDate]]
                  ];
}

-(void)allLabes{
    for (UILabel *lb in self.view.subviews) {
        if([lb isKindOfClass:[UILabel class]]){
        [lb setAdjustsFontSizeToFitWidth:YES];
        }
    }
}

-(NSString*)fillNill:(NSString*)str{
    if(str){
        return str;
    }else{
        return @" ";
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"My Profile"];
    [self allLabes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *reus = @"detailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reus];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reus];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",tvArray[indexPath.section][indexPath.row], valuesArr[indexPath.section][indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"prof%lu",indexPath.row+1]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tvArray[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tvArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0){
        UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
//        vw.backgroundColor = rgb(197, 152, 66);
        return vw;
    }
    return  nil;
}
@end
