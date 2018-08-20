//
//  EServicesViewController.m
//  DamacC
//
//  Created by Gaian on 17/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "EServicesViewController.h"
#import "POPViewController.h"

@interface EServicesViewController ()

@end

@implementation EServicesViewController{
    
    NSArray *gridArray,*imgsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.topItem.title = _typOfVC;
    imgsArr = @[@"1ser",@"2ser",@"3ser",@"4ser",@"5ser",@"6ser",@"7ser",@"8ser"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

#pragma mark collection View Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrayOflist.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"gridCell";
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.headingLabel.text = gridArray[indexPath.row];
    cell.headingLabel.text = _arrayOflist[indexPath.row];
    cell.thumbNail.image = [UIImage imageNamed:imgsArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if(collectionView == _gridCollectionView){
//        GridCollectionViewCell *cell = (GridCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//        NSString *str = cell.headingLabel.text;
//        if([str isEqualToString:kCod]||[str isEqualToString:kJointBuyerInfo]||[str isEqualToString:kPassportUpdate]){
//            MyServiceRequestViewController *evc =[ self.storyboard instantiateViewControllerWithIdentifier:@"myServicesRequestVC"];
//            evc.typeoFVC = kloadingFromCreateServices;
//            [self.navigationController pushViewController:evc animated:YES];
//        }
//        [self pushToCollection:str];
//    }
    switch (indexPath.row) {
        case 0:
            [self loadChangeOfContactDetails];
            break;
        case 1:
            [self loadPassportUpdate];
            break;
        case 2:
            [self loadJointBuyerinfo];
            break;
        case 3:
            [self loadPOP];
            break;
        case 4:
            [self loadAppointments];
            break;
        case 5:
            [self loadComplaints];
            break;
            
        default:
            break;
    }
}

-(void)pushToCollection:(NSString*)type{
    
//    if([type isEqualToString:kpersonalDetails]||[type isEqualToString:kAppointments])
//    {
//        EServicesViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"eservicesVC"];
//        svc.typOfVC = type;
//        if([type isEqualToString:kpersonalDetails]){
//            svc.arrayOflist = personalDetailsArray;
//        }if([type isEqualToString:kAppointments]){
//            svc.arrayOflist = appointmentsArray;
//        }
//        [self.navigationController pushViewController:svc animated:YES];
//    }
//    if([type isEqualToString:kchangeofPrimarycontactdetails]||[type isEqualToString:kcahngeofNameNationality]||[type isEqualToString:kpassportUpdate]){
//        ChangeofDetailsViewController *chang = [self.storyboard instantiateViewControllerWithIdentifier:@"changeofDetailsVC"];
//        [self.navigationController pushViewController:chang animated:YES];
//    }if([type isEqualToString:kchangeofJointBuyerDetails]){
//
//        RentalPoolViewCellViewController *rental = [self.storyboard instantiateViewControllerWithIdentifier:@"rentalPoolViewCellVC"];
//        [self.navigationController pushViewController:rental animated:YES];
//    }
//
}
-(void)loadChangeOfContactDetails{
    ChangeOfContactDetails *chd = [self.storyboard instantiateViewControllerWithIdentifier:@"changeOfContactsVC"];
    [self.navigationController pushViewController:chd animated:YES];
}
-(void)loadPassportUpdate{
    
}
-(void)loadJointBuyerinfo{
    
    RentalPoolViewCellViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"rentalPoolViewCellVC"];
    [self.navigationController pushViewController:rvc animated:YES];
    
}
-(void)loadPOP{    
    POPViewController *pop = [self.storyboard instantiateViewControllerWithIdentifier:@"popVC"];
    [self.navigationController pushViewController:pop animated:YES];
    
}
-(void)loadAppointments{
    
}
-(void)loadComplaints{
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if(collectionView == _gridCollectionView){
//        if(_arrayOflist.count>2){
//            return  CGSizeMake(collectionView.frame.size.width/2-5, 300);
//        }else{
//            return  CGSizeMake(collectionView.frame.size.width, 200);
//        }
//    }
//    return  CGSizeZero;
    return CGSizeMake(collectionView.frame.size.width/2-5, 250);
}



@end
