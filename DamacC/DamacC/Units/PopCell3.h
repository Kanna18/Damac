//
//  PopCell3.h
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PopCell3 : UICollectionViewCell<ImagePickedProtocol>
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (weak, nonatomic) IBOutlet UIButton *buttonDocument;
- (IBAction)uploadProofClick1:(id)sender;
- (IBAction)uploadProofClick2:(id)sender;

- (IBAction)submitClick:(id)sender;
- (IBAction)atatchDocClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *uploadDocLabel;

@property (weak, nonatomic) IBOutlet UILabel *otherDocLAbel;
@property popObject *popObj;

@property SaopServices *soap,*soap2;
@end
