//
//  PassportUpdateVC.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaopServices.h"
#import "PassportObject.h"
@interface PassportUpdateVC : UIViewController<KPDropMenuDelegate,SoapImageuploaded>
@property (weak, nonatomic) IBOutlet KPDropMenu *dropBaseView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buyersButton;
@property PassportObject *passportObj;
- (IBAction)buyersClick:(id)sender;
@property SaopServices *soap;
@property SaopServices *soap2;
@end
