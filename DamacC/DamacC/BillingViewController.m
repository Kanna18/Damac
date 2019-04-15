//
//  BillingViewController.m
//  DamacC
//
//  Created by Gaian on 03/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ViewControllerCell.h"
#import "BillingViewController.h"
#import "ViewControllerCellHeader.h"
#import "BillingObject.h"
#import <CCAvenueSDK/CCAvenuePaymentController.h>

#define coun 2

@interface BillingViewController ()<UITextFieldDelegate>

@end

@implementation BillingViewController{
    IBOutlet UITableView *tblView;
    NSMutableArray *arrSelectedSectionIndex;
    BOOL isMultipleExpansionAllowed;
    int isFilterExpanded;
    NSArray *headerArr;
    NSArray *sideLabelsArray, *addArr;
    UserDetailsModel *udm;
    
    COCDTF *currentTF;
    BillingObject *billObj;
    NSString *showAddressBool, *ccavenueBool;
    CCAvenuePaymentController *paymentController;
    NSMutableDictionary *finalResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isMultipleExpansionAllowed = NO;
    ccavenueBool = @"N";
    showAddressBool = @"N";
    arrSelectedSectionIndex = [[NSMutableArray alloc] init];
    if (!isMultipleExpansionAllowed) {
        [arrSelectedSectionIndex addObject:[NSNumber numberWithInt:coun+2]];
    }
    headerArr = @[@"BILLING ADDRESS",@"SHIPPING ADDRESS"];
    sideLabelsArray = @[@"Name",@"Address",@"City",@"Country",@"State",@"Telephone",@"Email Id"];
    
    udm = [DamacSharedClass sharedInstance].userProileModel;
    
    if(udm){
        NSString *name;
        if(udm.partyName){
            name = handleNull(udm.partyName);
        }else{
            name = handleNull(udm.organizationName);
        }
        addArr= @[name,handleNull(udm.addressLine1),
                  handleNull(udm.city),
                  handleNull(udm.countryOfResidence),
                  handleNull(udm.state),
                  [NSString stringWithFormat:@"%@%@",handleNull(udm.phoneCountry),handleNull(udm.phoneNumber)],
                  handleNull(udm.emailAddress)];
    }
    
    tblView.alwaysBounceVertical = NO;
    isFilterExpanded = _heightConstraint.constant;
    
//    _proceedBtn.titleLabel.textColor = rgb(174, 134, 73);
//    _proceedBtn.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:10];
    
    billObj = [[BillingObject alloc]init];
    [billObj setDefaultValues:addArr];
    _outStandingTF.delegate = self;
    
    if(_dueAmount.intValue>50000){
        _outStandingTF.text = @"50000";
    }else{
        _outStandingTF.text = _dueAmount;
    }
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    [[CustomBarOptions alloc]initWithNavItems:self.navigationItem noOfItems:2 navRef:self.navigationController withTitle:@"Pay now"];
//    [self roundCorners:_showAddressBtn];
//    [self roundCorners:_ccavenueBtn];
    [self roundCornersTF:_outStandingTF];
    DamacSharedClass.sharedInstance.currentVC = self;
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Pay Now"];
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}

-(void)roundCorners:(UIButton*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = goldColor.CGColor;
    sender.clipsToBounds = YES;
}
-(void)roundCornersTF:(UITextField*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = goldColor.CGColor;
    sender.clipsToBounds = YES;
}
#pragma mark - TableView methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return coun;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        return sideLabelsArray.count;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v =[[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor blackColor];
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    if (cell ==nil)
    {
        [tblView registerClass:[ViewControllerCell class] forCellReuseIdentifier:@"ViewControllerCell"];
        cell = [tblView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    }
    cell.lblName.text = sideLabelsArray[indexPath.row];//[NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.textField.delegate = self;
    cell.textField.tfIndexPath = indexPath;
    cell.textField.text = addArr[indexPath.row];
    [self fillBillObj:indexPath withValue:addArr[indexPath.row]];
//    cell.backgroundColor = indexPath.row%2==0?[UIColor lightTextColor]:[[UIColor lightTextColor] colorWithAlphaComponent:0.5f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ViewControllerCellHeader *headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    if (headerView ==nil)
    {
        [tblView registerClass:[ViewControllerCellHeader class] forCellReuseIdentifier:@"ViewControllerCellHeader"];
        headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];        
    }
    headerView.lbTitle.text = [NSString stringWithFormat:@"  %@",headerArr[section]];//[NSString stringWithFormat:@"Section %ld", (long)section];
    
    headerView.buttonBackground.layer.cornerRadius = 10.0f;
    headerView.buttonBackground.layer.borderWidth = 2.0f;
    headerView.buttonBackground.layer.borderColor = rgb(174, 134, 73).CGColor;
    headerView.buttonBackground.clipsToBounds = YES;

