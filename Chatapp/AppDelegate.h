//
//  AppDelegate.h
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "LoginVO.h"
#import "MsgChatVO.h"
#import "CEOSMDVO.h"
#import "ProfileVO.h"
#import "ABNotifier.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, ABNotifierDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain) NSString *loginUsername,*userProfileImage;
@property(nonatomic,retain) LoginVO *loginDetails;
@property(nonatomic,retain) MsgChatVO *msgchatVO;
@property(nonatomic,retain) NSMutableArray *MessageChatArray,*GroupChatArray,*groupListArray,*CeoArray,*SmdArray,*traineeListArray;
@property(nonatomic,readwrite) int indexpath;
@property(nonatomic,retain) NSString *deviceToken;
@property(nonatomic,retain) NSMutableArray *dataArrayLevel,*countryListArray,*timezoneArray,*licensesArray,*languageArray,*dataArrayATASMMD,*profileArray,*newuserListArray,*bpmDateArray,*agentTempArray,*agentSelectArray,*agentIdArry,*dataArrayAgent;
@property(nonatomic,retain) CEOSMDVO *ceosmdVO;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) NSString *typeStringCeo,*typeStringSmd,*StringATASAMD,*bpmLocationStr,*bpmuseridStr,*ceoFirstlastname,*smdfirstlastname,*checkstr,*ceouserid,*smduserid,*smdTraineeStr;
-(void)getCountryData;
-(void)getDataSMD;
-(void)getDataCED;
-(void)getDataATASMMD;
@property(nonatomic,retain) ProfileVO *proVO;
@property(nonatomic,retain) NSString *currentlocation,*agentStr,*tranieeStr,*traineeId,*pushStr,*useridagent;
@property(nonatomic,readwrite) int index,indexs,push;

@end

