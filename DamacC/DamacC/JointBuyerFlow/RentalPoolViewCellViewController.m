//
//  RentalPoolViewCellViewController.m
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "RentalPoolViewCellViewController.h"
#import "JointView1.h"

@interface RentalPoolViewCellViewController ()<KPDropMenuDelegate,WYPopoverControllerDelegate,POPDelegate>

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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseSecondViewThirdView];
    serverAPI =[ServerAPIManager sharedinstance];
    buyersInfoArr = [[NSMutableArray alloc]init];
    [self webServicetoGetUnitSFIds];
    [FTIndicator showProgressWithMessage:@"Fetching Buyers List"];
    dropitems = [[NSMutableArray alloc]init];
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
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
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
    frame3.size.height = 300    ;
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

- (IBAction)nextClick:(id)sender {
//    [_scrollView setContentOffset:frame2.origin animated:YES];
//    dropNew.hidden = YES;
//    sterView.line1Animation = YES;
    [self showpopover:dropNew];
    
}

-(void)showpopover:(KPDropMenu*)drop{
    
    PopTableViewController *popVC=[self.storyboard instantiateViewControllerWithIdentifier:@"popTableVC"];
    popVC.delegate=self;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popVC];
    popoverController.delegate = self;
    popoverController.popoverContentSize=CGSizeMake(drop.frame.size.width, 100);
    popoverController.accessibilityNavigationStyle=UIAccessibilityNavigationStyleCombined;
    [popoverController presentPopoverFromRect:drop.bounds inView:drop permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
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
}
-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}
- (IBAction)selectCountryClick:(id)sender {
}
@end
