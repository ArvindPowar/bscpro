//
//  NewRecruitViewController.h
//  Chatapp
//
//  Created by arvind on 7/15/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface NewRecruitViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UILabel *newrLBl,*hireDateLbl,*nameLbl,*inviterLbl,*contactLbl,*codeLbl,*followLbl,*complete_amaLbl,*submit_licLbl,*meet_spouseLbl,*prospect_listLbl,*field_trainingsLbl,*FNALbl,*Three_3_30BLbl,*Fast_schoolLbl;
@property(nonatomic,retain) IBOutlet UITextField *hireDateTxt,*nameTxt,*inviterTxt,*contactTxt,*codeTxt,*fieldTraning;
@property(nonatomic,retain) IBOutlet UITextField *followUpTxtView;
@property(nonatomic,retain) IBOutlet UIButton *submitBtn;
@property(nonatomic,retain) IBOutlet UIButton *complete_amaBtn,*submit_licBtn,*meet_spouseBtn,*prospect_listBtn,*field_trainingsBtn,*FNABtn,*Three_3_30Btn,*Fast_schoolBtn;
@property(nonatomic,retain) NSString *completeStr,*submitStr,*meetStr,*prospectStr,*fieldStr,*fnaStr,*threeStr,*fastStr;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIDatePicker *datepicker;
@property(nonatomic,retain) IBOutlet UIToolbar *dateToobar;
@property(nonatomic,retain) NSDateFormatter *starttime;
@property(nonatomic,retain) NSString *theDate,*timeDuration;
@property(nonatomic,retain) IBOutlet UIImageView *bgimage;
@property(nonatomic,readwrite) BOOL viewUp;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray*lblarray,*fieldTraArray;
@property(nonatomic,retain)  NSString *dateString;
@property(nonatomic,retain) IBOutlet UIPickerView *fieldTraPickerView;
@property(nonatomic,retain) IBOutlet UIToolbar *toolbarFieldTra;
@property(nonatomic,retain) AppDelegate *appDelegate;
@end
