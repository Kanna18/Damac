//
//  AppointmentsCell.m
//  DamacC
//
//  Created by Gaian on 19/07/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "AppointmentsCell.h"

@implementation AppointmentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLabelsData:(AppointmentsDataModel*)dm{
    _label1.text = dm.Name;
    _label2.text = [NSString stringWithFormat:@"Main Purpose:%@",dm.Service_Type__c];
    _label3.text = [NSString stringWithFormat:@"Sub-Purpose:%@",dm.Sub_Purpose__c];
    _label4.text = [NSString stringWithFormat:@"Time Slot:%@",dm.Appointment_Slot__c];
    _label5.text = [NSString stringWithFormat:@"Confirmed:%@",dm.Appointment_Status__c];
    _label6.text = [NSString stringWithFormat:@"%@",dm.Appointment_Date__c];
    
    [_label1 setAdjustsFontSizeToFitWidth:YES];
    [_label2 setAdjustsFontSizeToFitWidth:YES];
    [_label3 setAdjustsFontSizeToFitWidth:YES];
    [_label4 setAdjustsFontSizeToFitWidth:YES];
    [_label5 setAdjustsFontSizeToFitWidth:YES];
    [_label6 setAdjustsFontSizeToFitWidth:YES];
}

@end
