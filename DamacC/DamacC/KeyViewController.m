//
//  KeyViewController.m
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "KeyViewController.h"
#import "LoadingLogoVC.h"
@interface KeyViewController ()

@end

@implementation KeyViewController{
    PinView *mpin, *confirmPin;
    CGFloat screen_width, screen_height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.barTintColor = rgb(230, 193, 0);
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = rgb(174, 134, 73);
    UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, 1)];
    vw.backgroundColor = rgb(174, 134, 73);
    [self.navigationController.navigationBar addSubview:vw];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(compareMpin) name:MPIN_ENTERED_NOTIFICATION object:nil];
    screen_width = [UIScreen mainScreen].bounds.size.width;
    screen_height = [UIScreen mainScreen].bounds.size.height;
    [self loadPinViews];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPIN_ENTERED_NOTIFICATION object:nil];
}


-(void)compareMpin{
    NSString *str = [defaultGet(kenterMpin) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *s = [defaultGet(kMPin) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([str isEqualToString: s]){
//        MainViewController *m =[self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
//        [self.navigationController pushViewController:m animated:YES];
        
        LoadingLogoVC *lc = [self.storyboard instantiateViewControllerWithIdentifier:@"loadingLogoVC"];
        [self.navigationController pushViewController:lc animated:YES];        
    }else{
        [FTIndicator showToastMessage:@"MPIN is not correct"];
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPinViews{
//    288
//    120
    mpin =[[PinView alloc]initWithFrame:CGRectMake(screen_width/2-144, screen_height/2-120, 0, 0)];
    mpin.type = kenterMpin;
    mpin.pinheadingLabel.text = @"ENTER MPIN";
    [self.view addSubview:mpin];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
