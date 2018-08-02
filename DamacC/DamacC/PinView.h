//
//  PinView.h
//  DamacC
//
//  Created by Gaian on 29/04/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *pinheadingLabel;
@property (weak, nonatomic) IBOutlet UITextField *pin_tf1;
@property (weak, nonatomic) IBOutlet UITextField *pin_tf2;
@property (weak, nonatomic) IBOutlet UITextField *pin_tf3;
@property (weak, nonatomic) IBOutlet UITextField *pin_tf4;


@property (nonatomic, strong) NSString *type;
@end
