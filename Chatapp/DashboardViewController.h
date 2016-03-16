//
//  DashboardViewController.h
//  Chatapp
//
//  Created by arvind on 9/21/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DashboardVO.h"
@interface DashboardViewController : UIViewController
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UILabel *LblTxt1,*LblTxt2,*LblTxt3,*LblTxt4,*LblTxt5,*LblTxt6;
@property (strong, nonatomic) IBOutlet UILabel *iconLbl1,*iconLbl2,*iconLbl3,*iconLbl4,*iconLbl5,*iconLbl6;
@property (strong, nonatomic) IBOutlet UILabel *CountLbl1,*CountLbl2,*CountLbl3,*CountLbl4,*CountLbl5,*CountLbl6;
@property (strong, nonatomic) IBOutlet UILabel *backLbl1,*backLbl2,*backLbl3,*backLbl4,*backLbl5,*backLbl6;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) DashboardVO *dbVO;
@property(nonatomic,retain) NSMutableArray *alldashboardData;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) NSTimer *timer;
@end
