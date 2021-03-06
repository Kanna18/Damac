//
//  PopCell2.m
//  DamacC
//
//  Created by Gaian on 08/08/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#import "PopCell2.h"
#import "POPTableCell.h"
#define bottomPaddingSpace 10.0
#define textFieldTag 10000
#import "POPViewController.h"

@interface PopCell2()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WSCalendarViewDelegate>

@end

@implementation PopCell2{
    
    NSArray *dropItems;
    NSArray *tvItems;
    WSCalendarView *calendarView;
    NSMutableArray *eventArray;
    UIView *superView;
    UITextField *textF;
    CGRect tableViewRect,contentviewRect;
    NSMutableDictionary *dictionaryTf;
    POPViewController *superVC;
    NSString *paymentMode;
    NSString *paymentDate;
}



-(void)awakeFromNib{
    [super awakeFromNib];
    [self roundCorners:_buttonNext];       
    dropItems = @[@"Bank Transfer",@"Cash",@"Cheque",@"Credit Card"];
    [self dropMenu];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    tvItems = @[@"Payment Date*",@"Payment Allocation remarks",@"Total Amount*",@"Sender Name",@"Bank Name",@"Swift Code"];
    [self setCalendarInit];
    superView= DamacSharedClass.sharedInstance.currentVC.view;
    superVC = DamacSharedClass.sharedInstance.currentVC;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // Register notification when the keyboard will be hide
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    tableViewRect = _tableView.frame;
    contentviewRect = self.contentView.frame;
    dictionaryTf = [[NSMutableDictionary alloc]init];
}

-(void)roundCorners:(UIButton*)sender{
    sender.layer.cornerRadius = 5;
    sender.layer.borderColor = rgb(191, 154, 88).CGColor;
    sender.clipsToBounds = YES;
}

-(void)setCalendarInit{
    
    calendarView = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    //calendarView.dayColor=[UIColor blackColor];
    //calendarView.weekDayNameColor=[UIColor purpleColor];
    //calendarView.barDateColor=[UIColor purpleColor];
    //calendarView.todayBackgroundColor=[UIColor blackColor];
    calendarView.tappedDayBackgroundColor=[UIColor blackColor];
    calendarView.calendarStyle = WSCalendarStyleDialog;
    calendarView.isShowEvent=false;
    [calendarView setupAppearance];
    [DamacSharedClass.sharedInstance.currentVC.view addSubview:calendarView];
    calendarView.delegate=self;
    
    //    calendarViewEvent = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    //    calendarViewEvent.calendarStyle = WSCalendarStyleView;
    //    calendarViewEvent.isShowEvent=true;
    //    calendarViewEvent.tappedDayBackgroundColor=[UIColor blackColor];
    ////    calendarViewEvent.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    //    calendarViewEvent.frame = CGRectMake(0,0 , self.view.frame.size.width-10, self.view.frame.size.height/3);
    //    calendarViewEvent.center = self.baseView.center;
    //    [calendarViewEvent setupAppearance];
    //    calendarViewEvent.delegate=self;
    //    [self.baseView addSubview:calendarViewEvent];
    
    
    eventArray=[[NSMutableArray alloc] init];
    NSDate *lastDate;
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    for (int i=0; i<10; i++) {
        
        if (!lastDate) {
            lastDate=[NSDate date];
        }
        else{
            [dateComponent setDay:1];
        }
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:lastDate options:0];
        lastDate=datein;
        [eventArray addObject:datein];
    }
//    [calendarViewEvent reloadCalendar];
    
    NSLog(@"%@",[eventArray description]);
}

-(IBAction)nextButtonCliced:(UIButton*)sender{
    
    [textF endEditing:YES];
    
    if(paymentDate.length<1){
        [FTIndicator showToastMessage:@"please select payment date"];
        return;
    }
    NSString *amount = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+2]]];
    if(amount.length <= 1){
        [FTIndicator showToastMessage:@"Amount field should not be empty"];
        return;
    }
    NSString *senderName = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+3]]];
    if(senderName.length<1){
        [FTIndicator showToastMessage:@"please enter sender name"];
        return;
    }
    if(paymentDate.length<1){
        [FTIndicator showToastMessage:@"please select payment date"];
        return;
    }
    NSString *bankName = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+4]]];
    if(bankName.length<1){
        [FTIndicator showToastMessage:@"please enter bank name"];
        return;
    }
    NSString *swiftCode = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+5]]];
    if(swiftCode.length<1){
        [FTIndicator showToastMessage:@"please bank swift code"];
        return;
    }    
    _popObj.PaymentMode = paymentMode;
    _popObj.PARemark = [dictionaryTf valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textFieldTag+1]]];
    _popObj.PaymentDate = paymentDate;
    _popObj.SenderName = senderName;
    _popObj.BankName = bankName;
    _popObj.SwiftCode = swiftCode;
    [self moveToThirdCell];
}


