
//
//  UserListViewController.m
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "UserListViewController.h"
#import "LoginViewController.h"
#import "UserMsgViewController.h"
#import "UserListVO.h"
#import "AsyncImageView.h"
#import "LoginVO.h"
#import "GroupVO.h"
#import "SWRevealViewController.h"
#import "NewuserListViewController.h"
#import "Reachability.h"
#import "UIImage+FontAwesome.h"

@interface UserListViewController ()

@end

@implementation UserListViewController
@synthesize clicktologout,userlistTableView,userListArray,activityIndicator,appDelegate,groupListArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.index=-1;
    // Do any additional setup after loading the view from its nib.
    self.userlistTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.userlistTableView.bounds.size.width, 0.01f)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Messages"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:24];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
      /* UIBarButtonItem *settingActionBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(newUserlist)];
        self.navigationItem.rightBarButtonItem = settingActionBtn;
   */
    
    

    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
    if(height>=480 && height<568){
        //iphone 4
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,430);
        [userlistTableView removeFromSuperview];
        [self.view addSubview:userlistTableView];
    }else if(height>=568 && height<600){
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-200);
        [userlistTableView removeFromSuperview];
        [self.view addSubview:userlistTableView];
        
    }else{
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-100);
        [userlistTableView removeFromSuperview];
        [self.view addSubview:userlistTableView];
    }
    }
   }
-(void)newUserlist{
    NewuserListViewController *nulvc;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        nulvc=[[NewuserListViewController alloc] initWithNibName:@"NewuserListViewController" bundle:nil];
    }else{
        nulvc=[[NewuserListViewController alloc] initWithNibName:@"NewuserListViewController~ipad" bundle:nil];
    }
    [self.navigationController pushViewController:nulvc animated:YES];
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}

