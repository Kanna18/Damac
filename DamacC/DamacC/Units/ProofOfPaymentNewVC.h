//
//  ProofOfPaymentNewVC.h
//  DamacC
//
//  Created by Gaian on 05/11/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProofOfPaymentNewVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WSCalendarViewDelegate,WYPopoverControllerDelegate,POPDelegate,ImagePickedProtocol>
@property popObject *popObj;

@property (weak, nonatomic) IBOutlet UIButton *buttonUnits;
- (IBAction)UnitsClick:(id)sender;
- (IBAction)getUnitsDetailClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *selectPaymentModeBtn;
- (IBAction)selectPaymentClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *getUnitsButtonDetail;


@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (weak, nonatomic) IBOutlet UIButton *buttonDocument;
- (IBAction)uploadProofClick1:(id)sender;
- (IBAction)uploadProofClick2:(id)sender;

- (IBAction)submitClick:(id)sender;
- (IBAction)atatchDocClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *uploadDocLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherDocLAbel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property SaopServices *soap,*soap2;

@property (weak, nonatomic) IBOutlet UIView *attachDocsBaseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attachDocsViewHeighgt;
@property (weak, nonatomic) IBOutlet UIButton *attach1Btn;
@property (weak, nonatomic) IBOutlet UIButton *attach2Btn;
- (IBAction)attach1Click:(id)sender;
- (IBAction)attach2Click:(id)sender;


@end

NS_ASSUME_NONNULL_END
