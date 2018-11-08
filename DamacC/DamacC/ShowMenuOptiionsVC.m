//
//  ShowMenuOptiionsVC.m
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "ShowMenuOptiionsVC.h"

@interface ShowMenuOptiionsVC ()

@end

@implementation ShowMenuOptiionsVC{
    
    VCFloatingActionButton *addButton;
    CGFloat scr_width, scr_height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLabels];
}
-(void)setLabels{
    
    _img1Label1.text = [_dataArray[0] valueForKey:@"value"];
    _img1Label2.text = [_dataArray[0] valueForKey:@"key"];
    _img2Label1.text = [_dataArray[1] valueForKey:@"value"];
    _img2Label2.text = [_dataArray[1] valueForKey:@"key"];
    _img3Label1.text = [_dataArray[2] valueForKey:@"value"];
    _img3Label2.text = [_dataArray[2] valueForKey:@"key"];
    _img4Label1.text = [_dataArray[3] valueForKey:@"value"];
    _img4Label2.text = [_dataArray[3] valueForKey:@"key"];
    
    _img1Label2.adjustsFontSizeToFitWidth = YES;
    _img2Label2.adjustsFontSizeToFitWidth = YES;
    _img3Label2.adjustsFontSizeToFitWidth = YES;
    _img4Label2.adjustsFontSizeToFitWidth = YES;
    _skipButton.layer.cornerRadius = 20;
    _skipButton.clipsToBounds =YES;
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    scr_width = [UIScreen mainScreen].bounds.size.width;
    scr_height = [UIScreen mainScreen].bounds.size.height;
    

    [DamacSharedClass.sharedInstance.windowButton removeFromSuperview];
    [self loadFloatMenu];

   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    for (CustomBar *cstB in self.navigationController.view.subviews) {
        if([cstB isKindOfClass:[CustomBar class]]){
            [cstB removeFromSuperview];
        }
    }
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
-(void)loadFloatMenu{
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    addButton = [[VCFloatingActionButton alloc]initWithFrame:CGRectMake(scr_width-70, scr_height-70, 44, 44) normalImage:[UIImage imageNamed:@"floatOpen"] andPressedImage:[UIImage imageNamed:@"floatClose"] withScrollview:nil];
    //    addButton.imageArray = @[@"floatmenu1",@"floatmenu2",@"floatmenu3",@"floatmenu4",@"floatmenu5"];
    //    addButton.labelArray = @[@"Chat",@"Schedule Appointments",@"Profile",@"Dail CRM",@"Create E-Services"];
    //    addButton.imageArray = @[@"floatmenu4",@"floatmenu5",@"floatmenu2",@"floatmenu1",@"floatmenu3"];
    //    addButton.labelArray = @[@"My Profile",@"Create Requets",@"Schedule Appointments",@"Live Chat",@"Dail Customer Service"];
    addButton.imageArray = @[@"1float",@"2float",@"3float",@"4float",@"5float"];
    addButton.labelArray = @[fyCustomerSer,fyLiveChat,fyScheduleAppointments,fyCreateReq,fyProfile];
    addButton.hideWhileScrolling = YES;
    [win addSubview:addButton];
    DamacSharedClass.sharedInstance.windowButton = addButton;
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}
- (IBAction)skipButtonClick:(id)sender {
    
    MainViewController *m =[self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    addButton.delegate = m;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:m animated:YES];
    
}
@end
