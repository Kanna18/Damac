//
//  POPViewController.m
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "POPViewController.h"
#import "PopCell1.h"
#import "PopCell2.h"
#import "PopCell3.h"

@interface POPViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation POPViewController{
    
    StepperView *sterView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
//    [_collectionView registerClass:[PopCell1 class] forCellWithReuseIdentifier:@"popCell1"];
//    [_collectionView registerClass:[PopCell2 class] forCellWithReuseIdentifier:@"popCell2"];
//    [_collectionView registerClass:[PopCell3 class] forCellWithReuseIdentifier:@"popCell3"];
    self.collectionView.scrollEnabled = NO;
    
    _popObj = [[popObject alloc]init];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    sterView = [[StepperView alloc]initWithFrame:_stepperbaseView.frame];
    [self.view addSubview:sterView];
    [self performSelector:@selector(hideWindowButton) withObject:nil afterDelay:0.2];
}

-(void)hideWindowButton{
    DamacSharedClass.sharedInstance.windowButton.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        PopCell1 *pCell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"popCell1" forIndexPath:indexPath];
        [pCell1.buttonnext addTarget:self action:@selector(moveTosecondCell) forControlEvents:UIControlEventTouchUpInside];
        pCell1.popObj = _popObj;
        return pCell1;
    }
    if(indexPath.row==1){
        PopCell2 *pCell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"popCell2" forIndexPath:indexPath];
//        [pCell2.buttonNext addTarget:self action:@selector(moveToThirdCell) forControlEvents:UIControlEventTouchUpInside];
        pCell2.popObj = _popObj;
        return pCell2;
    }
    if(indexPath.row==2){
        PopCell3 *pCell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"popCell3" forIndexPath:indexPath];
        pCell3.popObj = _popObj;
        return pCell3;
    }
    
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  CGSizeMake(collectionView.frame.size.width ,collectionView.frame.size.height);
}
-(void)moveTosecondCell{
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}
-(void)moveToThirdCell{
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
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
