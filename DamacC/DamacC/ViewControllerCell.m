//
//  ViewControllerCell.m
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import "ViewControllerCell.h"

@implementation ViewControllerCell

@synthesize lblName;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _textField.layer.cornerRadius = 2.0f;
    _textField.layer.borderColor = rgb(191, 154, 88).CGColor;
    _textField.layer.borderWidth = 1;
}
@end
