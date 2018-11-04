//
//  MainViewController.m
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "MainViewController.h"
#import <SalesforceSDKCore/SFUserAccountManager.h>
#import "TopCollectionCell.h"
#import "GridCollectionViewCell.h"
#import "ServicesTableViewController.h"
#import "VCFloatingActionButton.h"
#import "ProfileViewController.h"
#import "BillingViewController.h"
#import "ScheduleAppointmentsVC.h"
#import "UnitsTableViewController.h"
#import "SampleTableViewController.h"
#import "ReceiptsTableVC.h"
#import "SurveyViewController.h"
#import "ComplaintsObj.h"
#import "SurveyController.h"




@interface MainViewController ()<VKSideMenuDelegate, VKSideMenuDataSource,floatMenuDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) VKSideMenu *menuLeft;

@end

@implementation MainViewController{
    
    CGFloat scr_width, scr_height;
    NSArray *gridArray,*gridArrayThumbnails;
    NSDictionary *sideMenuDict,*dataDictionary,*dataDictionaryUnits;
    NSMutableArray *topCVArray;
    CustomBar *cstm;
    
}
- (IBAction)showMenuVCButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.menuLeft = [[VKSideMenu alloc] initWithSize:220 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.view];
    
    topCVArray = [[NSMutableArray alloc]init];
    gridArray = @[kMyUnits,kMyServiceRequests,kSOA,kPay,kMyPaymentScedules,kMyReceipts,kComplaints,kSurveys];
    gridArrayThumbnails =@[@"1Main",@"2Main",@"3Main",@"4Main",@"5Main",@"6Main",@"7Main",@"8Main"];
//    @[kMyUnits,@"service.jpg",@"PaymentSchedule.jpg",@"Receipts.jpg",@"Appointment.jpg",@"PayNow.jpg",@"Complaints.jpg",@"Surveys.jpg"];
    
    
    UICollectionViewFlowLayout *floe = [[UICollectionViewFlowLayout alloc]init];
    [floe setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.navigationController.navigationBar.hidden=NO;
    
    sideMenuDict = @{@"section2":@[@"My Units",@"My Service Requests",@"Payment Schedules",@"Create Requests"],
                     @"section4":@[@"1side",@"2side",@"3side",@"4side"],
                     @"section1":@[@"Profile"],
                     @"section3":@[@"Notification",@"My Profile",kLogout],
                     @"section5":@[@"5side",@"6side",@"7side"]
                     };        
//    [self serverCall];
    dataDictionary = [DamacSharedClass sharedInstance].firstDataObject;
    [self setTopArrayData:[DamacSharedClass sharedInstance].firstDataObject];
//    [FTIndicator showProgressWithMessage:@"Loading" userInteractionEnable:NO];

    NSLog(@"%@",self.navigationItem);
    
//    self.carousel.type = iCarouselTypeRotary;
//    self.carousel.delegate = self;
//    self.carousel.dataSource = self;
    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@""];
//    [self setTopArrayData:nil];
//    self.navigationController.navigationBar.hidden = YES;
    
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    if(!([DamacSharedClass sharedInstance].unitsArray.count>0)){
         [FTIndicator showProgressWithMessage:@"Loading Please Wait" userInteractionEnable:NO];
         [self getUnitsintheBakground];
//        self.view.userInteractionEnabled = NO;
    }
//    });
    
}



-(NSString*)setNillValue:(NSString*)str{
    NSString *value = str ? str : @"";
    return  value;
}

//-(void)serverCall{
//    ServerAPIManager *server = [ServerAPIManager sharedinstance];
//    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
//    NSString * url = [NSString stringWithFormat:@"%@%@",maiUrl,[sf.currentUserIdentity valueForKeyPath:@"userId"]];
//    [server getRequestwithUrl:url successBlock:^(id responseObj) {
//        dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
//        [self setTopArrayData:dataDictionary];
//        NSLog(@"%@",dataDictionary);
//        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
//    } errorBlock:^(NSError *error) {
//        NSLog(@"%@",error);
//        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
//    }];
//}

