//
//  MainViewController.m
//  CommunicationApp
//
//  Created by mansoor shaikh on 13/04/14.
//  Copyright (c) 2014 MobiWebCode. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "UserListViewController.h"
#import "ProfileViewController.h"
#import "NewRecruitViewController.h"
#import "AddBusinessViewController.h"
#import "NewGuestViewController.h"
#import "MatchUpViewController.h"
#import "OfficeLocatorViewController.h"
#import "LoginViewController.h"
#import "LocationViewController.h"
#import "DashboardViewController.h"
#import "MatchupBookViewController.h"
@interface MainViewController ()<SWRevealViewControllerDelegate>

@end

@implementation MainViewController
@synthesize viewController = _viewController;
@synthesize appDelegate,index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - SWRevealViewDelegate

#define LogDelegates 0
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    RearViewController *rearViewController = [[RearViewController alloc] init];
    UINavigationController *frontNavigationController;
    DashboardViewController *dashboard=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
    UserListViewController *userList;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

    userList=[[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:nil];
    }else{
        userList=[[UserListViewController alloc] initWithNibName:@"UserListViewController~ipad" bundle:nil];
    }
    ProfileViewController *pvc=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    NewRecruitViewController *nrvc;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        nrvc=[[NewRecruitViewController alloc] initWithNibName:@"NewRecruitViewController" bundle:nil];
    }else{
        nrvc=[[NewRecruitViewController alloc] initWithNibName:@"NewRecruitViewController~ipad" bundle:nil];
    }

    AddBusinessViewController *addbusinessvc;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    addbusinessvc=[[AddBusinessViewController alloc] initWithNibName:@"AddBusinessViewController" bundle:nil];
    }else{
        addbusinessvc=[[AddBusinessViewController alloc] initWithNibName:@"AddBusinessViewController~ipad" bundle:nil];
    }
    NewGuestViewController *newguest;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    newguest=[[NewGuestViewController alloc] initWithNibName:@"NewGuestViewController" bundle:nil];
        }else{
            newguest=[[NewGuestViewController alloc] initWithNibName:@"NewGuestViewController~ipad" bundle:nil];
        }
    MatchUpViewController *matchup;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    matchup=[[MatchUpViewController alloc] initWithNibName:@"MatchUpViewController" bundle:nil];
            }else{
                matchup=[[MatchUpViewController alloc] initWithNibName:@"MatchUpViewController~ipad" bundle:nil];

            }
    OfficeLocatorViewController *officelocator;
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    officelocator=[[OfficeLocatorViewController alloc] initWithNibName:@"OfficeLocatorViewController" bundle:nil];
                }else{
                    officelocator=[[OfficeLocatorViewController alloc] initWithNibName:@"OfficeLocatorViewController~ipad" bundle:nil];

                }

    LoginViewController *login;
                    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                    }else{
                        login=[[LoginViewController alloc] initWithNibName:@"LoginViewController~ipad" bundle:nil];

                    }
    LocationViewController *location=[[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    MatchupBookViewController *matchupbook;
                        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    matchupbook=[[MatchupBookViewController alloc] initWithNibName:@"MatchupBookViewController" bundle:nil];
                        }else{
                            matchupbook=[[MatchupBookViewController alloc] initWithNibName:@"MatchupBookViewController~ipad" bundle:nil];

                        }
    if(appDelegate.index==0)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:dashboard];
    else if(appDelegate.index==6)
    frontNavigationController = [[UINavigationController alloc] initWithRootViewController:userList];
       else if(appDelegate.index==3)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:nrvc];
    else if(appDelegate.index==4)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:addbusinessvc];
    else if(appDelegate.index==2)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:newguest];
    else if(appDelegate.index==1)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:matchup];
        else if(appDelegate.index==5)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:location];
    else if(appDelegate.index==7){
        
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:login];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs removeObjectForKey:@"loggedin"];
        [prefs synchronize];
        appDelegate.indexs=0;
    }
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;

    
    self.viewController = revealController;
	
	 [[[UIApplication sharedApplication] delegate] window].rootViewController = self.viewController;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
