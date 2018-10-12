//
//  PopCell3.h
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopCell3 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (weak, nonatomic) IBOutlet UIButton *buttonDocument;
- (IBAction)uploadProofClick1:(id)sender;
- (IBAction)uploadProofClick2:(id)sender;
@property popObject *popObj;
@end