-(void)setTopArrayData:(NSDictionary*)dic{
    if(dic&&dic[@"responseLines"][0]){
        NSDictionary *di = dic[@"responseLines"][0];
        kUserProfile = [[UserDetailsModel alloc]initWithDictionary:dic[@"responseLines"][0] error:nil];
        NSString * port = kUserProfile.overallPortfolio;//[NSString stringWithFormat:@"%@",di[@"overallPortfolio"]];
        NSString * curent = kUserProfile.currentPortfolio;//[NSString stringWithFormat:@"%@",di[@"currentPortfolio"]];
        [topCVArray addObject:@{@"key":[self setNillValue:overallPortofolio],@"value":[self setNillValue:port],@"image":@"1icon",}];
        [topCVArray addObject:@{@"key":[self setNillValue:currentPortofolio],@"value":[self setNillValue:curent],@"image":@"2icon",}];
        [topCVArray addObject:@{@"key":[self setNillValue:paymentsDue],@"value":@"125.52k",@"image":@"3icon",}];
        [topCVArray addObject:@{@"key":[self setNillValue:openServiceRequests],@"value":@"",@"image":@"4icon"}];
        [_topCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
//        [self.carousel performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }else{
        NSDictionary *di = dic[@"responseLines"][0];
        kUserProfile = [[UserDetailsModel alloc]initWithDictionary:dic[@"responseLines"][0] error:nil];
        NSString * port = kUserProfile.overallPortfolio;//[NSString stringWithFormat:@"%@",di[@"overallPortfolio"]];
        NSString * curent = kUserProfile.currentPortfolio;//[NSString stringWithFormat:@"%@",di[@"currentPortfolio"]];
        [topCVArray addObject:@{@"key":[self setNillValue:overallPortofolio],@"value":[self setNillValue:port],@"image":@"1icon",}];
        [topCVArray addObject:@{@"key":[self setNillValue:currentPortofolio],@"value":[self setNillValue:curent],@"image":@"2icon",}];
        [topCVArray addObject:@{@"key":[self setNillValue:paymentsDue],@"value":@"",@"image":@"3icon",}];
        [topCVArray addObject:@{@"key":[self setNillValue:openServiceRequests],@"value":@"",@"image":@"4icon"}];
        [_topCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
}
-(void)dismissProgress{
    [FTIndicator dismissProgress];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    static dispatch_once_t onceToken;
    [self customNavBarVie];
    
    
}

-(void)customNavBarVie{
    cstm = [[CustomBar alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 65)];
    DamacSharedClass.sharedInstance.navigationCustomBar = cstm;
    
    [cstm.backBtn setImage:[UIImage imageNamed:@"icon1"] forState:UIControlStateNormal];
    [cstm.backBtn setTitle:@"" forState:UIControlStateNormal];    
    [cstm.backBtn addTarget:self action:@selector(buttonMenuLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:cstm];
//    [[[UIApplication sharedApplication].delegate window] addSubview:cstm];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    scr_width = [UIScreen mainScreen].bounds.size.width;
    scr_height = [UIScreen mainScreen].bounds.size.height;
    [_gridCollectionView reloadData];
    [_topCollectionView reloadData];
//    [self.carousel reloadData];
//    self.navigationController.navigationBar.topItem.title = @"Dashboard";
    
    if( DamacSharedClass.sharedInstance.windowButton.hidden == YES){
         DamacSharedClass.sharedInstance.windowButton.hidden = NO;
    }

    
}



#pragma mark FloatingMenu Delegate
-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
//@[@"My Profile",@"Create Requets",@"Schedule Appointments",@"Live Chat",@"Dail Customer Service"];
    NSLog(@"Floating action tapped index %tu",row);
    switch (row) {
        case 2:
            [self loadBasedontheclick:kSOA];
            break;
        case 4:
            [self loadBasedontheclick:kprofilePage];
            break;
        case 3:
            [self loadBasedontheclick:kEServices];
            break;
        case 1:
            [self openEmailFeature];
            break;
        case 0:
            [self callCustomerService];
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonMenuLeft:(id)sender
{
    if(cstm.backBtn.imageView.image == [UIImage imageNamed:@"icon1"]){
        [self.menuLeft show];
    }
}



#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    if(sideMenu == self.menuLeft){
        return 3;
    }
    return 0;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
    {
        if(section == 0){
            return [sideMenuDict[@"section1"] count];
        }if(section == 1){
            return [sideMenuDict[@"section2"] count];
        }if(section == 2){
            return [sideMenuDict[@"section3"] count];
        }
    }
    return 0;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    if (sideMenu == self.menuLeft) // All LEFT and TOP menu items
    {
        if(indexPath.section==0){
            item.title = sideMenuDict[@"section1"][indexPath.row];
            item.icon  = [UIImage imageNamed:sideMenuDict[@"section1"][indexPath.row]];
        }
        if(indexPath.section==1){
            item.title = sideMenuDict[@"section2"][indexPath.row];
            item.icon  = [UIImage imageNamed:sideMenuDict[@"section4"][indexPath.row]];
        }
        if(indexPath.section==2){
            item.title = sideMenuDict[@"section3"][indexPath.row];
            item.icon  = [UIImage imageNamed:sideMenuDict[@"section5"][indexPath.row]];
        }
    }
    return item;
}


#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
    VKSideMenuItem *item = [sideMenu.dataSource sideMenu:sideMenu itemForRowAtIndexPath:indexPath];
    
    if([item.title isEqualToString:kLogout]){
        defaultRemove(kMPin);
        defaultRemove(kconfirmMpin);
        defaultRemove(kenterMpin);
        [self redirecttoTouchIDWhenLogout];
    }
//    @[@"Home",@"My Units",@"My Service Requests",@"Payments",@"E-Services"]
    if([item.title isEqualToString:@"My Units"]){
        [self loadBasedontheclick:kMyUnits];
    }if([item.title isEqualToString:@"My Service Requests"]){
        [self loadBasedontheclick:kMyServiceRequests];
    }if([item.title isEqualToString:@"Create E-Services"]){
        [self loadBasedontheclick:kEServices];
    }if([item.title isEqualToString:@"Payment Schedules"]){
        [self loadBasedontheclick:kMyPaymentScedules];
    }if([item.title isEqualToString:@"User Profile"]){
        [self loadBasedontheclick:@"User Profile"];
    }if([item.title isEqualToString:kSOA]){
        [self loadBasedontheclick:kSOA];
    }if([item.title isEqualToString:kprofilePage]){
        [self loadBasedontheclick:kprofilePage];
    }
    if([item.title isEqualToString:@"Create Requests"]){
        [self loadBasedontheclick:kEServices];
    }
    
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    NSLog(@"%@ VKSideMenue did show", menu);
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    NSLog(@"%@ VKSideMenue did hide", menu);
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;
    
    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
}


#pragma mark collection View Delegates


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == _topCollectionView){
        return 4;
    }
    if (collectionView == _gridCollectionView)
    {
        return gridArray.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == _topCollectionView){

        static NSString *cellIdentifier = @"topCell";
        TopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.thumbImageView.image = [UIImage imageNamed:[topCVArray[indexPath.row] valueForKey:@"image"]];
        cell.label1.text = [topCVArray[indexPath.row] valueForKey:@"value"];
        cell.label2.text = [topCVArray[indexPath.row] valueForKey:@"key"];
        [cell.label1 setAdjustsFontSizeToFitWidth:YES];
        return cell;
    }
    if(collectionView == _gridCollectionView){
        static NSString *cellIdentifier = @"gridCell";
        GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.headingLabel.text = gridArray[indexPath.row];
        dispatch_async(dispatch_get_main_queue(), ^{
        cell.thumbNail.image = [UIImage imageNamed:gridArrayThumbnails[indexPath.row]];
        });
        return cell;
    }
   
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == _gridCollectionView){
        GridCollectionViewCell *cell = (GridCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        NSString *str = cell.headingLabel.text;
        [self loadBasedontheclick:str];
    }
}

