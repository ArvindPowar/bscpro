//
//  AppDelegate.m
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "MainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize loginDetails,msgchatVO,MessageChatArray,GroupChatArray,indexpath,deviceToken,countryListArray,ceosmdVO,activityIndicator,groupListArray,CeoArray,SmdArray,typeStringCeo,typeStringSmd,StringATASAMD,dataArrayATASMMD,proVO,profileArray,index,pushStr,push;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    push=0;
//[[UIApplication sharedApplication] setApplicationIconBadgeNumber:--push];
    [ABNotifier startNotifierWithAPIKey:@"840566f84cb4fd3f3025814a1958c334"  //Your API Key
                              projectID:@"118800"  //Your App's Product ID
                        environmentName:ABNotifierAutomaticEnvironment
                                 useSSL:YES // only if your account supports it
                               delegate:self];
    // show ui
    [self.window makeKeyAndVisible];

     if (launchOptions != nil) {
         // Launched from push notification
         NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
         if (index !=-1) {
             MainViewController *viewController = [[MainViewController alloc]initWithNibName:NSStringFromClass([MainViewController class]) bundle:nil];
             index=6;
             pushStr=[[NSString alloc]init];
             pushStr=@"yes";
             [self.window.rootViewController presentModalViewController:viewController animated:NO];
         }

     }else{
         if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
         {
             [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
             [[UIApplication sharedApplication] registerForRemoteNotifications];
         }
         else
         {
             [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
              (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
         }
         LoginViewController *lvc;
         if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
             lvc=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];

         }else{
         lvc=[[LoginViewController alloc] initWithNibName:@"LoginViewController~ipad" bundle:nil];
         }
         
         UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lvc];
         navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
         self.window.rootViewController=navController;
         [self.window makeKeyAndVisible];
     }
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    NSString *deviceTokenString=[[[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.deviceToken=deviceTokenString;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //pusd notification click than open userlist code
           MainViewController *viewController = [[MainViewController alloc]initWithNibName:NSStringFromClass([MainViewController class]) bundle:nil];
           index=6;
           pushStr=[[NSString alloc]init];
           pushStr=@"yes";
           [self.window.rootViewController presentModalViewController:viewController animated:NO];
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:++push];
//[UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue];
    if ( application.applicationState == UIApplicationStateActive ){
    }
        // app was already in the foregroundd
    else{
    }
  
    }
#pragma mark - app delegate


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
     //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:++push];
    
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)getCountryData{
       countryListArray=[[NSMutableArray alloc] init];
    //[NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    NSURL *url;
    NSMutableString *httpBodyString;
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
    
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getCountry"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            
            NSError *error;
            if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else{

            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *userArray = [userDict objectForKey:@"countrylist"];
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                
                CEOSMDVO *csvo=[[CEOSMDVO alloc] init];
                csvo.country=[[NSString alloc] init];
                csvo.country=[[activityData allKeys] objectAtIndex:0];
                [countryListArray addObject:csvo];
            }
            [activityIndicator stopAnimating];
        }
        }
    }];
}
-(void)getDataSMD{
       typeStringSmd=@"CEO,EVC,SMD,EMD";
    SmdArray=[[NSMutableArray alloc] init];
    //[NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    NSURL *url;
    NSMutableString *httpBodyString;
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"type=%@",typeStringSmd]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getUsersByType/"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            
            NSError *error;
            if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else{

            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *userArray = [userDict objectForKey:@"userlist"];
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                CEOSMDVO *csvo=[[CEOSMDVO alloc] init];
                
                csvo.user_id=[[NSString alloc] init];
                csvo.username=[[NSString alloc] init];
                csvo.fname=[[NSString alloc] init];
                csvo.lname=[[NSString alloc] init];
                csvo.agentcode=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"id"] != [NSNull null])
                    csvo.user_id=[activityData objectForKey:@"id"];
                csvo.username=[activityData objectForKey:@"username"];
                csvo.fname=[activityData objectForKey:@"firstname"];
                csvo.lname=[activityData objectForKey:@"lastname"];
                csvo.agentcode=[activityData objectForKey:@"agent_id"];
                
                [SmdArray addObject:csvo];
            }
            
            
            [activityIndicator stopAnimating];
        }
        }
        
    }];
    
    
    
}
-(void)getDataCED{
      typeStringCeo=@"CEO,EVC";
    CeoArray=[[NSMutableArray alloc] init];
    //[NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    NSURL *url;
    NSMutableString *httpBodyString;
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"type=%@",typeStringCeo]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getUsersByType/"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            
            NSError *error;
            if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else{

            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *userArray = [userDict objectForKey:@"userlist"];
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                CEOSMDVO *csvo=[[CEOSMDVO alloc] init];
                
                csvo.user_id=[[NSString alloc] init];
                csvo.username=[[NSString alloc] init];
                csvo.fname=[[NSString alloc] init];
                csvo.lname=[[NSString alloc] init];
                csvo.agentcode=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"id"] != [NSNull null])
                    csvo.user_id=[activityData objectForKey:@"id"];
                csvo.username=[activityData objectForKey:@"username"];
                csvo.fname=[activityData objectForKey:@"firstname"];
                csvo.lname=[activityData objectForKey:@"lastname"];
                csvo.agentcode=[activityData objectForKey:@"agent_id"];
                
                [CeoArray addObject:csvo];
            }
            [activityIndicator stopAnimating];
            
        }
        }
    }];
    
    
    
}
-(void)getDataATASMMD{
       dataArrayATASMMD=[[NSMutableArray alloc] init];
    StringATASAMD=@"A,TA,SA,MD";
    //[NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    
    NSURL *url;
    NSMutableString *httpBodyString;
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"type=%@",StringATASAMD]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getUsersByType/"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            
            NSError *error;
            if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else{
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *userArray = [userDict objectForKey:@"userlist"];
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                CEOSMDVO *csvo=[[CEOSMDVO alloc] init];
                
                csvo.user_id=[[NSString alloc] init];
                csvo.username=[[NSString alloc] init];
                csvo.fname=[[NSString alloc] init];
                csvo.lname=[[NSString alloc] init];
                csvo.agentcode=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"id"] != [NSNull null])
                    csvo.user_id=[activityData objectForKey:@"id"];
                csvo.username=[activityData objectForKey:@"username"];
                csvo.fname=[activityData objectForKey:@"firstname"];
                csvo.lname=[activityData objectForKey:@"lastname"];
                csvo.agentcode=[activityData objectForKey:@"agent_id"];
                
                [dataArrayATASMMD addObject:csvo];
            }
            
            
            [activityIndicator stopAnimating];
            
        }
        }
        
    }];
    
}

@end
