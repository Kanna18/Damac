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
    
    NSString *name;
    if(kUserProfile.partyName){
        name = handleNull(kUserProfile.partyName);
    }else{
        name = handleNull(kUserProfile.organizationName);
    }
    _nameLabel.text = [NSString stringWithFormat:@"Dear %@",handleNull(name)];
    [self getResponseFromTheServer];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    [DamacSharedClass.sharedInstance.navigationCustomBar setPageTite:@"Customer satisfaction survey"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}

-(void)getResponseFromTheServer{
    ServerAPIManager *apiMa = [ServerAPIManager sharedinstance];
    
    [apiMa postRequestWithOutDict:surveyQuestionsUrl withParameters:nil successBlock:^(id responseObj) {
        if(responseObj){
            surverArray = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    _surverFirstView.hidden = YES;
                });
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
        [FIRAnalytics logEventWithName:kFIREventSelectContent
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"Survey_Start Survey"],
                                         kFIRParameterItemName:@"Survey_Start Survey",
                                         kFIRParameterContentType:@"Button Clicks"
                                         }];
        
        SurveyViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"surveyViewController"];
        cvc.surveyArray = surverArray;
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
@end