-(void)loadBasedontheclick:(NSString*)str{
    
    if([str isEqualToString:kMyServiceRequests]){
        MyServiceRequestViewController *evc =[ self.storyboard instantiateViewControllerWithIdentifier:@"myServicesRequestVC"];
        evc.typeoFVC = kloadingFromCreateServices;
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:evc animated:YES];
    }
    if([str isEqualToString:kMyUnits]){
//       [self pushToTableView:kMyUnits];
        UnitsTableViewController *uVC = [self.storyboard instantiateViewControllerWithIdentifier:@"unitsTableVC"];
        NSString *str = [DamacSharedClass sharedInstance].userProileModel.partyId;;
        uVC.serverUrlString = [unitsServiceUrl stringByAppendingString:str?str:@"1036240"];
//        uVC.serverUrlString = [unitsServiceUrl stringByAppendingString:@"1036240"];
        //[self returnNextScreenWebUrlBasedOnGridClick:kMyUnits];
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:uVC animated:YES];
//
//        SampleTableViewController *uVC = [self.storyboard instantiateViewControllerWithIdentifier:@"sampleTableVC"];
////        uVC.serverUrlString = [self returnNextScreenWebUrlBasedOnGridClick:kMyUnits];
//        [self.navigationController pushViewController:uVC animated:YES];
    }
    if([str isEqualToString:kMyPaymentScedules]){
//        [self pushToTableView:kMyPaymentScedules];
        PaymentsScheduleVC *uVC = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentsScheduleVC"];
        NSString *str = [DamacSharedClass sharedInstance].userProileModel.partyId;;
        uVC.serverUrlString = [unitsServiceUrl stringByAppendingString:str?str:@"1036240"];
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:uVC animated:YES];
    }
    if([str isEqualToString:kMyReceipts]){
//        [self pushToTableView:kMyReceipts];
        ReceiptsTableVC *uVC = [self.storyboard instantiateViewControllerWithIdentifier:@"receiptsTableVC"];
        uVC.serverUrlString = [self returnNextScreenWebUrlBasedOnGridClick:kMyReceipts];
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:uVC animated:YES];
    }
    if([str isEqualToString:kEServices]){
        EServicesViewController *evc =[ self.storyboard instantiateViewControllerWithIdentifier:@"eservicesVC"];
        evc.typOfVC=kEServices;
        evc.arrayOflist=eservicesArray;
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:evc animated:YES];
    }
    if([str isEqualToString:kPay]){
        [self pushToTableView:kPay];
    }
    if([str isEqualToString:kprofilePage]){
        ProfileViewController *pvc =[ self.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:pvc animated:YES];
    }
    if([str isEqualToString:kSOA]){
        ScheduleAppointmentsVC *pvc =[ self.storyboard instantiateViewControllerWithIdentifier:@"scheduleAppointmentsVC"];
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:pvc animated:YES];
    }
    if([str isEqualToString:kComplaints]){
        ComplaintsViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"complaintsViewController"];
        ComplaintsObj *comp = [[ComplaintsObj alloc]init];
        [comp fillWithDefaultValues];
        cvc.complaintsObj = comp;
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:cvc animated:YES];
        
    }
    if([str isEqualToString:kSurveys]){
        SurveyController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"surveyController"];
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:cvc animated:YES];
    }
    
    
}

