//
//  RearViewController.h
//  Chatapp
//
//  Created by arvind on 7/13/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
@interface RearViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UITableView *rearTableView;
@property (nonatomic, retain) IBOutlet UILabel *usernameLabel,*titleLabel;
@property (nonatomic, retain) NSString *selectedMenuItem;
@property (nonatomic, retain) IBOutlet AsyncImageView *imageLogo;

@end
