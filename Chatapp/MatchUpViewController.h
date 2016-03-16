//
//  MatchUpViewController.h
//  Chatapp
//
//  Created by arvind on 7/16/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MatchUpViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UITextField *dayTxt,*dateTxt,*timeTxt,*timezoneTxt,*placeTxt,*nameTxt,*contactTxt,*profileTxt,*traineeeTxt,*TraineePhTxt,*ApptTxt,*notesTxt,*spousenameTxt;
@property(nonatomic,retain) IBOutlet UILabel *matchupLbl,*dayLbl,*dateLbl,*timeLbl,*timezoneLbl,*placeLbl,*nameLbl,*contactLbl,*profileLbl,*traineeLbl,*traineePhLbl,*appttypeLbl,*notesLbl,*spouseLbl;
@property(nonatomic,retain) IBOutlet UIButton *matchUpBtn;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIPickerView *dayPickerView,*timezonePickView;
@property(nonatomic,retain) IBOutlet UIToolbar *dayToobar,*timezoneToolbar,*dateToolbar,*timeToolbar;
@property(nonatomic,retain) NSMutableArray *dayArrayList,*timezoneArray,*profileArray,*btnArray;
@property(nonatomic,retain) IBOutlet UIDatePicker *datepicker,*timepicker;
@property(nonatomic,retain) NSDateFormatter *starttime,*endtime;
@property(nonatomic,retain) NSString *theDate,*timeDuration;
@property(nonatomic,retain) IBOutlet UIImageView *bgimage;
@property(nonatomic,readwrite) BOOL viewUp;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIButton *btn1,*btn2,*btn3,*btn4,*btn5,*btn6,*btn7,*btn8,*btnSpan,*aButton;
@property(nonatomic,retain) NSMutableArray *buttonArray;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray*lblarray;
@property(nonatomic,retain)  NSString *dateString,*timeStrings,*myDayString,*theTime;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end
