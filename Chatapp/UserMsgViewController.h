//
//  UserMsgViewController.h
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgChatVO.h"
#import "UserListVO.h"
#import "AppDelegate.h"
#import "Alertview/CustomIOS7AlertView.h"

@interface UserMsgViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UITextField *msgText;
@property(nonatomic,retain) IBOutlet UIButton *submitBtn,*attachmentBtn;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) NSMutableArray *MessageChatArray,*bubbleData;
@property(nonatomic,retain) NSString *SelectedIDGroup,*selectIDUser,*SelectedName,*profileimage;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet MsgChatVO *msgChat;
@property(nonatomic,retain) IBOutlet UserListVO *userlist;
@property(nonatomic,retain)  IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UIView *demoView;
@property(nonatomic,retain) CustomIOS7AlertView *alertView1;
@property(nonatomic,retain) UIImage *image_;
@property(strong, nonatomic) UIButton *radiobutton1;
@property(strong, nonatomic) UIButton *radiobutton2;
@property(strong, nonatomic) UIButton *radiobutton3;
@property(strong, nonatomic) NSString *selectMsgId,*response;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

-(void)getMessgaeChat;
-(void)getGroupChat;
@end
