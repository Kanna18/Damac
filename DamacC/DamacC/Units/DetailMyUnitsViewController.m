//
//  DetailMyUnitsViewController.m
//  DamacC
//
//  Created by Gaian on 06/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "DetailMyUnitsViewController.h"
#import "PrintDocView.h"
#import "BillingViewController.h"


@interface DetailMyUnitsViewController ()

@end

@implementation DetailMyUnitsViewController{
    
    CGFloat widthPercentage;
    PrintDocView *docView;
    UIView *bgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _label_project.text = @"Project\nJordan";
    _label_unitType.text = @"Unit Type\nAPPARTMENT";
    _label_bedroomtype.text = @"Bedroom Type\nSingle";
    _label_inoicesRaised.text = @"Invoices Raised\n137700";
    
    [_label_project setAdjustsFontSizeToFitWidth:YES];
    [_label_unitType setAdjustsFontSizeToFitWidth:YES];
    [_label_bedroomtype setAdjustsFontSizeToFitWidth:YES];
    [_label_inoicesRaised setAdjustsFontSizeToFitWidth:YES];
    
    [self fillLabelsWithText];
    
    [_typVCButton setTitle: _responseUnit.unitNumber forState:UIControlStateNormal];
//    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"My Units :%@",_responseUnit.unitNumber];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    widthPercentage=_percentViewPaid.frame.size.width;
    
    [UIView animateWithDuration:1 animations:^{
        [self loadPercentages:36 forView:_percentViewPaid perclbl:_label_paidPercent];
        [self loadPercentages:70 forView:_percentOverDue perclbl:_label_overDue];
        [self loadPercentages:90 forView:_percentPDCCoverage perclbl:_label_percentPDCCoverage];
        
    }];
}

-(void)loadPercentages:(int)percent
               forView:(UIView*)vw
               perclbl:(UILabel*)lbl
{
    CGRect fra = vw.frame;
    fra.size.width = (vw.frame.size.width*percent)/100;
    vw.frame = fra;
    lbl.text = [[NSString stringWithFormat:@"%d",percent] stringByAppendingString:@"%"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fillLabelsWithText{
    
    _label_project.text = [NSString stringWithFormat:@"Project City\n%@",_responseUnit.propertyCity];
    _label_unitType.text =[NSString stringWithFormat:@"Unit Type\n%@",_responseUnit.unitCategory];
    _label_bedroomtype.text = [NSString stringWithFormat:@"Bedroom Type\n%@",_responseUnit.unitType];
    _label_inoicesRaised.text = [NSString stringWithFormat:@"Invoices Raised\n%@",[self setNumberFormatter:_responseUnit.totalPaidInvoice]];
    
    _statusLabel.text = [NSString stringWithFormat:@"%@",_responseUnit.unitStatus];
    
    _priceLabel.text =  [NSString stringWithFormat:@"%@ %@",_responseUnit.projectCurrency, _responseUnit.reservationPrice];
    _outstandLabel.text =  _responseUnit.totalDueInvoice;
    _overDueLabel.text =  _responseUnit.totalOverDue;
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
    
//    if([wordNumber containsString:@"million"]){
//        return [NSString stringWithFormat:@"%0.1f Million",(float)anInt/1000000.0];
//    }
//    else if([wordNumber containsString:@"thousand"]&&(wordNumber.length > 4)){
//        return [NSString stringWithFormat:@"%0.1f K",(float)anInt/100000.0];
//    }else if([wordNumber containsString:@"thousand"]&&(wordNumber.length > 3)){
//        return [NSString stringWithFormat:@"%0.1f K",(float)anInt/10000.0];
//    }
    return wordNumber;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (IBAction)printDocumentsClick:(id)sender {
   
         [self dismissDocView];
    
    bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
        docView = [[PrintDocView alloc]initWithFrame:CGRectMake(0, 0, 300, 276)];
        [bgView addSubview:docView];
        docView.center = self.view.center;
        [docView.dismissViewBtn addTarget:self action:@selector(dismissDocView) forControlEvents:UIControlEventTouchUpInside];
}
-(void)dismissDocView{
    if(docView){
        [bgView removeFromSuperview];
        [docView removeFromSuperview];
        docView = nil;
        bgView = nil;
    }
}
- (IBAction)payNow:(id)sender{
    BillingViewController *bvc = [self.storyboard instantiateViewControllerWithIdentifier:@"billVC"];
    [self.navigationController pushViewController:bvc animated:YES];
}
- (IBAction)moreDetailsClick:(id)sender {
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
@end
