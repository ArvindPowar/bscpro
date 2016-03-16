
//
//  LoginViewController.m
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "LoginViewController.h"
#import "UserListViewController.h"
#import "LoginVO.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "Reachability.h"
#import "BusinessVO.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize clicktologin,userNameText,userPasswordText,profileImage,loginDetailsArray,appDelegate,Logoimg,createAccount,activityIndicator,backgImage,usernameicon,passwordicon,lineimg1,lineimg2;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];

    self.navigationItem.title=@"";
    self.navigationController.navigationBarHidden=YES;
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    activityIndicator.hidesWhenStopped=true;
    appDelegate.dataArrayAgent=[[NSMutableArray alloc]init];
    appDelegate.traineeListArray=[[NSMutableArray alloc]init];

    profileImage=[[NSString alloc]init];
    
    /*backgImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgImage.contentMode = UIViewContentModeCenter;
    backgImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgImage.image = [UIImage imageNamed:@"ezgif.com-gif-maker.gif"];
    [self.view addSubview:backgImage];*/
   /* backgImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgImage.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"frame_0_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_1_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_2_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_3_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_4_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_5_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_6_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_7_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_8_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_9_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_10_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_11_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_12_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_13_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_14_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_15_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_16_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_17_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_18_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_19_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_20_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_21_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_22_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_23_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_24_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_25_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_26_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_27_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_28_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_29_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_30_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_31_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_32_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_33_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_34_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_35_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_36_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_37_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_38_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_39_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_40_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_41_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_42_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_43_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_44_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_45_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_46_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_47_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_48_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_49_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_50_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_51_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_52_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_53_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_54_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_55_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_56_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_57_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_58_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_59_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_60_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_61_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_62_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_63_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_64_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_65_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_66_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_67_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_68_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_69_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_70_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_71_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_72_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_73_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_74_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_75_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_76_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_77_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_78_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_79_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_80_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_81_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_82_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_83_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_84_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_85_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_86_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_87_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_88_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_89_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_90_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_91_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_92_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_93_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_94_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_95_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_96_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_97_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_98_delay-0.05s.gif"],
                                  [UIImage imageNamed:@"frame_99_delay-0.05s.gif"], nil];
    backgImage.animationDuration = 4.0f;
    backgImage.animationRepeatCount = 0;
    [backgImage startAnimating];
    [self.view addSubview: backgImage];*/
    
    
    NSURL *videoURL = [[NSBundle mainBundle]   URLForResource:@"video" withExtension:@"mov"];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    
    self.moviePlayer.view.frame = self.view.frame;[self.view insertSubview:self.moviePlayer.view atIndex:0];
    //[[MPMusicPlayerController applicationMusicPlayer] setVolume:0];
    [self.moviePlayer play];
    self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    UIColor *color = [UIColor whiteColor];

    color = [color colorWithAlphaComponent:0.2f];
    [userNameText setBackgroundColor:color];
    [userPasswordText setBackgroundColor:color];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        if(height>=480 && height<568){
            usernameicon.layer.frame=CGRectMake(45,195,45,45);
            passwordicon.layer.frame=CGRectMake(47,240,45,45);
            lineimg1.layer.frame=CGRectMake(75,203,3,28);
            lineimg2.layer.frame=CGRectMake(75,246,3,28);
        }else if(height>=568 && height<600){
        
        usernameicon.layer.frame=CGRectMake(45,195,45,45);
        passwordicon.layer.frame=CGRectMake(47,240,45,45);
        lineimg1.layer.frame=CGRectMake(75,203,3,28);
        lineimg2.layer.frame=CGRectMake(75,246,3,28);
    
        }else{
            usernameicon.layer.frame=CGRectMake(73,195,45,45);
            passwordicon.layer.frame=CGRectMake(75,240,45,45);
            lineimg1.layer.frame=CGRectMake(100,205,3,28);
            lineimg2.layer.frame=CGRectMake(100,248,3,28);

        }
    usernameicon.textColor=[UIColor whiteColor];
    usernameicon.layer.shadowOpacity = 0.2;
    usernameicon.alpha=0.5;
    [usernameicon removeFromSuperview];
    [self.view addSubview:usernameicon];
    
   
    passwordicon.textColor=[UIColor whiteColor];
    passwordicon.layer.shadowOpacity = 0.2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ;
    passwordicon.alpha=0.5;
    [passwordicon removeFromSuperview];
    [self.view addSubview:passwordicon];
   
    [lineimg1 removeFromSuperview];
   
    [self.view addSubview:lineimg1];
    
    
    [lineimg2 removeFromSuperview];
    [self.view addSubview:lineimg2];
    }
    usernameicon.textColor=[UIColor whiteColor];
    usernameicon.layer.shadowOpacity = 0.2;
    usernameicon.alpha=0.5;
    passwordicon.textColor=[UIColor whiteColor];
    passwordicon.layer.shadowOpacity = 0.2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ;
    lineimg1.alpha = 0.5;
    lineimg2.alpha = 0.5;

    passwordicon.alpha=0.5;
    usernameicon.font = [UIFont fontWithName:@"FontAwesome" size:30];
    usernameicon.text = @"\uf007";
    passwordicon.font = [UIFont fontWithName:@"FontAwesome" size:30];
    passwordicon.text = @"\uf13e";
    
    [clicktologin.titleLabel setFont:[UIFont fontWithName:@"DistTh_" size:30.0]];
    [createAccount.titleLabel setFont:[UIFont fontWithName:@"DistTh_" size:30.0]];

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    userNameText.leftView = paddingView;
    userNameText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    userPasswordText.leftView = paddingViews;
    userPasswordText.leftViewMode = UITextFieldViewModeAlways;
    
  
    
    
    //[userNameText setBackgroundColor:[UIColor clearColor]];
    //[userPasswordText setBackgroundColor:[UIColor clearColor]];
    userNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USERNAME" attributes:@{NSForegroundColorAttributeName: color}];
    userPasswordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];

   
    //CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if(height>=480 && height<568){
        //iphone 4
        Logoimg.layer.frame=CGRectMake(30,50,260,60);
        [Logoimg.layer setCornerRadius:5.0];
        [Logoimg removeFromSuperview];
        [self.view addSubview:Logoimg];

        
        userNameText.layer.frame=CGRectMake(40,198,240,40);
        [userNameText removeFromSuperview];
        [self.view addSubview:userNameText];
        
        userPasswordText.layer.frame=CGRectMake(40,240,240,40);
        [userPasswordText removeFromSuperview];
        [self.view addSubview:userPasswordText];
        
        
        clicktologin.layer.frame=CGRectMake(40,320,240,40);
        //[clicktologin.layer setCornerRadius:5.0];
        [clicktologin removeFromSuperview];
        [self.view addSubview:clicktologin];
        
        createAccount.layer.frame=CGRectMake(40,362,240,40);
        //[createAccount.layer setCornerRadius:5.0];
        [createAccount removeFromSuperview];
        [self.view addSubview:createAccount];
        
    }else if(height>=568 && height<600){
        //iphone 5
        
        Logoimg.layer.frame=CGRectMake(30,50,260,60);
        [Logoimg.layer setCornerRadius:5.0];
        [Logoimg removeFromSuperview];
        [self.view addSubview:Logoimg];

        userNameText.layer.frame=CGRectMake(40,198,240,40);
        [userNameText removeFromSuperview];
        [self.view addSubview:userNameText];
        
        userPasswordText.layer.frame=CGRectMake(40,240,240,40);
        [userPasswordText removeFromSuperview];
        [self.view addSubview:userPasswordText];
        
        
        clicktologin.layer.frame=CGRectMake(40,320,240,40);
        //[clicktologin.layer setCornerRadius:5.0];
        [clicktologin removeFromSuperview];
        [self.view addSubview:clicktologin];

        createAccount.layer.frame=CGRectMake(40,362,240,40);
        //[createAccount.layer setCornerRadius:5.0];
        [createAccount removeFromSuperview];
        [self.view addSubview:createAccount];
        
    }
    
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"loggedin"]!=nil){
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if(myStatus == NotReachable)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
        [appDelegate getCountryData];
        [appDelegate getDataSMD];
        [appDelegate getDataCED];
        [appDelegate getDataATASMMD];
        }
        MainViewController *mainvc;
            mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=0;
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;

}
- (void)loopVideo {
    [self.moviePlayer play];
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
-(IBAction)loginAction{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
    loginDetailsArray=[[NSMutableArray alloc]init];
    if ([userNameText.text isEqualToString:@""] || [userPasswordText.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BSCPRO"
                                                        message:@"Please fill in username and password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

        NSString* string2 = [appDelegate.deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"username=%@&password=%@&device_id=%@&device_type=iPhone",userNameText.text,userPasswordText.text,string2]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/auth_api/login"];
        
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityIndicator stopAnimating];
                NSLog(@"Failed to submit request");
            }
            else
            {
                [activityIndicator stopAnimating];
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSError *error;
                if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else{
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *messages = [[NSString alloc]init];
                    messages = [userDict objectForKey:@"message"];
                    NSString *status = [[NSString alloc]init];
                    status = [userDict objectForKey:@"status"];
                    if([status isEqualToString:@"fail"])
                    {
                        
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:messages delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }else {
                    NSError *error;
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *userArray = [userDict objectForKey:@"user_profile"];
            LoginVO *lvo=[[LoginVO alloc]init];
                    appDelegate.loginDetails=[[LoginVO alloc] init];
                    appDelegate.loginDetails.userid=[[NSString alloc] init];
                    appDelegate.loginDetails.username=[[NSString alloc] init];
                    appDelegate.loginDetails.firstname=[[NSString alloc] init];
                    appDelegate.loginDetails.lastname=[[NSString alloc] init];
                    appDelegate.loginDetails.timezone=[[NSString alloc] init];
                    appDelegate.loginDetails.profileImage=[[NSString alloc] init];

                    if ([userArray objectForKey:@"username"] != [NSNull null])
                        lvo.userid=[userArray objectForKey:@"userid"];
                    appDelegate.loginDetails.username=[userArray objectForKey:@"username"];
                    appDelegate.loginDetails.firstname=[userArray objectForKey:@"firstname"];
                    appDelegate.loginDetails.lastname=[userArray objectForKey:@"lastname"];
                    appDelegate.loginDetails.timezone=[userArray objectForKey:@"usertimezone"];
                    appDelegate.loginDetails.profileImage=[userArray objectForKey:@"profileImage"];

            /*NSString *valueToSave = @"yes";
            [[NSUserDefaults standardUserDefaults]
             setObject:valueToSave forKey:@"udid"];*/
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:lvo.userid forKey:@"loggedin"];
            [prefs synchronize];
            
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:userNameText.text forKey:@"username"];
            [prefsusername synchronize];
            
            NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
            [prefspassword setObject:userPasswordText.text forKey:@"password"];
            [prefspassword synchronize];
            
            NSUserDefaults *prefsProfileImg = [NSUserDefaults standardUserDefaults];
            [prefsProfileImg setObject:appDelegate.loginDetails.profileImage forKey:@"profileImage"];
            [prefsProfileImg synchronize];
            
            NSUserDefaults *prefsFIRSTNAME = [NSUserDefaults standardUserDefaults];
            [prefsFIRSTNAME setObject:appDelegate.loginDetails.firstname forKey:@"firstName"];
            [prefsFIRSTNAME synchronize];
            
            NSUserDefaults *prefslastName = [NSUserDefaults standardUserDefaults];
            [prefslastName setObject:appDelegate.loginDetails.lastname forKey:@"lastName"];
            [prefslastName synchronize];
            
            NSUserDefaults *prefstimezone = [NSUserDefaults standardUserDefaults];
            [prefstimezone setObject:appDelegate.loginDetails.timezone forKey:@"timezone"];
            [prefstimezone synchronize];

                        [appDelegate getCountryData];
                        [appDelegate getDataSMD];
                        [appDelegate getDataCED];
                        [appDelegate getDataATASMMD];
                        
                        
                        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                        appDelegate.index=0;
                        [self.navigationController pushViewController:mainvc animated:YES];
                            }
                        }
                    }
                }];
            }
        }
}
-(IBAction)registerAction{
    RegisterViewController *rvc=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:rvc animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults]  objectForKey:@"udid"]== nil){
        }
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
