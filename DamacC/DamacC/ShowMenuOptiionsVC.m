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

@implementation ShowMenuOptiionsVC

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
    
    _skipButton.layer.cornerRadius = 20;
    _skipButton.clipsToBounds =YES;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationItem.hidesBackButton = YES;
    DamacSharedClass.sharedInstance.windowButton.hidden =YES;
    
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

- (IBAction)skipButtonClick:(id)sender {
    
    MainViewController *m =[self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    [self.navigationController pushViewController:m animated:YES];
}
@end
