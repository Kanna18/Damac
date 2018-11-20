//
//  SurveyViewController.m
//  DamacC
//
//  Created by Gaian on 15/10/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "SurveyViewController.h"
#import "SurveyCell1.h"
#import "SurveyCell2.h"
#import "SurveyCell3.h"
#import "SurveyCell4.h"
#import "SurveyCell5.h"
#import "SurveyCell6.h"
@interface SurveyViewController ()

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //    [_collectionView registerClass:[PopCell1 class] forCellWithReuseIdentifier:@"popCell1"];
    //    [_collectionView registerClass:[PopCell2 class] forCellWithReuseIdentifier:@"popCell2"];
    //    [_collectionView registerClass:[PopCell3 class] forCellWithReuseIdentifier:@"popCell3"];
//    self.collectionView.scrollEnabled = NO;
    _collectionView.scrollEnabled = NO;
    
    _btn1.tag =0;
    _btn2.tag =1;
    _btn3.tag =2;
    _btn4.tag =3;
    _btn5.tag =4;
    _btn6.tag =5;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    }
    
}

-(void)setProgressBar:(NSIndexPath*)indexp{

    for (UIButton *btn  in _stackView.subviews) {
        if([btn isKindOfClass:[UIButton class]]){
            if(btn.tag == indexp.row){
                btn.backgroundColor = goldColor;
            }else{
                btn.backgroundColor =rgb(47, 47, 47);
            }
        }
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DamacSharedClass.sharedInstance.currentVC = self;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row==0){
        SurveyCell1 *pCell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell1" forIndexPath:indexPath];
        pCell1.parentCollectionView = _collectionView;
        pCell1.surveyArray = _surveyArray;        
        return pCell1;
    }
    if(indexPath.row==1){
        SurveyCell2 *pCell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell2" forIndexPath:indexPath];
        pCell2.parentCollectionView = _collectionView;
        pCell2.surveyArray = _surveyArray;
        return pCell2;
    }
    if(indexPath.row==2){
        SurveyCell3 *pCell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell3" forIndexPath:indexPath];
        pCell3.parentCollectionView = _collectionView;
        pCell3.surveyArray = _surveyArray;
        return pCell3;
    }
    if(indexPath.row==3){
        SurveyCell4 *pCell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell4" forIndexPath:indexPath];
        pCell4.parentCollectionView = _collectionView;
        pCell4.surveyArray = _surveyArray;
        return pCell4;
    }
    if(indexPath.row==4){
        SurveyCell5 *pCell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell5" forIndexPath:indexPath];
        pCell5.parentCollectionView = _collectionView;
        pCell5.surveyArray = _surveyArray;
        return pCell5;
    }
    if(indexPath.row==5){
        SurveyCell6 *pCell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell6" forIndexPath:indexPath];
        pCell6.parentCollectionView = _collectionView;
        pCell6.surveyArray = _surveyArray;
        return pCell6;
    }
    
    return nil;
}
-(void)adjustImageEdgeInsetsOfButton:(UIButton*)sender{
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.frame.size.width-30-sender.titleLabel.intrinsicContentSize.width, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    [self setProgressBar:indexPath];
//    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
//    if(indexPath.row==0){
//        SurveyCell2 *cell = (SurveyCell2*)[collectionView cellForItemAtIndexPath:path];
//        cell = nil;
//    }
//    if(indexPath.row==1){
//        SurveyCell3 *cell = (SurveyCell3*)[collectionView cellForItemAtIndexPath:path];
//        cell = nil;
//    }
//    if(indexPath.row==2){
//        SurveyCell4 *cell = (SurveyCell4*)[collectionView cellForItemAtIndexPath:path];
//        cell = nil;
//    }
//    if(indexPath.row==3){
//        SurveyCell5 *cell = (SurveyCell5*)[collectionView cellForItemAtIndexPath:path];
//        cell = nil;
//    }
//    if(indexPath.row==4){
//        SurveyCell6 *cell = (SurveyCell6*)[collectionView cellForItemAtIndexPath:path];
//        cell = nil;
//    }
//    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  CGSizeMake(collectionView.frame.size.width ,collectionView.frame.size.height);
}
-(void)moveTonextCell:(NSIndexPath*)indexpath{
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexpath.row inSection:indexpath.section];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Highlighting CollectionView CEll");
    return NO;
}
@end
