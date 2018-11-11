//
//  SurveyController.m
//  DamacC
//
//  Created by Gaian on 27/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyController.h"
#import "SurveyViewController.h"

@interface SurveyController (){
    
    NSMutableArray *surverArray;
}

@end

@implementation SurveyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameLabel.text = [NSString stringWithFormat:@"Dear %@",kUserProfile.partyName];
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
    [self getResponseFromTheServer];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Customer satisfaction survey"];
}
-(void)getResponseFromTheServer{
    ServerAPIManager *apiMa = [ServerAPIManager sharedinstance];
    
    [apiMa postRequestWithOutDict:@"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/Customer/services/apexrest/surveyQuestions/" withParameters:nil successBlock:^(id responseObj) {
        if(responseObj){
            surverArray = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _surverFirstView.hidden = YES;
            });            
        }

    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)taketheSurveyClick:(id)sender {
    if(surverArray.count>0){
        SurveyViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"surveyViewController"];
        cvc.surveyArray = surverArray;
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
@end
