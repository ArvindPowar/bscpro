//
//  DashboardViewController.m
//  Chatapp
//
//  Created by arvind on 9/21/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "DashboardViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import "DashboardVO.h"
#import "UIColor+Expanded.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController
@synthesize appDelegate,LblTxt1,LblTxt2,LblTxt3,LblTxt4,LblTxt5,LblTxt6,activityIndicator,dbVO,alldashboardData,iconLbl1,iconLbl2,iconLbl3,iconLbl4,iconLbl5,iconLbl6,CountLbl1,CountLbl2,CountLbl3,CountLbl4,CountLbl5,CountLbl6,backLbl1,backLbl2,backLbl3,backLbl4,backLbl5,backLbl6,scrollView,timer;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];

    appDelegate=[[UIApplication sharedApplication] delegate];
    
    alldashboardData=[[NSMutableArray alloc]init];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Dashboard"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    //self.navigationItem.title=@"Users";
    
    //searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0,200, 40)];
    //[self.view addSubview:searchBar];
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yzheight = [UIScreen mainScreen].bounds.size.height;
    if(yzheight>=568){
        scrollView.contentSize=CGSizeMake(width, yzheight+500);
    }else{
        scrollView.contentSize=CGSizeMake(width, yzheight+630);
    }
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.center= CGPointMake(self.scrollView.frame.size.width / 2.0, self.scrollView.frame.size.height / 2.0);
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    refreshControl.tintColor = [UIColor blackColor];
    [scrollView addSubview:refreshControl];

    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer]; 
    if (appDelegate.indexs==0){
        [revealController revealToggle:@""];
        appDelegate.indexs=1;
    }
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation.png"]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden=NO;
    [self dashboardDaTA];
    // Do any additional setup after loading the view from its nib.
}
-(void)handleRefresh:(UIRefreshControl *)refresh {
    [self dashboardDaTA];
 [refresh endRefreshing];
}
-(void)viewDidAppear:(BOOL)animated{
    //timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(dashboardDaTA) userInfo:nil repeats: YES];
    

}
-(void)viewDidDisappear:(BOOL)animated{
    [timer invalidate];

}

- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dashboardDaTA{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/dashbord_api/dashboard_widget"];
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
                            NSDictionary *speedfilterArray = [userDict objectForKey:@"speedfilter"];
                            NSDictionary *pointsArray = [userDict objectForKey:@"points"];
                            NSDictionary *captainslistArray = [userDict objectForKey:@"captainslist"];
                            NSDictionary *licenseArray = [userDict objectForKey:@"license"];
                            NSDictionary *BPMeventregistrationArray = [userDict objectForKey:@"BPMeventregistration"];
                            NSDictionary *BPMattendanceArray = [userDict objectForKey:@"BPMattendance"];
                           
                            if ([userDict objectForKey:@"speedfilter"] != [NSNull null]){
                                NSString *imagstrs=[[NSString alloc]init];
                                
                                imagstrs=[NSString stringWithFormat:@"%@",[speedfilterArray objectForKey:@"filtercount"]];
                                CountLbl1.text=imagstrs;
                                [CountLbl1 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];
                                CountLbl1.textColor=[UIColor whiteColor];
                                
                                NSString *imagstr=[[NSString alloc]init];
                                imagstr=[speedfilterArray objectForKey:@"filtericon"];
                                NSString *uppercaseTitle=[[NSString alloc]init];
                                uppercaseTitle=[speedfilterArray objectForKey:@"filtertitle"];
                                NSString *username1 = [uppercaseTitle uppercaseString];

                                LblTxt1.text=username1;
                                LblTxt1.lineBreakMode = NSLineBreakByWordWrapping;
                                LblTxt1.numberOfLines = 0;
                                [LblTxt1 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];

                                iconLbl1.font = [UIFont fontWithName:@"FontAwesome" size:40];
                                iconLbl1.text = @"\uf0b0";
                                iconLbl1.textColor=[UIColor whiteColor];

                                NSString *colorsstr=[[NSString alloc]init];
                                colorsstr=[speedfilterArray objectForKey:@"filtercolor"];

                                backLbl1.backgroundColor=[UIColor colorWithHexString:colorsstr];
                            }
                            if ([userDict objectForKey:@"points"] != [NSNull null]){
                                NSString *imagstrs=[[NSString alloc]init];
                                
                                imagstrs=[NSString stringWithFormat:@"%@",[pointsArray objectForKey:@"pointcount"]];
                                if (![imagstrs isEqualToString:@"<null>"]) {
                                     CountLbl2.text=imagstrs;
                                }
                               
                                [CountLbl2 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];
                                CountLbl2.textColor=[UIColor whiteColor];

                                NSString *imagstr=[[NSString alloc]init];
                               imagstr=[pointsArray objectForKey:@"pointicon"];
                                NSString *uppercaseTitle=[[NSString alloc]init];
                                uppercaseTitle=[pointsArray objectForKey:@"pointtitle"];
                                NSString *username1 = [uppercaseTitle uppercaseString];

                                LblTxt2.text=username1;
                                LblTxt2.lineBreakMode = NSLineBreakByWordWrapping;
                                LblTxt2.numberOfLines = 0;
                                [LblTxt2 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];

                                iconLbl2.font = [UIFont fontWithName:@"FontAwesome" size:40];
                                iconLbl2.text = @"\uf0d6";
                                iconLbl2.textColor=[UIColor whiteColor];
                                NSString *colorsstr=[[NSString alloc]init];
                               colorsstr=[pointsArray objectForKey:@"pointcolor"];
                                backLbl2.backgroundColor=[UIColor colorWithHexString:colorsstr];
                            }
                            if ([userDict objectForKey:@"captainslist"] != [NSNull null]){
                                NSString *imagstrs=[[NSString alloc]init];
                                
                                imagstrs=[NSString stringWithFormat:@"%@",[captainslistArray objectForKey:@"captainscount"]];
                                CountLbl3.text=imagstrs;
                                [CountLbl3 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];
                                CountLbl3.textColor=[UIColor whiteColor];
                                NSString *imagstr=[[NSString alloc]init];
                                imagstr=[captainslistArray objectForKey:@"captainsicon"];
                                NSString *uppercaseTitle=[[NSString alloc]init];
                                uppercaseTitle=[captainslistArray objectForKey:@"captainstitle"];
                                NSString *username1 = [uppercaseTitle uppercaseString];

                                LblTxt3.text=username1;
                                LblTxt3.lineBreakMode = NSLineBreakByWordWrapping;
                                LblTxt3.numberOfLines = 0;
                                [LblTxt3 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];

                                iconLbl3.font = [UIFont fontWithName:@"FontAwesome" size:40];
                                iconLbl3.text= @"\uf13d";
                                iconLbl3.textColor=[UIColor whiteColor];
                                NSString *colorsstr=[[NSString alloc]init];
                                colorsstr=[captainslistArray objectForKey:@"captainscolor"];
                                backLbl3.backgroundColor=[UIColor colorWithHexString:colorsstr];
                            }
                            if ([userDict objectForKey:@"license"] != [NSNull null]){
                                NSString *imagstrs=[[NSString alloc]init];
                                
                                imagstrs=[NSString stringWithFormat:@"%@",[licenseArray objectForKey:@"licensecount"]];
                                CountLbl4.text=imagstrs;
                                [CountLbl4 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];
                                CountLbl4.textColor=[UIColor whiteColor];

                                NSString *imagstr=[[NSString alloc]init];
                                imagstr=[licenseArray objectForKey:@"licenseicon"];
                                NSString *uppercaseTitle=[[NSString alloc]init];
                                uppercaseTitle=[licenseArray objectForKey:@"licensetitle"];
                                NSString *username1 = [uppercaseTitle uppercaseString];

                                LblTxt4.text=username1;
                                LblTxt4.lineBreakMode = NSLineBreakByWordWrapping;
                                LblTxt4.numberOfLines = 0;
                                [LblTxt4 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];

                                iconLbl4.font = [UIFont fontWithName:@"FontAwesome" size:40];
                                iconLbl4.text = @"\uf0a3";
                                iconLbl4.textColor=[UIColor whiteColor];
                                
                                NSString *colorsstr=[[NSString alloc]init];
                               colorsstr=[licenseArray objectForKey:@"licensecolor"];
                                backLbl4.backgroundColor=[UIColor colorWithHexString:colorsstr];

                            }
                            if ([userDict objectForKey:@"BPMeventregistration"] != [NSNull null]){
                                NSString *imagstrs=[[NSString alloc]init];
                                
                                imagstrs=[NSString stringWithFormat:@"%@",[BPMeventregistrationArray objectForKey:@"BPMeventregistrationcount"]];
                                CountLbl5.text=imagstrs;
                                [CountLbl5 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];
                                CountLbl5.textColor=[UIColor whiteColor];

                                NSString *imagstr=[[NSString alloc]init];
                                imagstr=[BPMeventregistrationArray objectForKey:@"BPMeventregistrationicon"];
                                NSString *uppercaseTitle=[[NSString alloc]init];
                                uppercaseTitle=[BPMeventregistrationArray objectForKey:@"BPMeventregistrationtitle"];
                                NSString *username1 = [uppercaseTitle uppercaseString];

                                LblTxt5.text=username1;
                                LblTxt5.lineBreakMode = NSLineBreakByWordWrapping;
                                LblTxt5.numberOfLines = 0;
                                [LblTxt5 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];

                                iconLbl5.font = [UIFont fontWithName:@"FontAwesome" size:40];
                                iconLbl5.text  = @"\uf145";
                               iconLbl5.textColor=[UIColor whiteColor];


                                NSString *colorsstr=[[NSString alloc]init];
                                colorsstr=[BPMeventregistrationArray objectForKey:@"BPMeventregistrationcolor"];
                                backLbl5.backgroundColor=[UIColor colorWithHexString:colorsstr];

                            }
                            if ([userDict objectForKey:@"BPMattendance"] != [NSNull null]){
                                NSString *imagstrs=[[NSString alloc]init];
                                
                                imagstrs=[NSString stringWithFormat:@"%@",[BPMattendanceArray objectForKey:@"BPMattendancecount"]];
                                CountLbl6.text=imagstrs;
                                [CountLbl6 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];
                                CountLbl6.textColor=[UIColor whiteColor];

                                NSString *imagstr=[[NSString alloc]init];
                                imagstr=[BPMattendanceArray objectForKey:@"BPMattendanceicon"];
                                NSString *uppercaseTitle=[[NSString alloc]init];
                                uppercaseTitle=[BPMattendanceArray objectForKey:@"BPMattendancetitle"];
                                NSString *username1 = [uppercaseTitle uppercaseString];
                                LblTxt6.text=username1;
                                LblTxt6.lineBreakMode = NSLineBreakByWordWrapping;
                                LblTxt6.numberOfLines = 0;
                                [LblTxt6 setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:22.0]];

                                iconLbl6.font = [UIFont fontWithName:@"FontAwesome" size:40];
                                iconLbl6.text = @"\uf022";
                                iconLbl6.textColor=[UIColor whiteColor];

                                NSString *colorsstr=[[NSString alloc]init];
                               colorsstr=[BPMattendanceArray objectForKey:@"BPMattendancecolor"];
                                backLbl6.backgroundColor=[UIColor colorWithHexString:colorsstr];

                            }
                            [activityIndicator stopAnimating];
                    }
                    }
                }
            }];
    }
    [activityIndicator stopAnimating];
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
