//
//  RentalPoolViewCellViewController.m
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "RentalPoolViewCellViewController.h"
#import "JointView1.h"
#import "JointBuyerCell.h"
#import "JointBuyerObject.h"


@interface RentalPoolViewCellViewController ()<KPDropMenuDelegate,WYPopoverControllerDelegate,POPDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation RentalPoolViewCellViewController{
    
    WYPopoverController* popoverController;
    KPDropMenu *dropNew;
    StepperView *sterView;
    JointBView2 *jbView ;
    JointView1 *jbView1;
    CGRect frame2 , frame3;
    ServerAPIManager *serverAPI;
    NSMutableArray *buyersInfoArr;
    NSMutableArray *dropitems;
    NSArray *headingLabels ,*dataLabels;
    JointBuyerObject *joObj;
    NSArray *countriesArray;
    int countoFImagestoUplaod,countoFImagesUploaded;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DamacSharedClass.sharedInstance.currentVC = self;
    [self initialiseSecondViewThirdView];
    serverAPI =[ServerAPIManager sharedinstance];
    buyersInfoArr = [[NSMutableArray alloc]init];
    [self webServicetoGetUnitSFIds];
    [FTIndicator showProgressWithMessage:@"Fetching Buyers List"];
    dropitems = [[NSMutableArray alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self roundCorners:_dropDownCountriesBtn];
    
    [self getCountriesList];
    countoFImagestoUplaod = 0;
    countoFImagesUploaded = 0;
}
-(void)roundCorners:(UIButton*)sender{
    
    sender.layer.cornerRadius = 15;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.layer.borderWidth = 2.0f;
    sender.clipsToBounds = YES;
    
}



-(void)webServicetoGetUnitSFIds{
    
    [serverAPI postRequestwithUrl:bookingsAPI withParameters:@{@"AccountId":kUserProfile.sfAccountId} successBlock:^(id responseObj) {
        if(responseObj){
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
            NSArray *idsArr = [arr valueForKey:@"Booking__c"];
            [self getBuyersInfoBasedonUnitIDS:idsArr];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
}
-(void)getBuyersInfoBasedonUnitIDS:(NSArray*)arr{
    
    for (int i = 0; i<arr.count; i++) {
        [serverAPI postRequestwithUrl:jointBuyersUrl withParameters:@{@"bookingId":arr[i]} successBlock:^(id responseObj) {
            if(responseObj){
                NSArray *myarr = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
                NSArray *arrSam = [[NSArray alloc]initWithArray:myarr];
                for (NSDictionary *dict in arrSam) {
                    [buyersInfoArr addObject:dict];
                }
                if(i == arr.count-1){
                    [self performSelectorOnMainThread:@selector(dropMenu) withObject:nil waitUntilDone:YES];
                    [FTIndicator performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
                }
            }
        } errorBlock:^(NSError *error) {
        }];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    sterView = [[StepperView alloc]initWithFrame:_stepperViewBase.frame];
    [self.view addSubview:sterView];
    _stepperViewBase.backgroundColor = [UIColor clearColor];
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}


-(void)initialiseSecondViewThirdView{
    
    
    frame2 = _firstView.frame;
    frame2.size.height = 300    ;
    frame2.origin.x = [UIScreen mainScreen].bounds.size.width+3;
    
    jbView1 = [[JointView1 alloc]initWithFrame:frame2];
    [_scrollView addSubview:jbView1];
    [jbView1.NextButton addTarget:self action:@selector(loadThirdView) forControlEvents:UIControlEventTouchUpInside];
    [jbView1.previousBtn addTarget:self action:@selector(loadFirstView) forControlEvents:UIControlEventTouchUpInside];
    
    
    frame3 = _firstView.frame;
    frame3.size.height = 380    ;
    frame3.origin.x = 2*[UIScreen mainScreen].bounds.size.width+3;

    jbView = [[JointBView2 alloc]initWithFrame:frame3];
    [_scrollView addSubview:jbView];
    [jbView.previous addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
}




-(void)dropMenu{
    
    CGRect fram = [_dropDownView convertRect:_dropDownView.bounds toView:self.view];
    _dropDownView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i<buyersInfoArr.count ; i++ ) {
        [dropitems addObject:(NSString*)[buyersInfoArr[i] valueForKey:@"First_Name__c"]];
    }
    dropNew = [[KPDropMenu alloc] initWithFrame:fram];
    dropNew.layer.cornerRadius = 10.0f;
    dropNew.layer.borderColor = [UIColor yellowColor].CGColor;
    dropNew.layer.borderWidth = 1.0f;
    dropNew.backgroundColor = [UIColor clearColor];
    dropNew.delegate = self;
    dropNew.items = dropitems;
    dropNew.title = @"Select Buyer";
    dropNew.titleColor = goldColor;
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

- (IBAction)countriesCLick:(id)sender {
     [self showpopover:_dropDownCountriesBtn];
}

- (IBAction)nextClick:(id)sender {
    [_scrollView setContentOffset:frame2.origin animated:YES];
    dropNew.hidden = YES;
    sterView.line1Animation = YES;
}
-(void)getCountriesList{
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    [server getRequestwithUrl:kgetCountriesList withParameters:nil successBlock:^(id responseObj) {
        if(responseObj){
            countriesArray = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(void)showpopover:(UIButton*)drop{

    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popVC.tvData =countriesArray;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, 600);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark popover Delegates
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

-(void)selectedFromDropMenu:(NSString *)str forType:(NSString *)type withTag:(int)tag{
    joObj.country = str;
    [_dropDownCountriesBtn setTitle:joObj.country forState:UIControlStateNormal];
    [self.tableView reloadData];
    [popoverController dismissPopoverAnimated:YES];
    
}


-(void)loadThirdView{
    [_scrollView setContentOffset:frame3.origin animated:YES];
    sterView.line2Animation = YES;
}
-(void)loadFirstView{
    [_scrollView setContentOffset:_firstView.frame.origin animated:YES];
    dropNew.hidden = NO;
    [sterView nolineColor];
}

#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    dropMenu.title = dropitems[atIntedex];
    _heightConstraint.constant = 20;
    _detailView.hidden = NO;
    [self fillLabelsforJointBuyer:atIntedex];
}
-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}
- (IBAction)selectCountryClick:(id)sender {
}

#pragma mark TableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return headingLabels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JointBuyerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jointBuyerCell" forIndexPath:indexPath];
    cell.headingLabel.text = headingLabels[indexPath.row][@"key"];
    cell.textField.text = headingLabels[indexPath.row][@"value"];
    cell.textField.delegate = self;
    cell.textField.tag = [headingLabels[indexPath.row][@"tag"] intValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(void)fillLabelsforJointBuyer:(int)indexVal{
    
    joObj = [[JointBuyerObject alloc]init];
    jbView.joObj = joObj;
    [joObj fillObjectWithDict:nil];
    [_dropDownCountriesBtn setTitle:joObj.country forState:UIControlStateNormal];
    headingLabels = @[@{@"key":@"Address1",
                       @"value":joObj.address1,
                       @"tag" : [NSNumber numberWithInt:Address1J]},
                     @{@"key":@"Address2",
                       @"value":joObj.address2,
                       @"tag" : [NSNumber numberWithInt:Address2J]},
                     @{@"key":@"Address3",
                       @"value":joObj.address3,
                       @"tag" : [NSNumber numberWithInt:Address3J]},
                     @{@"key":@"Address4",
                       @"value":joObj.address4,
                       @"tag" : [NSNumber numberWithInt:Address4J]},
                     @{@"key":@"City",
                       @"value":joObj.city,
                       @"tag" : [NSNumber numberWithInt:CityJ]},
                     @{@"key":@"State",
                       @"value":joObj.state,
                       @"tag" : [NSNumber numberWithInt:StateJ]},
                     @{@"key":@"PostalCode",
                       @"value":joObj.postalCode,
                       @"tag" : [NSNumber numberWithInt:PostalCodeJ]},
                     @{@"key":@"Email",
                       @"value":joObj.email,
                       @"tag" : [NSNumber numberWithInt:EmailJ]},
                     @{@"key":@"Mobile",
                       @"value":joObj.phone,
                       @"tag" : [NSNumber numberWithInt:MobileJ]}];
    
    [_tableView reloadData];
}
#pragma mark: Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [joObj changeValueBasedonTag:textField withValue:textField.text];
    NSLog(@"%@",joObj);
}


-(void)uploadImagesToServer{
    
    SaopServices *soap= [[SaopServices alloc]init];
    soap.delegate = self;
    if(joObj.cocdImage){
        [soap uploadDocumentTo:joObj.cocdImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:@"COCD" fileId:@"COCD" fileName:@"COCD" registrationId:nil sourceFileName:@"COCD" sourceId:@"COCD"];
        countoFImagestoUplaod++;
    }
    SaopServices *soap2 = [[SaopServices alloc]init];
    soap2.delegate = self;
    if(joObj.additionalDocumentImage){
        NSString *str = @"AdditionalDoc";
        [soap2 uploadDocumentTo:joObj.additionalDocumentImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
    SaopServices *soap3 = [[SaopServices alloc]init];
    soap3.delegate = self;
    if(joObj.primaryPassportImage){
        NSString *str = @"PassportOfBuyer";
        [soap3 uploadDocumentTo:joObj.primaryPassportImage P_REQUEST_NUMBER:nil P_REQUEST_NAME:nil P_SOURCE_SYSTEM:nil category:nil entityName:nil fileDescription:str fileId:str fileName:str registrationId:nil sourceFileName:str sourceId:str];
        countoFImagestoUplaod++;
    }
}

#pragma mark Soap Image uploaded Delegate

-(void)imageUplaodedAndReturnPath:(NSString *)path{
    NSLog(@"%@",path);
    countoFImagesUploaded ++;
    
    if ([path rangeOfString:@"COCD"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        joObj.UploadSignedChangeofDetails = path;
    }
    
    if ([path rangeOfString:@"AdditionalDoc"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        joObj.AdditionalDocFileUrl = path;
    }
    
    if ([path rangeOfString:@"PassportOfBuyer"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        joObj.PassportFileUrl = path;
    }
    
    if(countoFImagestoUplaod == countoFImagesUploaded){
//        [_cocdOBj sendDraftStatusToServer];
    }
}

@end
