//
//  UnitsHeaderView.h
//  DamacC
//
//  Created by Gaian on 07/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitsHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
- (IBAction)buttonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@end