-(void)dropMenu{
    
    _baseDropView.backgroundColor = [UIColor clearColor];
    _baseDropView.layer.cornerRadius = 10.0f;
    _baseDropView.layer.borderColor = [UIColor yellowColor].CGColor;
    _baseDropView.layer.borderWidth = 1.0f;
    _baseDropView.backgroundColor = [UIColor clearColor];
    _baseDropView.delegate = self;
    _baseDropView.items = dropItems;
    _baseDropView.title = dropItems[0];
    _baseDropView.titleColor = goldColor;
    _baseDropView.titleTextAlignment = NSTextAlignmentLeft;
    _baseDropView.DirectionDown = YES;
    
}

#pragma mark DropMenu Delegates
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex
{
    _baseDropView.title = dropItems[atIntedex];
    paymentMode = dropItems[atIntedex];
}

-(void)didShow : (KPDropMenu *)dropMenu{
    
}
-(void)didHide : (KPDropMenu *)dropMenu{
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    POPTableCell *cell = (POPTableCell*)[tableView dequeueReusableCellWithIdentifier:@"pOPTableCell" forIndexPath:indexPath];
    cell.popTF.placeholder = tvItems[indexPath.row];
    cell.popTF.tag =  indexPath.row+textFieldTag;
    cell.popTF.delegate = self;
    [cell.popTF setValue:rgb(191, 154, 88) forKeyPath:@"_placeholderLabel.textColor"];
    if(indexPath.row == 0){
        cell.buttonTop.hidden = NO;
        [cell.buttonTop addTarget:self action:@selector(activateCalen) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.buttonTop.hidden = YES;
    }
    
    if(indexPath.row == 2){
        cell.popTF.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        cell.popTF.keyboardType = UIKeyboardTypeDefault;
    }
    return cell;
}

-(void)activateCalen{
    [calendarView ActiveCalendar:superView];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tvItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


#pragma mark WSCalendarViewDelegate
-(NSArray *)setupEventForDate{
    return eventArray;
}

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate{
    
}
-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"yyyy-dd-MM"];
    //    NSDateFormatter *todaysDate = [[NSDateFormatter alloc]init];
    //    [todaysDate setDateFormat:@"dd MMM yyyy"];
    NSDate *tdaysDate = [NSDate date];
    NSComparisonResult result = [tdaysDate compare:selectedDate];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
    NSLog(@"%ld",(long)result);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:(NSWeekOfYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitWeekday) fromDate:selectedDate];
    
    if(result == NSOrderedAscending ){
        [FTIndicator showErrorWithMessage:@"Invalid Date selected"];
        [calendarView ActiveCalendar:superView];
    }else{
        paymentDate = str;
        UITextField *tf = [_tableView viewWithTag:textFieldTag];
        tf.text = str;
    }
    
}

#pragma mark TextField Delegates
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self changetoNextField:textField];
    textF = textField;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    return NO; // We do not want UITextField to insert line-breaks.
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0){
        [dictionaryTf setValue:textField.text forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:textField.tag]]];
    }
}


-(void)changetoNextField:(UITextField*)tf{
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnClick)];


    keyboardToolbar.items = @[flexBarButton, nextBarButton];
    tf.inputAccessoryView = keyboardToolbar;

}


-(void)nextBtnClick{
    if(textF){
        [textF resignFirstResponder];
    }    
    UITextField *nextTxtField=(UITextField*)[self.tableView viewWithTag:textF.tag+1];
    if(nextTxtField){
        [nextTxtField becomeFirstResponder];
    }
}


-(void) keyboardWillShow:(NSNotification *)note
{
    // Get the keyboard size
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = tableViewRect;
    
    
    contentviewRect.origin.y = -(contentviewRect.origin.y + ((textF.tag-textFieldTag) * 40));
    
    // Start animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
    
    self.contentView.frame = contentviewRect;
    // Reduce size of the Table view
//    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
//        frame.size.height -= keyboardBounds.size.height;
//    else
//        frame.size.height -= keyboardBounds.size.width;
//
//
//    frame.size.height=frame.size.height+bottomPaddingSpace;
//    // Apply new size of table view
//    self.tableView.frame = frame;
//
//    // Scroll the table view to see the TextField just above the keyboard
//    if (textF)
//    {
//        CGRect textFieldRect = [self.tableView convertRect:textF.bounds fromView:textF];
//        [self.tableView scrollRectToVisible:textFieldRect animated:NO];
//    }
    
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note
{
    // Get the keyboard size
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    contentviewRect.origin.y = 0;
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = tableViewRect;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    
//    // Increase size of the Table view
//    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
//        frame.size.height += keyboardBounds.size.height;
//    else
//        frame.size.height += keyboardBounds.size.width;
//
//    // Apply new size of table view
//    self.tableView.frame = tableViewRect;
    self.contentView.frame = contentviewRect;
    
    [UIView commitAnimations];
}

-(void)moveToThirdCell{
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
    [superVC.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}
-(void)setDictionary:(UITextField*)tf{
    
}

@end
