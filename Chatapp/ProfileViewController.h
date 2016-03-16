//
//  ProfileViewController.h
//  Chatapp
//
//  Created by arvind on 7/14/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CEOSMDVO.h"
#import "ProfileVO.h"
#import "AsyncImageView.h"
#import "PictureSetview.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "Alertview/CustomIOS7AlertView.h"

@interface ProfileViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UILabel *yournameLbl,*firstlastLbl,*levelLbl,*agentCodeLbl,*licensesLbl,*languagesLbl,*addressLbl,*cityLbl,*stateLbl,*zipcodeLbl,*emailLbl,*countryLbl,*phoneLbl,*selectTimezoneLbl,*uplineSAMDLbl,*uplineceoevcLbl,*uplineSmdEmdLbl,*usernameLbl,*currentPasswordLbl,*NewPasswordLbl;
@property(nonatomic,retain) IBOutlet UILabel *passRepLbl;
@property(nonatomic,retain) IBOutlet UITextField *yournameTxt,*firstlastTxt,*levelTxt,*agentCodeTxt,*licensesTxt,*languagesTxt,*addressTxt,*cityTxt,*stateTxt,*zipcodeTxt,*emailTxt,*countryTxt,*phoneTxt,*selectTimezoneTxt,*uplineSAMDTxt,*uplineceoevcTxt,*uplineSmdEmdTxt,*usernameTxt,*currentPasswordTxt,*NewPasswordTxt,*passRetTxt;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIButton *updateProfile,*profilePicture;
@property(nonatomic,retain) IBOutlet UIPickerView *LevelPickerView,*CEOPickerView,*SMDPickerView,*countryPickerView,*timezonePickerView,*licensesPickerView,*languagePickerView,*SAMDpickerView;
@property(nonatomic,retain) IBOutlet UIToolbar *toolbar,*toolbar1,*toolbar2,*countryToolbar,*timezoneToolbar,*licensesToolbar,*languageToolbar,*SAMDToolbar;
@property(nonatomic,retain) NSMutableArray *dataArrayLevel,*countryListArray,*timezoneArray,*licensesArray,*languageArray,*dataArrayATASMMD,*profileArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) CEOSMDVO *ceosmdVO;
@property(nonatomic,retain) ProfileVO *proVO;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) NSString *typeStringCeo,*typeStringSmd,*StringATASAMD;
@property(nonatomic,retain) AsyncImageView *profileImg;
@property(nonatomic,retain) PictureSetview *psv;
@property(nonatomic,retain) IBOutlet UIButton *editBtnPicture;
@property(nonatomic,retain) IBOutlet UIImage *image;
@property(nonatomic,retain) NSString *SAMDstr,*uplineceoStr,*uplinesmdStr;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray*lblarray;
@property (nonatomic, retain) IBOutlet UIView *demoView;
@property(nonatomic,retain) CustomIOS7AlertView *alertView1;

@end
