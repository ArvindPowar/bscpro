//
//  MainViewController.h
//  CommunicationApp
//
//  Created by mansoor shaikh on 13/04/14.
//  Copyright (c) 2014 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class SWRevealViewController;

@interface MainViewController : UIViewController
@property (strong, nonatomic) SWRevealViewController *viewController;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSString *searchString;
@property(nonatomic,retain) NSString *postupload;
@property(nonatomic,readwrite) int index;
@end
