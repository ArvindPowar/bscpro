//
//  UserListViewController.h
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface UserListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UIButton *clicktologout;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray *userListArray,*groupListArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@end
