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
#import "ServicesCell.h"

@interface MyServiceRequestViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *tvDataArray,*sortedArray;
    KPDropMenu *dropNew;

    AppDelegate *del;
    
    UIColor *selectedColor,*unselectedColor;
}

@end

@implementation MyServiceRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    _buttonsView.layer.borderWidth = 2.0f;
//    _buttonsView.layer.borderColor = rgb(174, 134, 73).CGColor;
//    _buttonsView.layer.cornerRadius = 5.0f;
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [self webServiceCall];
    tvDataArray = [[NSMutableArray alloc]init];
    [FTIndicator showProgressWithMessage:@"Loading please wait" userInteractionEnable:NO];
    sortedArray = [[NSMutableArray alloc]init];
    
    del = (AppDelegate*)[UIApplication sharedApplication].delegate;
    selectedColor = rgb(151, 121, 73);
    unselectedColor = rgb(68, 68, 68);
    [self changeSelectedColor:_btnAll];
    if(_loadFromServisesMenu){
        _eservicesMessage.hidden = NO;
    }else{
        _eservicesMessage.hidden = YES;
    }
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 200, 0)];
    _hilightedView.hidden = YES;
    
    /*Latest Google Analytics*/
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"%@", kUserProfile.partyId],
                                     kFIRParameterItemName:[NSString stringWithFormat:@"Service_Request"],
                                     kFIRParameterContentType:@"Button Clicks"
                                     }];
    [FIRAnalytics setScreenName:@"My Service Request" screenClass:NSStringFromClass([self class])];
}

-(void)changeSelectedColor:(UIButton*)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_btnAll setTitleColor:unselectedColor forState:UIControlStateNormal];
        [_btnNew setTitleColor:unselectedColor forState:UIControlStateNormal];
        [_btnDraft setTitleColor:unselectedColor forState:UIControlStateNormal];
        [sender setTitleColor:selectedColor forState:UIControlStateNormal];
    });
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[DamacSharedClass sharedInstance].navigationCustomBar setPageTite:@"My service request"];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _bottomView.bounds;
    gradient.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor, (id)[UIColor blackColor].CGColor];
//    gradient.colors = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor greenColor].CGColor];
    [_bottomView.layer insertSublayer:gradient atIndex:0];
//    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"My Service Request"];
//    [self dropMenu];
    DamacSharedClass.sharedInstance.windowButton.hidden = NO;
    DamacSharedClass.sharedInstance.currentVC = self;
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
    NSArray *arrPa = @[@"Draft Request",@"Submitted",@"Working",@"New",@"Cancelled"];
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSString *sfAccountID = sf.currentUser.credentials.userId;
    sfAccountID = sfAccountID ? sfAccountID : @"1036240";
    __block int Count = 0;
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
            
            
            if(Count == arrPa.count-1){
                    [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _hilightedView.hidden = NO;
                    });
                if(_loadFromServisesMenu){
                    [self draftClickForESErvices:nil];
                }else{
                    [self allClick:_btnAll];
                }
            }
            Count++;
        } errorBlock:^(NSError *error) {
            if(Count == arrPa.count-1){
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
    
    static NSString *reuseCell = @"servicesCell";
    ServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    MyServicesDataModel *sm = sortedArray[indexPath.row];
    cell.label1.text =sm.CaseNumber;
    cell.label2.text =sm.RecordType.Name;
    cell.label3.text =sm.Status;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];    
    cell.tapButton.tag = indexPath.row;
    [cell.tapButton addTarget:self action:@selector(sendToDetailScreen:) forControlEvents:UIControlEventTouchUpInside];
    if(indexPath.row%2==0){
        cell.contentView.backgroundColor = rgb(50, 50, 50);
    }else{
        cell.contentView.backgroundColor = rgb(41, 41, 41);
    }
    return cell;
}
-(void)sendToDetailScreen:(UIButton*)sender{

    MyServicesDataModel *sm = sortedArray[sender.tag];
//    if([sm.Status isEqualToString:@"Cancelled"]){
//        [FTIndicator showToastMessage:@"Service Request has been Cancelled"];
//    }else{
        ServicesDetailController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"servicesDetailVC"];
        svc.servicesDataModel = sortedArray[sender.tag];
        svc.srCaseId = sm.CaseNumber;
        [self.navigationController pushViewController:svc animated:YES];
//    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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

- (IBAction)draftClickForESErvices:(id)sender {
    [self sortTvData:@[@"Draft Request",@"Submitted",@"Working"]];
    [self setSelecteStates:(UIButton*)sender];
    [self changeSelectedColor:(UIButton*)sender];
}


- (IBAction)newButtonClick:(id)sender {
    
    [self sortTvData:@[@"New",@"Working",@"Submitted"]];
    [self setSelecteStates:(UIButton*)sender];
    [self changeSelectedColor:(UIButton*)sender];
}

- (IBAction)draftClick:(id)sender {
    [self sortTvData:@[@"Draft Request"]];
    [self setSelecteStates:(UIButton*)sender];
    [self changeSelectedColor:(UIButton*)sender];
}

- (IBAction)allClick:(id)sender {
    [self sortTvData:@[@"Draft Request",@"Submitted",@"Working",@"Cancelled",@"New"]];
    [self setSelecteStates:(UIButton*)sender];
    [self changeSelectedColor:(UIButton*)sender];
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
    NSMutableArray *finalArr = [NSMutableArray arrayWithArray:a];
        
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"CaseNumber" ascending:NO selector:@selector(localizedCompare:)];
    sortedArray = [NSMutableArray arrayWithArray:[finalArr sortedArrayUsingDescriptors:@[sortDescriptor]]];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (IBAction)creatteServiceClick:(id)sender {
    
    EServicesViewController *evc =[ self.storyboard instantiateViewControllerWithIdentifier:@"eservicesVC"];
    evc.typOfVC=kEServices;
    evc.arrayOflist=eservicesArray;
    [self.navigationController pushViewController:evc animated:YES];

}
@end
