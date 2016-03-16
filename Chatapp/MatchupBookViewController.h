//
//  MatchupBookViewController.h
//  Chatapp
//
//  Created by arvind on 12/15/15.
//  Copyright © 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MatchupBookViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UITableView *mainTableView;
@property(nonatomic,retain) NSMutableArray*matchupArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UIView *displayTextView;
@property(nonatomic,retain) UITextField *agentTxt;
@property(nonatomic,retain) UIButton *buttonClose;
@end
