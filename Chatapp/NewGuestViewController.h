//
//  NewGuestViewController.h
//  Chatapp
//
//  Created by arvind on 7/15/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMDateVO.h"
#import "AppDelegate.h"
@interface NewGuestViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate,NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UITextField *questFirstnameTxt,*questLastnameTxt,*phoneTxt,*epmdateTxt,*invitedfistnmTxt,*invitedLastnmTxt,*bpmSelectTxt,*emailTxt,*bpmTxt;
@property(nonatomic,retain) IBOutlet UILabel *addLbl,*questNameLbl,*phoneLbl,*epmdateLbl,*invitedLbl,*smdLbletc;
@property(nonatomic,retain) IBOutlet UIButton *saveBtn;
@property(nonatomic,retain) IBOutlet UIDatePicker *datepicker;
@property(nonatomic,retain) NSDateFormatter *starttime;
@property(nonatomic,retain) NSString *theDate,*timeDuration;
@property(nonatomic,retain) IBOutlet UIImageView *bgimage;
@property(nonatomic,readwrite) BOOL viewUp;
@property(nonatomic,retain) IBOutlet UIToolbar *dateToobar;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray*lblarray,*bpmDateArray;
@property(nonatomic,retain)  NSString *dateString,*smdCheckStr;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) BPMDateVO *bpmVo;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end
