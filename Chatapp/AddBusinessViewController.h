//
//  AddBusinessViewController.h
//  Chatapp
//
//  Created by arvind on 7/15/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessVO.h"
#import "AppDelegate.h"
@interface AddBusinessViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UITextField *dateTxt,*firstnameTxt,*lastnameTxt,*agentTxt,*traineeTxt,*productTxt,*actualTxt,*noteTxt;
@property(nonatomic,retain) IBOutlet UILabel *dateLbl,*clientNameLbl,*agentLbl,*traineeLbl,*productLbl,*actualLbl,*noteLbl;
@property(nonatomic,retain) IBOutlet UIButton *AddBtn,*buttonClose;
@property(nonatomic,retain) IBOutlet UILabel  *BusinessLbl;
@property(nonatomic,retain) IBOutlet UIDatePicker *datepicker;
@property(nonatomic,retain) NSDateFormatter *starttime;
@property(nonatomic,retain) NSString *theDate,*timeDuration;
@property(nonatomic,retain) IBOutlet UIImageView *bgimage;
@property(nonatomic,readwrite) BOOL viewUp;
@property(nonatomic,retain) IBOutlet UIToolbar *dateToobar;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIPickerView *agentPickerView,*traineePickerView;
@property(nonatomic,retain) IBOutlet UIToolbar *toolbartrai,*toolbaragt;
@property(nonatomic,retain) NSMutableArray *dataArrayAgent,*traineeListArray;
@property(nonatomic,retain) BusinessVO *busVo;
@property(nonatomic,retain) NSString *useridStrtrai;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray*lblarray,*agentSelectArray,*agentTempArray,*agentIdArry;
@property(nonatomic,retain)  NSString *dateString;
@property(nonatomic,retain) UIView *displayTextView;
@property(nonatomic,readwrite) int heightView,heightCellAgent;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end

