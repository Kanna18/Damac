//
//  RentalPoolViewCellViewController.m
//  DamacC
//
//  Created by Gaian on 04/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "RentalPoolViewCellViewController.h"
#import "JointView1.h"

@interface RentalPoolViewCellViewController ()<KPDropMenuDelegate>

@end

@implementation RentalPoolViewCellViewController{
    
    NSArray *dropItems;
    KPDropMenu *dropNew;
    StepperView *sterView;
    JointBView2 *jbView ;
    JointView1 *jbView1;
    CGRect frame2 , frame3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseSecondViewThirdView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
     [self dropMenu];
    sterView = [[StepperView alloc]initWithFrame:_stepperViewBase.frame];
    [self.view addSubview:sterView];
    _stepperViewBase.backgroundColor = [UIColor clearColor];
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
    dropItems = @[@"Apple", @"Grapes", @"Cherry", @"Pineapple", @"Mango", @"Orange"];
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
    dropNew.titleTextAlignment = NSTextAlignmentCenter;
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
    [_scrollView setContentOffset:frame2.origin animated:YES];
    dropNew.hidden = YES;
    sterView.line1Animation = YES;
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
    dropMenu.title = dropItems[atIntedex];
}
-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}
@end
