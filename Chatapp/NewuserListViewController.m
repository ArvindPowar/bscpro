//
//  NewuserListViewController.m
//  Chatapp
//
//  Created by arvind on 8/21/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "NewuserListViewController.h"
#import "Reachability.h"
#import "NewUserVO.h"
#import "AsyncImageView.h"
#import "UserMsgViewController.h"
@interface NewuserListViewController ()

@end

@implementation NewuserListViewController
@synthesize userlistTableView,userListArray,groupListArray,activityIndicator,appDelegate,searchBar,searchBarController;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    
    // Do any additional setup after loading the view from its nib.
    self.userlistTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.userlistTableView.bounds.size.width, 0.01f)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"New Users"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    //self.navigationItem.title=@"Users";
    
    //searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0,200, 40)];
    searchBar.showsCancelButton = YES;
    [searchBar setDelegate:self];
    //[self.view addSubview:searchBar];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation.png"]];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [anotherButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    self.navigationController.navigationBarHidden=NO;
    [self commonMethodGetData];


    // Do any additional setup after loading the view from its nib.
}
- (void)searchTableList {
    NSString *searchString = searchBar.text;
    filteredContentList=[[NSMutableArray alloc]init];
    for (int i=0; i<appDelegate.newuserListArray.count; i++) {
        UserListVO *userVO=[appDelegate.newuserListArray objectAtIndex:i];
        NSComparisonResult result = [userVO.username compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame)
        {
            [filteredContentList addObject:userVO];
        }
    }
    [userlistTableView reloadData];
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length != 0){
        isSearching = YES;
        [self searchTableList];
        
    }else {
        isSearching = NO;
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=appDelegate.newuserListArray;
        // tblContentList.hidden=YES;
    }
    [userlistTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    NSLog(@"Cancel clicked");
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar {
    NSLog(@"Search Clicked");
    if(searchBar.text  !=nil) {
        isSearching = YES;
        [self searchTableList];
    }else {
        isSearching = NO;
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=appDelegate.newuserListArray;
        // tblContentList.hidden=YES;
    }
    [userlistTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)commonMethodGetData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{
        NSURL *url;
        NSMutableString *httpBodyString;
        appDelegate.newuserListArray=[[NSMutableArray alloc] init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chat_api/alluserListwebservice"];
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                NSLog(@"Failed to submit request");
                [activityIndicator stopAnimating];
                [self commonMethodGetData];
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
                        [activityIndicator stopAnimating];
                    }else{
                NSArray *userArray = [userDict objectForKey:@"userlist"];
                for (int count=0; count<[userArray count]; count++) {
                    @try {
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        NewUserVO *gvo=[[NewUserVO alloc] init];
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
                        if ([activityData objectForKey:@"message"] != [NSNull null]){
                            gvo.message=[activityData objectForKey:@"message"];
                        }else{
                            gvo.message=@"";
                        }
                        gvo.attach_image=[activityData objectForKey:@"attach_image"];
                        gvo.attach_file=[activityData objectForKey:@"attach_file"];
                        
                        if ([activityData objectForKey:@"msg_time"] != [NSNull null]){
                            gvo.msg_time=[activityData objectForKey:@"msg_time"];
                        }else{
                            gvo.msg_time=@"";
                        }
                        [appDelegate.newuserListArray addObject:gvo];
                        filteredContentList= [[NSMutableArray alloc] init];
                        filteredContentList=appDelegate.newuserListArray;
                    }
                    @catch (NSException * e) {
                        NSLog(@"Exception: %@", e);
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        NewUserVO *gvo=[[NewUserVO alloc] init];
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
                        if ([activityData objectForKey:@"message"] != [NSNull null]){
                        gvo.message=[activityData objectForKey:@"message"];
                        }else{
                            gvo.message=@"";
                        }
                        gvo.attach_image=[activityData objectForKey:@"attach_image"];
                        gvo.attach_file=[activityData objectForKey:@"attach_file"];
                        gvo.msg_time=[activityData objectForKey:@"msg_time"];
                        
                        [appDelegate.newuserListArray addObject:gvo];
                        }
                    }
                [userlistTableView reloadData];
                [activityIndicator stopAnimating];
                    }
                }
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return [filteredContentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
     NSString *firstlastname=[[NSString alloc]init];
    if(indexPath.row < [filteredContentList count]){
        NewUserVO *gvo=[filteredContentList objectAtIndex:indexPath.row];
        
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
            
            UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 200,40)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                 firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
                [userTextView setText:firstlastname];
            }else{
                [userTextView setText:gvo.groupName];
            }
            userTextView.font=[UIFont fontWithName:@"Calibri" size:16.0];
            [userTextView setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:userTextView];
            
            UITextView *userTextView1=[[UITextView alloc]initWithFrame:CGRectMake(60,30, 150,50)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                //[userTextView1 setText:gvo.message];
                
            }else {
               // [userTextView1 setText:gvo.message];
                
            }
            [userTextView1 setEditable:false];
            [userTextView1 setScrollEnabled:false];
            [cell.contentView addSubview:userTextView1];
            
            
            
           /* UITextView *msgTime=[[UITextView alloc]initWithFrame:CGRectMake(243,3, 100,40)];
            [msgTime setEditable:false];
            if ([gvo.msg_time isEqualToString:@""]) {
                msgTime.text=@"";
            }else{
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
                msgTime.text=[NSString stringWithFormat:@"%ld hrs",hours];
            }else if(hours<=48){
                msgTime.text=[NSString stringWithFormat:@"Yesterday"];
            }else if(days<=30){
                
                msgTime.text=[NSString stringWithFormat:@"%ld Days Ago",days];
            }
            
            [cell.contentView addSubview:msgTime];
            }
        */
            
        }else if(height>=568 && height<600){
            AsyncImageView *userImageView=[[AsyncImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
            userImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.profileImage]];
                
            }else{
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.groupIcon]];
                
            }
            [cell.contentView addSubview:userImageView];
            
            UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(70,10, 200,40)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
                [userTextView setText:firstlastname];
            }else{
                [userTextView setText:gvo.groupName];
            }
            
            userTextView.font=[UIFont fontWithName:@"Calibri" size:18.0];
            [userTextView setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:userTextView];
            
           /* UITextView *userTextView1=[[UITextView alloc]initWithFrame:CGRectMake(60,30, 150,50)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                //[userTextView1 setText:gvo.message];
                
            }else {
                //[userTextView1 setText:gvo.message];
                
            }
            [userTextView1 setEditable:false];
            [userTextView1 setScrollEnabled:false];
            [cell.contentView addSubview:userTextView1];
            */
            
            
           /* UITextView *msgTime=[[UITextView alloc]initWithFrame:CGRectMake(243,3, 100,40)];
            [msgTime setEditable:false];
            if ([gvo.msg_time isEqualToString:@""]) {
                msgTime.text=@"";
            }else{
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
                msgTime.text=[NSString stringWithFormat:@"%ld hrs",hours];
            }else if(hours<=48){
                msgTime.text=[NSString stringWithFormat:@"Yesterday"];
            }else if(days<=30){
                
                msgTime.text=[NSString stringWithFormat:@"%ld Days Ago",days];
            }
            
            [cell.contentView addSubview:msgTime];
            }*/
        }else{
            AsyncImageView *userImageView=[[AsyncImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
            userImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.profileImage]];
                
            }else{
                [userImageView loadImageFromURL:[NSURL URLWithString:gvo.groupIcon]];
                
            }
            [cell.contentView addSubview:userImageView];
            
            UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 200,40)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                firstlastname=[NSString stringWithFormat:@"%@ %@",gvo.firstname,gvo.lastname];
                [userTextView setText:firstlastname];
            }else{
                [userTextView setText:gvo.groupName];
            }
            
            userTextView.font=[UIFont fontWithName:@"Calibri" size:16.0];
            [userTextView setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:userTextView];
            
            UITextView *userTextView1=[[UITextView alloc]initWithFrame:CGRectMake(80,30, 150,50)];
            if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
                //[userTextView1 setText:gvo.message];
                
            }else {
                //[userTextView1 setText:gvo.message];
                
            }
            [userTextView1 setEditable:false];
            [userTextView1 setScrollEnabled:false];
            [cell.contentView addSubview:userTextView1];
            
            
            
           /* UITextView *msgTime=[[UITextView alloc]initWithFrame:CGRectMake(263,3, 100,40)];
            [msgTime setEditable:false];
            if ([gvo.msg_time isEqualToString:@""]) {
                msgTime.text=@"";
            }else{
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
                msgTime.text=[NSString stringWithFormat:@"%ld hrs",hours];
            }else if(hours<=48){
                msgTime.text=[NSString stringWithFormat:@"Yesterday"];
            }else if(days<=30){
                
                msgTime.text=[NSString stringWithFormat:@"%ld Days Ago",days];
            }
            
            [cell.contentView addSubview:msgTime];
            }*/
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [filteredContentList count]){
        
        NewUserVO *gvo=[filteredContentList objectAtIndex:indexPath.row];
        appDelegate.indexpath=indexPath.row;
        UserMsgViewController * umvc = [[UserMsgViewController alloc] initWithNibName:@"UserMsgViewController" bundle:nil];
        umvc.SelectedIDGroup=[[NSString alloc]init];
        umvc.selectIDUser=[[NSString alloc]init];
        umvc.profileimage=[[NSString alloc]init];
        umvc.SelectedName=[[NSString alloc]init];
        if([gvo.groupid isEqualToString:@""] || gvo.groupid==nil){
            umvc.SelectedName=gvo.username;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
