//
//  PopTableViewController.h
//  INCOIS
//
//  Created by Gaian on 7/4/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol POPDelegate <NSObject>

-(void)selectedFromDropMenu:(NSString*)str forType:(NSString*)type withTag:(int)tag;


@end

@interface PopTableViewController : UITableViewController

@property id <POPDelegate>delegate;
@property NSArray *tvData;
@property NSArray *thumbNailsArray;

@end
