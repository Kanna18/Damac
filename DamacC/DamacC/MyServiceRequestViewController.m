//
//  MyServiceRequestViewController.m
//  DamacC
//
//  Created by Gaian on 07/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "MyServiceRequestViewController.h"
#import "ServicesDetailController.h"
#import "AppDelegate.h"


@interface MyServiceRequestViewController ()<KPDropMenuDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *dropItems;
    NSMutableArray *tvDataArray,*sortedArray;
    KPDropMenu *dropNew;

    AppDelegate *del;
}

@end

@implementation MyServiceRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _buttonsView.layer.borderWidth = 2.0f;
    _buttonsView.layer.borderColor = rgb(174, 134, 73).CGColor;
    _buttonsView.layer.cornerRadius = 5.0f;
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [self webServiceCall];
    tvDataArray = [[NSMutableArray alloc]init];
    [FTIndicator showProgressWithMessage:@"Loading Payments"];
    sortedArray = [[NSMutableArray alloc]init];
    
    if([_typeoFVC isEqualToString:kloadingFromMenu]){
        _hideView.hidden = YES;
        _heightConstraint.constant = 100;
    }else if([_typeoFVC isEqualToString:kloadingFromCreateServices]){
        _heightConstraint.constant = 140;
         _hideView.hidden = YES;
//        _buttonsView.hidden = YES;
    }
    del = (AppDelegate*)[UIApplication sharedApplication].delegate;


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _bottomView.bounds;
    gradient.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor, (id)[UIColor blackColor].CGColor];
//    gradient.colors = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor greenColor].CGColor];
    [_bottomView.layer insertSublayer:gradient atIndex:0];
    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"My Service Request"];
//    [self dropMenu];
}
-(void)setSelecteStates:(UIButton*)btn{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _btnAll.selected = NO;
        _btnNew.selected = NO;
        _btnDraft.selected = NO;
        btn.selected = YES;
    });    
}
-(void)webServiceCall{
        ServerAPIManager *server = [ServerAPIManager sharedinstance];
    
    //Note:Any chnage in array also need to change ivalue in for loop-- (Value Dependency)
    NSArray *arrPa = @[@"Draft Request",@"Submitted",@"Working",@"New"/*,@"Cancelled"*/];
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSString *sfAccountID = sf.currentUser.credentials.userId;
    sfAccountID = sfAccountID ? sfAccountID : @"1036240";
    for (int iValue=0; iValue<arrPa.count; iValue++) {
        [server postRequestwithUrl:myServicesUrl withParameters:@{@"createdbyId":sfAccountID,@"status":arrPa[iValue]} successBlock:^(id responseObj) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            if(arr.count>0){
                for (NSDictionary *dic in arr) {
                    NSError *conErr;
                    if(dic[@"message"]){
                        SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
                        [sf logout];                        
                    }else{
                        MyServicesDataModel *serDm = [[MyServicesDataModel alloc]initWithDictionary:dic error: &conErr];
                        [tvDataArray addObject:serDm];
                    }
                }
            }
        
            if(iValue==3){
                [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                 if([_typeoFVC isEqualToString:kloadingFromMenu]){
                     [self allClick:nil];
                 }else if([_typeoFVC isEqualToString:kloadingFromCreateServices]){
//                     [self draftClick:nil];
                     [self allClick:nil];
                 }
            }
        } errorBlock:^(NSError *error) {
            if(iValue==3){
                NSLog(@"%@",error.localizedDescription);
                [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
            }
        }];
        [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
    }
}



#pragma mark Tableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sortedArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseCell = @"myServiceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    MyServicesDataModel *sm = sortedArray[indexPath.row];
    NSString *txt = [NSString stringWithFormat:@"SR No.-%@ - %@ - Status - %@",sm.CaseNumber,sm.RecordType.Name,sm.Status];
    cell.textLabel.text =txt;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServicesDetailController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"servicesDetailVC"];
    MyServicesDataModel *sm = sortedArray[indexPath.row];
    svc.servicesDataModel = sortedArray[indexPath.row];
    svc.srCaseId = sm.CaseNumber;
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)dropMenu{
    
    CGRect fram = [_dropButton convertRect:_dropButton.bounds toView:self.view];
    _dropButton.backgroundColor = [UIColor clearColor];
    dropItems = @[@"New", @"Draft Request"];
    dropNew = [[KPDropMenu alloc] initWithFrame:fram];
    dropNew.layer.cornerRadius = 10.0f;
    dropNew.layer.borderColor = [UIColor yellowColor].CGColor;
    dropNew.layer.borderWidth = 1.0f;
    dropNew.backgroundColor = [UIColor clearColor];
    dropNew.delegate = self;
    dropNew.items = dropItems;
    dropNew.title = @"Select Again";
    dropNew.titleColor = [UIColor yellowColor];
    dropNew.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    dropNew.titleTextAlignment = NSTextAlignmentLeft;
    dropNew.DirectionDown = YES;
    [self.view addSubview:dropNew];
    
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

#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    dropMenu.title = dropItems[atIntedex];
}
-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}
- (IBAction)newButtonClick:(id)sender {
    
    [self sortTvData:@[@"New"]];
    [self setSelecteStates:(UIButton*)sender];
}

- (IBAction)draftClick:(id)sender {
    [self sortTvData:@[@"Draft Request"]];
    [self setSelecteStates:(UIButton*)sender];
}

- (IBAction)allClick:(id)sender {
    [self sortTvData:@[@"Draft Request",@"Submitted",@"Working", @"Cancelled",@"New"]];
    [self setSelecteStates:(UIButton*)sender];
}

-(void)sortTvData:(NSArray*)arr{
    [sortedArray removeAllObjects];
    NSMutableArray *preArr = [[NSMutableArray alloc]init];
    for (NSString *str in arr) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Status == %@",str];
        [preArr addObject:predicate];
    }
    NSCompoundPredicate *fPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:preArr];
    NSArray *a = [tvDataArray filteredArrayUsingPredicate:fPredicate];
    sortedArray = [NSMutableArray arrayWithArray:a];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (IBAction)creatteServiceClick:(id)sender {
    
    EServicesViewController *evc =[ self.storyboard instantiateViewControllerWithIdentifier:@"eservicesVC"];
    evc.typOfVC=kEServices;
    evc.arrayOflist=eservicesArray;
    [self.navigationController pushViewController:evc animated:YES];

}
@end