-(void)getUnitsintheBakground{
    DamacSharedClass.sharedInstance.windowButton.userInteractionEnabled = NO;
    NSString *str = [DamacSharedClass sharedInstance].userProileModel.partyId;;
    NSString *unitsUrl = [unitsServiceUrl stringByAppendingString:str?str:@"1036240"];
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server getRequestwithUrl:unitsUrl successBlock:^(id responseObj) {
            if(responseObj){
                dataDictionaryUnits = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
                NSError *err;
                UnitsDataModel  *unitsDM = [[UnitsDataModel alloc]initWithDictionary:dataDictionaryUnits error:&err];
                [DamacSharedClass sharedInstance].unitsArray = [[NSMutableArray alloc]initWithArray:unitsDM.responseLines];
                [self performSelectorOnMainThread:@selector(loadingUnitsValidations) withObject:nil waitUntilDone:YES];
            }
        } errorBlock:^(NSError *error) {
            [FTIndicator performSelectorOnMainThread:@selector(loadingUnitsValidations) withObject:nil waitUntilDone:YES];
            
            
    }];
}
-(void)loadingUnitsValidations{
//    self.view.userInteractionEnabled = YES;
    DamacSharedClass.sharedInstance.windowButton.userInteractionEnabled = YES;
    [FTIndicator dismissProgress];
}
-(NSString*)returnNextScreenWebUrlBasedOnGridClick:(NSString*)type{
    if(dataDictionary&&[dataDictionary[@"actions"] count]>0){
        NSArray *arr = dataDictionary[@"actions"];
        if([type isEqualToString:kMyUnits]||[type isEqualToString:kMyPaymentScedules]||[type isEqualToString:kPay]){
            return [arr[0] valueForKey:@"url"];
        }
        if([type isEqualToString:kMyReceipts]){
            return [arr[1] valueForKey:@"url"];
        }
    }
    return @"";
}

