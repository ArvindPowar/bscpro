//
//  NewuserListViewController.h
//  Chatapp
//
//  Created by arvind on 8/21/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class  NewUserVO;
@interface NewuserListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>{
    BOOL isSearching;
    NSMutableArray *filteredContentList;
    
}

@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) NSMutableArray *userListArray,*groupListArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end