//    headerView.lbTitle.textColor = rgb(174, 134, 73);
//    headerView.lbTitle.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16];
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        headerView.btnShowHide.selected = YES;
    }
    [[headerView btnShowHide] setTag:section];
    [[headerView btnShowHide] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];
//    [headerView.contentView setBackgroundColor:section%2==0?[UIColor groupTableViewBackgroundColor]:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5f]];
    return headerView.contentView;
}

-(IBAction)btnTapShowHideSection:(UIButton*)sender
{
//    isFilterExpanded = (int)sender.tag;
    if (!sender.selected)
    {
        if (!isMultipleExpansionAllowed) {
            if(arrSelectedSectionIndex.count==0){
                [arrSelectedSectionIndex addObject:[NSNumber numberWithInt:2]];
            }
            [arrSelectedSectionIndex replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:sender.tag]];
        }else {
            [arrSelectedSectionIndex addObject:[NSNumber numberWithInteger:sender.tag]];
        }
        sender.selected = YES;
        [self adjustHeightOfTheTableView:7];
        
    }else{
        sender.selected = NO;
        if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:sender.tag]])
        {
            [arrSelectedSectionIndex removeObject:[NSNumber numberWithInteger:sender.tag]];
        }
        [self adjustHeightOfTheTableView:0];
    }
    if (!isMultipleExpansionAllowed) {
        [tblView reloadData];
    }else {
        [tblView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)adjustHeightOfTheTableView:(int)numbe{
    _heightConstraint.constant = numbe * 50  + isFilterExpanded;
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
#pragma Mark TextField Delegates
-(BOOL)textFieldShouldBeginEditing:(COCDTF *)textField{
    currentTF = textField;            
    return YES;
}
-(void)textFieldDidEndEditing:(COCDTF *)textField{
    
}
-(BOOL)textFieldShouldReturn:(COCDTF *)textField{
    [textField resignFirstResponder];
    [self fillBillObj:textField.tfIndexPath withValue:textField.text];
    return YES;
}


- (IBAction)showAddressClick:(id)sender {
    
    if([showAddressBool isEqualToString:@"N"]){
        showAddressBool = @"Y";
        _showAddressBtn.selected = YES;
    }else{
        showAddressBool = @"N";
        _showAddressBtn.selected = NO;
    }
}



- (IBAction)ccavenueClick:(id)sender {
    
    if([ccavenueBool isEqualToString:@"N"]){
        ccavenueBool = @"Y";
        _ccavenueBtn.selected = YES;
    }else{
        ccavenueBool = @"N";
        _ccavenueBtn.selected = NO;
    }
}


-(void)fillBillObj:(NSIndexPath*)indexPath withValue:(NSString*)str{
    
    NSLog(@"----%ld %ld--- %@",(long)indexPath.row,(long)indexPath.section,str);
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0){
            billObj.billName = str;
        }
        if(indexPath.row == 1){
            billObj.billAddress = str;
        }
        if(indexPath.row == 2){
            billObj.billCity = str;
        }
        if(indexPath.row == 3){
            billObj.billCountry = str;
        }
        if(indexPath.row == 4){
            billObj.billState = str;
        }
        if(indexPath.row == 5){
            billObj.billTelephone = str;
        }
        if(indexPath.row == 6){
            billObj.billemailID = str;
        }
        
    }
    if(indexPath.section == 1)
    {
        if(indexPath.row == 0){
            billObj.shipName = str;
        }
        if(indexPath.row == 1){
            billObj.shipAddress = str;
        }
        if(indexPath.row == 2){
            billObj.shipCity = str;
        }
        if(indexPath.row == 3){
            billObj.shipCountry = str;
        }
        if(indexPath.row == 4){
            billObj.shipState = str;
        }
        if(indexPath.row == 5){
            billObj.shipTelephone = str;
        }
        if(indexPath.row == 6){
            billObj.shipemailID = str;
        }
    }
}