-(void)commonMethodGetData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSURL *url;
    NSMutableString *httpBodyString;
    appDelegate.groupListArray=[[NSMutableArray alloc] init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chat_api/userListwebservice/"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
            //[self commonMethodGetData];
             [activityIndicator stopAnimating];
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            NSError *error;
            if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [activityIndicator stopAnimating];
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
                    [activityIndicator stopAnimating];
                }else{
                    if([[userDict objectForKey:@"userlist"] isKindOfClass:[NSArray class]]){
                        NSArray *userArray = [userDict objectForKey:@"userlist"];
                        for (int count=0; count<[userArray count]; count++) {
                            @try {
                                NSDictionary *activityData=[userArray objectAtIndex:count];
                                GroupVO *gvo=[[GroupVO alloc] init];
                                gvo.groupid=[[NSString alloc] init];
                                gvo.userid=[[NSString alloc] init];
                                gvo.username=[[NSString alloc] init];
                                gvo.firstname=[[NSString alloc] init];
                                gvo.lastname=[[NSString alloc] init];
                                gvo.profileImage=[[NSString alloc] init];
                                gvo.groupmemberdetail=[[NSString alloc] init];
                                gvo.groupName=[[NSString alloc] init];
                                gvo.groupIcon=[[NSString alloc] init];
                                gvo.messageid=[[NSString alloc] init];
                                gvo.message=[[NSString alloc] init];
                                gvo.attach_image=[[NSString alloc] init];
                                gvo.attach_file=[[NSString alloc] init];
                                gvo.msg_time=[[NSString alloc] init];
                                if ([activityData objectForKey:@"groupid"] != [NSNull null]){
                                    gvo.groupid=[activityData objectForKey:@"groupid"];
                                    gvo.groupmemberdetail=[activityData objectForKey:@"groupmemberdetail"];
                                    gvo.groupName=[activityData objectForKey:@"groupName"];
                                    gvo.groupIcon=[activityData objectForKey:@"groupIcon"];
                                }
                    gvo.userid=[activityData objectForKey:@"userid"];
                    gvo.username=[activityData objectForKey:@"username"];
                    gvo.firstname=[activityData objectForKey:@"firstname"];
                    gvo.lastname=[activityData objectForKey:@"lastname"];
                    gvo.profileImage=[activityData objectForKey:@"profileImage"];
                    gvo.messageid=[activityData objectForKey:@"messageid"];
                    gvo.message=[activityData objectForKey:@"message"];
                    gvo.attach_image=[activityData objectForKey:@"attach_image"];
                    gvo.attach_file=[activityData objectForKey:@"attach_file"];
                    gvo.msg_time=[activityData objectForKey:@"msg_time"];
                    
                    [appDelegate.groupListArray addObject:gvo];
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@", e);
                    NSDictionary *activityData=[userArray objectAtIndex:count];
                    GroupVO *gvo=[[GroupVO alloc] init];
                    gvo.groupid=[[NSString alloc] init];
                    gvo.userid=[[NSString alloc] init];
                    gvo.username=[[NSString alloc] init];
                    gvo.firstname=[[NSString alloc] init];
                    gvo.lastname=[[NSString alloc] init];
                    gvo.profileImage=[[NSString alloc] init];
                    gvo.groupmemberdetail=[[NSString alloc] init];
                    gvo.groupName=[[NSString alloc] init];
                    gvo.groupIcon=[[NSString alloc] init];
                    gvo.messageid=[[NSString alloc] init];
                    gvo.message=[[NSString alloc] init];
                    gvo.attach_image=[[NSString alloc] init];
                    gvo.attach_file=[[NSString alloc] init];
                    gvo.msg_time=[[NSString alloc] init];
                    if ([activityData objectForKey:@"groupid"] != [NSNull null]){
                        gvo.groupid=[activityData objectForKey:@"groupid"];
                        gvo.groupmemberdetail=[activityData objectForKey:@"groupmemberdetail"];
                        gvo.groupName=[activityData objectForKey:@"groupName"];
                        gvo.groupIcon=[activityData objectForKey:@"groupIcon"];
                    }
                    gvo.userid=[activityData objectForKey:@"userid"];
                    gvo.username=[activityData objectForKey:@"username"];
                    gvo.firstname=[activityData objectForKey:@"firstname"];
                    gvo.lastname=[activityData objectForKey:@"lastname"];
                    gvo.profileImage=[activityData objectForKey:@"profileImage"];
                    gvo.messageid=[activityData objectForKey:@"messageid"];
                    gvo.message=[activityData objectForKey:@"message"];
                    gvo.attach_image=[activityData objectForKey:@"attach_image"];
                    gvo.attach_file=[activityData objectForKey:@"attach_file"];
                    gvo.msg_time=[activityData objectForKey:@"msg_time"];
                    
                    [appDelegate.groupListArray addObject:gvo];
                        }
                    }
                    
                    if ([appDelegate.pushStr isEqualToString:@"yes"]) {
                        appDelegate.pushStr=@"no";
                        GroupVO *gvo=[appDelegate.groupListArray objectAtIndex:0];
                        appDelegate.indexpath=0;
                        UserMsgViewController * umvc = [[UserMsgViewController alloc] initWithNibName:@"UserMsgViewController" bundle:nil];
                        umvc.SelectedIDGroup=[[NSString alloc]init];
                        umvc.selectIDUser=[[NSString alloc]init];
                        umvc.profileimage=[[NSString alloc]init];
                        umvc.SelectedName=[[NSString alloc]init];
                        if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                            NSString* firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
                            umvc.SelectedName=firstlastname;
                            umvc.selectIDUser=gvo.userid;
                            umvc.profileimage=gvo.profileImage;
                        }else{
                            umvc.SelectedIDGroup=gvo.groupid;
                            umvc.SelectedName=gvo.groupName;
                            umvc.profileimage=gvo.groupIcon;
                            
                        }
                        [self.navigationController pushViewController:umvc animated:YES];
                    }else{
                        [userlistTableView reloadData];
                    }
                    NSLog(@"pushString=%@",appDelegate.pushStr);
            [activityIndicator stopAnimating];
                    }else{
            [activityIndicator stopAnimating];            
                    }
            }
            }
        }
    }];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    appDelegate.groupListArray=[[NSMutableArray alloc] init];
    [appDelegate.groupListArray removeAllObjects];
    [userlistTableView reloadData];
    [self commonMethodGetData]; 

   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)logout{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"loggedin"];
    [prefs synchronize];
    LoginViewController * lvc;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        lvc= [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }else{
        lvc= [[LoginViewController alloc] initWithNibName:@"LoginViewController~ipad" bundle:nil];
    }
    [self.navigationController pushViewController:lvc animated:YES];
}
- (NSString *)stripTags:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        tempText = nil;
    }
    return html;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.groupListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    
    NSString *firstlastname=[[NSString alloc]init];
    if(indexPath.row < [appDelegate.groupListArray count]){
        GroupVO *gvo=[appDelegate.groupListArray objectAtIndex:indexPath.row];
        NSString* htmlStr = gvo.message;
        NSString* strWithoutFormatting = [self stripTags:htmlStr];
        NSString* newString = [strWithoutFormatting stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];

        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        if(height>=480 && height<568){
            AsyncImageView *userImageView=[[AsyncImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
            userImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.profileImage]];
                
            }else{
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.groupIcon]];
            }
            [cell.contentView addSubview:userImageView];
            UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(60,3, 150,30)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
                [userTextView setText:firstlastname];
            }else{
                [userTextView setText:gvo.groupName];
            }
            userTextView.font=[UIFont fontWithName:@"Calibri" size:18.0];
            [userTextView setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:userTextView];
            
            UITextView *userTextView1=[[UITextView alloc]initWithFrame:CGRectMake(60,30, 150,42)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                [userTextView1 setText:newString];
            }else {
                [userTextView1 setText:newString];
            }
            userTextView1.font=[UIFont fontWithName:@"Calibri" size:13.0];
            //userTextView1.lineBreakMode = NSLineBreakByWordWrapping;
            //userTextView1.numberOfLines = 0;
            userTextView1.editable=false;

            [cell.contentView addSubview:userTextView1];
            UILabel *msgTime=[[UILabel alloc]initWithFrame:CGRectMake(243,3, 100,40)];
            
            msgTime.font=[UIFont fontWithName:@"Calibri" size:12.0];
            NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
            NSString *fbdate=[NSString stringWithFormat:@"%@",[[gvo.msg_time componentsSeparatedByString:@""] objectAtIndex:0]];
            [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *facebookdate = [fbdateFormat dateFromString:fbdate];
            //[fbdateFormat setTimeZone:[NSTimeZone systemTimeZone]];
            fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
            NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
            long seconds= [self timeDifference:today ToDate:facebookdate];
            long diffinsec=seconds%60;
            diffinsec=seconds/60;
            long minutes=seconds/60;
            diffinsec=diffinsec/60;
            long hours=minutes/60;
            diffinsec=diffinsec/24;
            long days=hours/24;
            long month=days/30;
            long year=month/12;
            if(hours<=1){
                msgTime.text=@"Recently";
            }
            else if(hours<=24){
                msgTime.text=[NSString stringWithFormat:@"%ld hrs Ago",hours];
            }else if(hours<=48){
                msgTime.text=[NSString stringWithFormat:@"Yesterday"];
            }else if(days<=30){
                msgTime.text=[NSString stringWithFormat:@"%ld Days Ago",days];
            }else if(month<=12){
                msgTime.text=[NSString stringWithFormat:@"%ld Month Ago",month];
            }else if(year>=0){
                msgTime.text=[NSString stringWithFormat:@"%ld Year Ago",year];
            }
            msgTime.textColor=[UIColor grayColor];

            [cell.contentView addSubview:msgTime];
        
        }else if(height>=568 && height<600){
    AsyncImageView *userImageView=[[AsyncImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
        userImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
        if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
            [userImageView loadImageFromURL:[NSURL URLWithString:gvo.profileImage]];
        }else{
            [userImageView loadImageFromURL:[NSURL URLWithString:gvo.groupIcon]];
        }
    [cell.contentView addSubview:userImageView];
    
    UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(60,3, 150,30)];
         if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
             firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
              [userTextView setText:firstlastname];
         }else{
              [userTextView setText:gvo.groupName];
         }
    userTextView.font=[UIFont fontWithName:@"Calibri" size:18.0];
        [userTextView setTextColor:[UIColor blackColor]];
    [cell.contentView addSubview:userTextView];
    
    UITextView *userTextView1=[[UITextView alloc]initWithFrame:CGRectMake(60,25, 150,42)];
        if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
            [userTextView1 setText:newString];
        }else {
            [userTextView1 setText:newString];
        }
    userTextView1.font=[UIFont fontWithName:@"Calibri" size:13.0];
    //userTextView1.lineBreakMode = NSLineBreakByWordWrapping;
    //userTextView1.numberOfLines = 0;
            userTextView1.editable=false;
    [cell.contentView addSubview:userTextView1];
    
    UILabel *msgTime=[[UILabel alloc]initWithFrame:CGRectMake(243,3, 100,40)];
        msgTime.font=[UIFont fontWithName:@"Calibri" size:12.0];
    NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
    NSString *fbdate=[NSString stringWithFormat:@"%@",[[gvo.msg_time componentsSeparatedByString:@""] objectAtIndex:0]];
    [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *facebookdate = [fbdateFormat dateFromString:fbdate];
    fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
    NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
            long seconds= [self timeDifference:today ToDate:facebookdate];
            long diffinsec=seconds%60;
            diffinsec=seconds/60;
            long minutes=seconds/60;
            diffinsec=diffinsec/60;
            long hours=minutes/60;
            diffinsec=diffinsec/24;
            long days=hours/24;
            long month=days/30;
            long year=month/12;
    if(hours<=1){
        msgTime.text=@"Recently";
    }
    else if(hours<=24){
        msgTime.text=[NSString stringWithFormat:@"%ld hrs Ago",hours];
    }else if(hours<=48){
        msgTime.text=[NSString stringWithFormat:@"Yesterday"];
    }else if(days<=30){
        msgTime.text=[NSString stringWithFormat:@"%ld Days Ago",days];
    }else if(month<=12){
        msgTime.text=[NSString stringWithFormat:@"%ld Month Ago",month];
    }else if(year>=0){
        msgTime.text=[NSString stringWithFormat:@"%ld Year Ago",year];
    }
            msgTime.textColor=[UIColor grayColor];

    [cell.contentView addSubview:msgTime];
        }else{
            AsyncImageView *userImageView=[[AsyncImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
            userImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.profileImage]];
            }else{
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.groupIcon]];
            }
            [cell.contentView addSubview:userImageView];
            
            UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(80,3, 150,30)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
                [userTextView setText:firstlastname];
            }else{
                [userTextView setText:gvo.groupName];
            }
            
            userTextView.font=[UIFont fontWithName:@"Calibri" size:18.0];
            [userTextView setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:userTextView];
            
            UITextView *userTextView1=[[UITextView alloc]initWithFrame:CGRectMake(80,30, 150,42)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                [userTextView1 setText:newString];
                
            }else {
                [userTextView1 setText:newString];
                
            }
            userTextView1.font=[UIFont fontWithName:@"Calibri" size:13.0];
           // userTextView1.lineBreakMode = NSLineBreakByWordWrapping;
            //userTextView1.numberOfLines = 0;
            userTextView1.editable=false;

            [cell.contentView addSubview:userTextView1];
            
            UILabel *msgTime=[[UILabel alloc]initWithFrame:CGRectMake(263,3, 100,40)];
            
            //[msgTime setText:ulvo.msg_time];
            msgTime.font=[UIFont fontWithName:@"Calibri" size:12.0];
            NSDateFormatter *fbdateFormat = [[NSDateFormatter alloc] init];
            NSString *fbdate=[NSString stringWithFormat:@"%@",[[gvo.msg_time componentsSeparatedByString:@""] objectAtIndex:0]];
            [fbdateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *facebookdate = [fbdateFormat dateFromString:fbdate];
            //[fbdateFormat setTimeZone:[NSTimeZone systemTimeZone]];
            fbdateFormat.timeZone = [NSTimeZone systemTimeZone];
            NSDate *today=[fbdateFormat dateFromString:[fbdateFormat stringFromDate:[NSDate date]]];
            long seconds= [self timeDifference:today ToDate:facebookdate];
            long diffinsec=seconds%60;
            diffinsec=seconds/60;
            long minutes=seconds/60;
            diffinsec=diffinsec/60;
            long hours=minutes/60;
            diffinsec=diffinsec/24;
            long days=hours/24;
            long month=days/30;
            long year=month/12;
            if(hours<=1){
                msgTime.text=@"Recently";
            }
            else if(hours<=24){
                msgTime.text=[NSString stringWithFormat:@"%ld hrs Ago",hours];
            }else if(hours<=48){
                msgTime.text=[NSString stringWithFormat:@"Yesterday"];
            }else if(days<=30){
                
                msgTime.text=[NSString stringWithFormat:@"%ld Days Ago",days];
            } else if(month<=12){
                msgTime.text=[NSString stringWithFormat:@"%ld Month Ago",month];
            }else if(year>=0){
                msgTime.text=[NSString stringWithFormat:@"%ld Year Ago",year];
            }
            msgTime.textColor=[UIColor grayColor];

            [cell.contentView addSubview:msgTime];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [appDelegate.groupListArray count]){

        GroupVO *gvo=[appDelegate.groupListArray objectAtIndex:indexPath.row];
        appDelegate.indexpath=indexPath.row;
        UserMsgViewController * umvc;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            umvc= [[UserMsgViewController alloc] initWithNibName:@"UserMsgViewController" bundle:nil];

        }else{
            umvc= [[UserMsgViewController alloc] initWithNibName:@"UserMsgViewController~ipad" bundle:nil];

        }
            umvc.SelectedIDGroup=[[NSString alloc]init];
            umvc.selectIDUser=[[NSString alloc]init];
            umvc.profileimage=[[NSString alloc]init];
            umvc.SelectedName=[[NSString alloc]init];
        if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
          NSString* firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
        umvc.SelectedName=firstlastname;
        umvc.selectIDUser=gvo.userid;
        umvc.profileimage=gvo.profileImage;
        }else{
            umvc.SelectedIDGroup=gvo.groupid;
            umvc.SelectedName=gvo.groupName;
            umvc.profileimage=gvo.groupIcon;

        }
        [self.navigationController pushViewController:umvc animated:YES];
        
    }
}
- (int)timeDifference:(NSDate *)fromDate ToDate:(NSDate *)toDate{
    NSTimeInterval distanceBetweenDates = [fromDate timeIntervalSinceDate:toDate];
    
    return distanceBetweenDates;
}

@end
