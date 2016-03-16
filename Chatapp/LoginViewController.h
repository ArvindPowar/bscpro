//
//  LoginViewController.h
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UIButton *clicktologin,*createAccount;
@property(nonatomic,retain) IBOutlet UITextField *userNameText;
@property(nonatomic,retain) IBOutlet UITextField *userPasswordText;
@property(nonatomic,retain) NSString *profileImage;
@property(nonatomic,retain) NSMutableArray *loginDetailsArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIImageView *Logoimg,*backgImage,*lineimg1,*lineimg2;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UILabel *usernameicon,*passwordicon;
@property(nonatomic,retain) MPMoviePlayerController *moviePlayer;
@end
