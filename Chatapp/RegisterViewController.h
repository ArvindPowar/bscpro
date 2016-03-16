//
//  RegisterViewController.h
//  Chatapp
//
//  Created by arvind on 7/8/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alertview/CustomIOS7AlertView.h"
#import "CEOSMDVO.h"
#import "AppDelegate.h"
@interface RegisterViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UILabel *yournameLbl,*firstlastLbl,*agentCodeLbl,*agentCodeNO,*authoCodeLbl,*yourAuthoLbl,*username,*yourusernameLbl,*passwordLbl,*confirmPassLbl,*emailLbl,*yourEmailLbl,*levelLbl,*selectTypeLbl,*uplineceoLbl,*selectuplineCeoLbl,*uplineSmdLbl,*selectiplineSmdLbl;
@property(nonatomic,retain) IBOutlet UITextField *firstnameTxt,*lastnameTxt,*agentCodeTxt,*authoCodeTxt,*userNameTxt,*passwordTxt,*confirmPasswordTxt,*emailTxt,*levelTxt,*uplineceTxt,*uplineSmdTxt;
@property(nonatomic,retain) IBOutlet UIButton *createBtn,*cancelBtn;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) CustomIOS7AlertView *alertview_postAdvt;
@property(nonatomic,retain) IBOutlet UIPickerView *LevelPickerView,*CEOPickerView,*SMDPickerView;
@property(nonatomic,retain) IBOutlet UIToolbar *toolbar,*toolbar1,*toolbar2;
@property(nonatomic,retain) NSMutableArray *dataArrayLevel,*CeoArray,*SmdArray;
@property(nonatomic,retain) NSString *typeStringCeo,*typeStringSmd;
@property(nonatomic,retain) CEOSMDVO *ceosmdVO;
@property(nonatomic,retain) NSString *characters;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray*lblarray;
@end