-(void)pushToTableView:(NSString*)type{
    ServicesTableViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"servicesTableVC"];
    svc.typeOfvc = type;
    if([type isEqualToString:kPay]){
        NSString *str = [DamacSharedClass sharedInstance].userProileModel.partyId;;
        svc.serverUrlString = [unitsServiceUrl stringByAppendingString:str?str:@"1036240"];
    }else{
        svc.serverUrlString = [self returnNextScreenWebUrlBasedOnGridClick:type];
    }
    [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    
     [self.navigationController pushViewController:svc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == _topCollectionView){
        return  CGSizeMake(collectionView.frame.size.width/4-10 , 130);
    }
    if(collectionView == _gridCollectionView){
        return  CGSizeMake(collectionView.frame.size.width/2-10, 150);
    }
    return  CGSizeZero;
}

-(void)redirecttoTouchIDWhenLogout{
    
    UIStoryboard *appStoryboard =
    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(defaultGet(kMPin)&&defaultGet(kconfirmMpin)){
        KeyViewController *key =[appStoryboard instantiateViewControllerWithIdentifier:@"keyVC"];
        self.navigationController.navigationBar.hidden = YES;
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:key animated:YES];
    }else if(defaultGetBool(kFingerPrintAvailabe)){
        FingerPrintViewController *rootVC = [appStoryboard instantiateViewControllerWithIdentifier:@"fingerPrintVC"];
        self.navigationController.navigationBar.hidden = YES;
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:rootVC animated:YES];
    }else if(!defaultGetBool(kFingerPrintAvailabe)){
        PasswordViewController *rootVC = [appStoryboard instantiateViewControllerWithIdentifier:@"passwordVC"];
        self.navigationController.navigationBar.hidden = YES;
        [cstm.backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        
        [self.navigationController pushViewController:rootVC animated:YES];
    }
}


#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[topCVArray count];
}
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 300;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        CustomViewCarousel *cvv = [[CustomViewCarousel alloc] initWithFrame:CGRectMake(0, 0, 200.0, 127.0)];
        cvv.thumbnail.image = [UIImage imageNamed:[topCVArray[index] valueForKey:@"image"]];
        cvv.label1.text = [topCVArray[index] valueForKey:@"value"];
        cvv.label2.text = [topCVArray[index] valueForKey:@"key"];
        view = cvv;
        
        
//        ((UIImageView *)view).image = [UIImage imageNamed:@"colorBg"];
//        view.contentMode = UIViewContentModeScaleAspectFit;
//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [label.font fontWithSize:16];
//        label.tag = 1;
//        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [topCVArray[index] valueForKey:@"value"];
    
//    cell.thumbImageView.image = [UIImage imageNamed:[topCVArray[indexPath.row] valueForKey:@"image"]];
//    cell.label1.text = [topCVArray[indexPath.row] valueForKey:@"value"];
//    cell.label2.text = [topCVArray[indexPath.row] valueForKey:@"key"];
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120.0, 120.0)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"colorBg"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:16.0];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0.0, 1.0, 0.0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;//self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
//    NSNumber *item = (self.items)[(NSUInteger)index];
//    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}



-(void)openEmailFeature{
    
    if ([MFMailComposeViewController canSendMail])
    {
//        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
//        NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[orderStatusFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.pdf",_sfID.text,(int)indexInteger]]];
//        NSLog(@"%@",documentDirectoryFilename);


        NSString *emailTitle = [NSString stringWithFormat:@"Email Title"];
        NSString *messageBody = @"e-mail body";
        NSArray *toRecipents = [NSArray arrayWithObject:@""];
//        NSString *path = [[NSBundle mainBundle] pathForResource:documentDirectoryFilename ofType:@"pdf"];
//        NSData *myData= [NSData dataWithContentsOfFile:documentDirectoryFilename];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:@[@"atyourservice@damacproperties.address"]];
//        [mc addAttachmentData:ni mimeType:@"application/pdf" fileName:@""];
        [mc setToRecipients:toRecipents];
        [DamacSharedClass.sharedInstance.currentVC presentViewController:mc animated:YES completion:NULL];
    }
    else
    {
        [FTIndicator showToastMessage:@"Please Configure Mail Settings in your Device"];
    }
}
-(void)callCustomerService{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+97142375000"]];
}
#pragma Mark Mail Delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [DamacSharedClass.sharedInstance.currentVC dismissViewControllerAnimated:YES completion:NULL];
}


@end
