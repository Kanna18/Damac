//
//  LoadingLogoVC.m
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "LoadingLogoVC.h"
#import "ShowMenuOptiionsVC.h"

@interface LoadingLogoVC ()

@end

@implementation LoadingLogoVC{
    
    NSMutableArray *topCVArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    topCVArray = [[NSMutableArray alloc]init];
    [self serverCall];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)serverCall{
    ServerAPIManager *server = [ServerAPIManager sharedinstance];
    SFUserAccountManager *sf = [SFUserAccountManager sharedInstance];
    NSString * url = [NSString stringWithFormat:@"%@%@",maiUrl,[sf.currentUserIdentity valueForKeyPath:@"userId"]];
    [server getRequestwithUrl:url successBlock:^(id responseObj) {        
        [DamacSharedClass sharedInstance].firstDataObject = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        NSLog(@"User Profile Model -- %@",[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil]);
        [self setTopArrayData:[DamacSharedClass sharedInstance].firstDataObject];
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);

    }];
}


-(void)setTopArrayData:(NSDictionary*)dic{
    if(dic&&dic[@"responseLines"][0]){
        NSDictionary *di = dic[@"responseLines"][0];
        kUserProfile = [[UserDetailsModel alloc]initWithDictionary:dic[@"responseLines"][0] error:nil];
        
        NSString * port = kUserProfile.overallPortfolio;//[NSString stringWithFormat:@"%@",di[@"overallPortfolio"]];
        NSString * curent = kUserProfile.currentPortfolio;//[NSString stringWithFormat:@"%@",di[@"currentPortfolio"]];
        
        port = [self setNumberFormatter:port];
        curent = [self setNumberFormatter:curent];
        
        [self setNumberFormatter:port];
        [self setNumberFormatter:curent];
        [topCVArray addObject:@{@"key":overallPortofolio,@"value":port,@"image":@"1icon",}];
        [topCVArray addObject:@{@"key":currentPortofolio,@"value":curent,@"image":@"2icon",}];
        [topCVArray addObject:@{@"key":paymentsDue,@"value":@"",@"image":@"3icon",}];
        [topCVArray addObject:@{@"key":openServiceRequests,@"value":kUserProfile.openCases,@"image":@"4icon"}];
        //        [self.carousel performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(pustToVC) withObject:nil waitUntilDone:YES];
    }else{
        [topCVArray addObject:@{@"key":overallPortofolio,@"value":@"",@"image":@"1icon",}];
        [topCVArray addObject:@{@"key":currentPortofolio,@"value":@"",@"image":@"2icon",}];
        [topCVArray addObject:@{@"key":paymentsDue,@"value":@"0",@"image":@"3icon",}];
        [topCVArray addObject:@{@"key":openServiceRequests,@"value":@"",@"image":@"4icon"}];
        [self performSelectorOnMainThread:@selector(pustToVC) withObject:nil waitUntilDone:YES];
    }
    [self bgndTasks];
}
-(void)bgndTasks{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        BackgroundRequests *req = [[BackgroundRequests alloc]init];
//        [req getSfiDSList];
//    });
}

-(void)pustToVC{
    ShowMenuOptiionsVC *sw = [self.storyboard instantiateViewControllerWithIdentifier:@"showMenuOptiionsVC"];
    sw.dataArray = topCVArray;
    [self.navigationController pushViewController:sw animated:YES];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
    
}
-(NSString*)setNumberFormatter:(NSString*)numberStr{
    NSInteger anInt = numberStr.integerValue;
    NSString *wordNumber;
    
    //convert to words
    NSNumber *numberValue = [NSNumber numberWithInt:anInt]; //needs to be NSNumber!
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    wordNumber = [numberFormatter stringFromNumber:numberValue];
    NSLog(@"Answer: %@", wordNumber);
    if([wordNumber containsString:@"million"]){
        return [NSString stringWithFormat:@"%c.%c Million",[numberStr characterAtIndex:0],[numberStr characterAtIndex:1]];
    }
    else if([wordNumber containsString:@"thousand"]&&(wordNumber.length > 4)){
        return [NSString stringWithFormat:@"%c%c K",[numberStr characterAtIndex:0],[numberStr characterAtIndex:1]];
    }else if([wordNumber containsString:@"thousand"]&&(wordNumber.length > 3)){
        return [NSString stringWithFormat:@"%c.%c K",[numberStr characterAtIndex:0],[numberStr characterAtIndex:1]];
    }
    return numberStr;
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
