//
//  BpmDateViewController.h
//  Chatapp
//
//  Created by arvind on 9/28/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BpmDateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>{
    BOOL isSearching;
    NSMutableArray *filteredContentList;
    
}
@property(nonatomic,retain) IBOutlet UITableView *bpmFieldTableView;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;
@property(nonatomic,retain)  UIAlertView *alert;


@end
