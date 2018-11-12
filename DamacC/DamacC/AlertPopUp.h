//
//  AlertPopUp.h
//  DamacC
//
//  Created by Gaian on 12/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN




@interface AlertPopUp : UIView
-(instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
- (IBAction)closeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *saveDraftView;
- (IBAction)okClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionlabel;

@property (nonatomic, strong) void (^okHandler)(void);
@property (nonatomic, strong) void (^cancelHandler)(void);





//@property (nonatomic,copy) okBlock okHandler;
//@property (nonatomic,copy) cancelBlock cancelHandler;
//
//-(void)alertViewWithTitle:(NSString*)title descriptionMsg:(NSString*)descrp okClick:(okBlock)ok cancelClick:(cancelBlock)cancel;

@end

NS_ASSUME_NONNULL_END
