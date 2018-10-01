//
//  ViewControllerCellHeader.m
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import "ViewControllerCellHeader.h"

@implementation ViewControllerCellHeader

@synthesize btnShowHide, lbTitle;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(instancetype)init{
    self = [super init];
    if(self)
    {
        self.contentView.layer.cornerRadius = 10.0f;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = rgb(174, 134, 73).CGColor;
        
    }
    return self;
}

@end
