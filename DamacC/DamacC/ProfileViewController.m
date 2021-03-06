//
//  ProfileViewController.m
//  DamacC
//
//  Created by Gaian on 02/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource,ImagePickedProtocol>

@end

@implementation ProfileViewController
{
    
    NSArray *tvArray;
    NSArray *valuesArr;
    CameraView *ca;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _detailsTableview.delegate = self;
    _detailsTableview.dataSource = self;
    
    tvArray = @[@[@"Mobile:",@"Email:",@"Address:",@"City:",@"Country:"],
                @[@"Party Id:",@"Nationality:",@"Passport Number:",@"Passport expiry Date:"]];
    [self fillValues];
    _headingButton.layer.cornerRadius = radiusCommon;
    _headingButton.layer.borderWidth = borderWidthCommon;
    _headingButton.layer.borderColor = borderColorCommon;
    ca = [[CameraView alloc]initWithFrame:CGRectZero parentViw:self];
    [self.view addSubview:ca];
    ca.delegate = self;
    
}
-(void)fillValues{
    
    _partyLabel.text =kUserProfile.partyType;
    _currentLabel.text = kUserProfile.currentPortfolio;
    _portofolioLabel.text = kUserProfile.overallPortfolio;
    
    if(kUserProfile.partyName){
        _nameLabel.text = handleNull(kUserProfile.partyName);
    }else{
        _nameLabel.text = handleNull(kUserProfile.organizationName);
    }
    
    NSString *num = kUserProfile.phoneNumber;//[NSString stringWithFormat:@"%@%@%@",kUserProfile.phoneCountry,kUserProfile.phoneAreaCode,kUserProfile.phoneNumber];
    valuesArr = @[@[num,
                    [self fillNill:kUserProfile.emailAddress],
                    [NSString stringWithFormat:@"%@ %@ %@ %@",[self fillNill:kUserProfile.addressLine1],[self fillNill:kUserProfile.addressLine2],[self fillNill:kUserProfile.addressLine3],[self fillNill:kUserProfile.addressLine4]],
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"My profile"];
    UIImage *image = [UIImage imageWithContentsOfFile:[self isImageAvailable]];
//    if(image){
        _profilePic.image = image;
        [self roundCorners:_profilePic];
//    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"My Profile"];
    DamacSharedClass.sharedInstance.currentVC = self;
    [DamacSharedClass.sharedInstance.navigationCustomBar.backBtn setImage:DamacSharedClass.sharedInstance.backImage forState:UIControlStateNormal];
    [self allLabes];
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)roundCorners:(UIImageView*)sender{
    sender.layer.cornerRadius = sender.frame.size.height/2;
    sender.layer.borderColor = goldColor.CGColor;
    sender.layer.borderWidth =3.0;
    sender.clipsToBounds = YES;
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
- (IBAction)profileImageUploadClick:(id)sender {
    
    [ca frameChangeCameraView];
}

#pragma mark Cam ViewDelegate
-(void)imagePickerSelectedImage:(UIImage *)image{
    _profilePic.image = image;
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [self saveImageLocally:data];
}

-(NSString*)isImageAvailable{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
    return imagePath;
}
-(void)saveImageLocally:(NSData*)imageData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
    
    NSLog(@"pre writing to file");
    if (![imageData writeToFile:imagePath atomically:NO])
    {
        NSLog(@"Failed to cache image data to disk");
    }
    else
    {
        NSLog(@"the cachedImagedPath is %@",imagePath);
    }

}

@end
