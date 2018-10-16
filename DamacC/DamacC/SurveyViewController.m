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
        return pCell1;
    }
    if(indexPath.row==1){
        SurveyCell2 *pCell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell2" forIndexPath:indexPath];
        return pCell2;
    }
    if(indexPath.row==2){
        SurveyCell3 *pCell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell3" forIndexPath:indexPath];
        return pCell3;
    }
    if(indexPath.row==3){
        SurveyCell4 *pCell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell4" forIndexPath:indexPath];
        return pCell4;
    }
    if(indexPath.row==4){
        SurveyCell5 *pCell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell5" forIndexPath:indexPath];
        return pCell5;
    }
    if(indexPath.row==5){
        SurveyCell6 *pCell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"surveyCell6" forIndexPath:indexPath];
        return pCell6;
    }
    
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  CGSizeMake(collectionView.frame.size.width ,collectionView.frame.size.height);
}
-(void)moveTonextCell:(NSIndexPath*)indexpath{
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexpath.row inSection:indexpath.section];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

@end