- (IBAction)proceedClick:(id)sender {
    
    
   
//    CCAvenuePaymentController *initial;
    paymentController = [[CCAvenuePaymentController alloc]initWithOrderId:[NSString stringWithFormat:@"%u",((arc4random() % 9999999) + 1)]
                                                               merchantId:@"43551"
                                                               accessCode:@"AVRS02EJ65AY00SRYA"
                                                                   custId:@"saurabh"
                                                                   amount:_outStandingTF.text//_dueAmount
                                                                 currency:@"AED"
                                                                rsaKeyUrl:BillingGetRSA
                                                              redirectUrl:BillingResponseHandler
                                                                cancelUrl:BillingResponseHandler
                                                              showAddress:showAddressBool billingName:billObj.billName billingAddress:billObj.billAddress billingCity:billObj.billCity billingState:billObj.billState billingCountry:billObj.billCountry billingTel:billObj.billTelephone billingEmail:billObj.billemailID deliveryName:billObj.shipName deliveryAddress:billObj.shipAddress deliveryCity:billObj.shipCity deliveryState:billObj.shipState deliveryCountry:billObj.shipCountry deliveryTel:billObj.shipTelephone promoCode:@"" merchant_param1:@"" merchant_param2:@"" merchant_param3:@"" merchant_param4:@"" merchant_param5:@"" useCCPromo:@""];

    //paymentController = [[CCAvenuePaymentController alloc]initWithOrderId:[NSString stringWithFormat:@"%u",((arc4random() % 9999999) + 1)] merchantId:self.merchantIdTF.text accessCode:self.accessCodeTF.text custId:self.custIdTF.text amount:self.amountTF.text currency:self.currencyTF.text rsaKeyUrl:self.rsaKeyUrlTF.text redirectUrl:self.redirectUrlTF.text cancelUrl:self.cancelUrlTF.text showAddress:showAdd billingName:self.billingNameTF.text billingAddress:self.billingAddTF.text billingCity:self.billingCityTF.text billingState:self.billingStateTF.text billingCountry:self.billingCountryTF.text billingTel:self.billingTelTF.text billingEmail:self.billingEmailTF.text deliveryName:self.deliveryNameTF.text deliveryAddress:self.deliveryAddTF.text deliveryCity:self.deliveryCityTF.text deliveryState:self.deliveryStateTF.text deliveryCountry:self.deliveryCountryTF.text deliveryTel:self.deliveryTelTF.text];

    paymentController.delegate = self;
//
    [self presentViewController:paymentController animated:true completion:nil];
    
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"Paynow_Proceed Button"],
                                     kFIRParameterItemName:@"Paynow_Proceed Button",
                                     kFIRParameterContentType:@"Button Clicks"
                                     }];
    [FIRAnalytics setScreenName:@"Billing" screenClass:NSStringFromClass([self class])];
}


-(void)getResponse:(NSMutableDictionary *)responseDict_
{
    paymentController.delegate = nil;
    
    finalResult = [[NSMutableDictionary alloc]init];
    finalResult = responseDict_;
    
    [self openEnd];
}

-(void)openEnd
{
    NSString *msg = [NSString stringWithFormat:@"Your order # %@ is %@\n\nPayment Reference Number : %@\n\nYou may use this number for any future communications.",[finalResult valueForKey:@"order_id"], [finalResult valueForKey:@"order_status"], [finalResult valueForKey:@"tracking_id"]];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Payment Status"
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Done"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   [self closeMe];
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)closeMe
{
    [self performSelectorOnMainThread:@selector(popToMainVC) withObject:nil waitUntilDone:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)popToMainVC{
    
    NSArray *arr = DamacSharedClass.sharedInstance.currentVC.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if([vc isKindOfClass:[MainViewController class]]){
            [DamacSharedClass.sharedInstance.currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}

@end

