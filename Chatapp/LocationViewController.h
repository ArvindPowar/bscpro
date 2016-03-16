//
//  LocationViewController.h
//  Chatapp
//
//  Created by arvind on 8/25/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
@interface LocationViewController : UIViewController<CLLocationManagerDelegate>
@property(nonatomic,retain) NSString *longitudeLabel,*latitudeLabel;
@property(nonatomic,retain)AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIButton *loginBtn,*checkinBtn;
@property(nonatomic,retain) NSString* officeId,* sItemNameDecora;
@end
