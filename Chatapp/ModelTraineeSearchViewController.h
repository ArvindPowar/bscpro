//
//  ModelTraineeSearchViewController.h
//  Chatapp
//
//  Created by arvind on 9/12/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ModelTraineeSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>{
    BOOL isSearching;
    NSMutableArray *filteredContentList;
    
}

@property(nonatomic,retain) IBOutlet UITableView *traineeFieldTableView;
@property(nonatomic,retain) NSMutableArray *userListArray,*groupListArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;
@property(nonatomic,retain)  UIAlertView *alert;
@property(nonatomic,retain) IBOutlet UIButton *plusBtn;
@end
