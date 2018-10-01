//
//  PassportCellFooter.h
//  DamacC
//
//  Created by Gaian on 24/09/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassportCellFooter : UITableViewCell
- (IBAction)submitClick:(id)sender;
- (IBAction)saveDraftClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end
