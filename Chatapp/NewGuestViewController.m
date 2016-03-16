//
//  NewGuestViewController.m
//  Chatapp
//
//  Created by arvind on 7/15/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "NewGuestViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import "BpmDateViewController.h"
#import "ModelTraineeSearchViewController.h"
#import "BusinessVO.h"
@interface NewGuestViewController ()

@end

@implementation NewGuestViewController
@synthesize questFirstnameTxt,questLastnameTxt,phoneTxt,epmdateTxt,invitedfistnmTxt,invitedLastnmTxt,addLbl,questNameLbl,phoneLbl,epmdateLbl,invitedLbl,saveBtn,datepicker,starttime,theDate,timeDuration,bgimage,viewUp,dateToobar,activityIndicator,userlistTableView,lblarray,dateString,scrollView,bpmSelectTxt,bpmVo,bpmDateArray,appDelegate,emailTxt,bpmTxt,smdLbletc,smdCheckStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    appDelegate.bpmuseridStr=[[NSString alloc]init];
    appDelegate.bpmLocationStr=[[NSString alloc]init];
    appDelegate.tranieeStr=[[NSString alloc]init];
    lblarray=[[NSMutableArray alloc]initWithObjects:@"GUEST NAME",@"",@"EMAIL",@"PHONE",@"BPM DATE",@"",@"INVITED BY",@"",@"",@"",nil];
    [questFirstnameTxt setDelegate:self];
    [questLastnameTxt setDelegate:self];
    [phoneTxt setDelegate:self];
    [epmdateTxt setDelegate:self];
    [invitedfistnmTxt setDelegate:self];
    [invitedLastnmTxt setDelegate:self];
    [bpmSelectTxt setDelegate:self];
    
    appDelegate.bpmDateArray=[[NSMutableArray alloc]init];
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"ADD NEW GUEST"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;

    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    NSUserDefaults *prefstimezone = [NSUserDefaults standardUserDefaults];
    NSString *formDate=[[NSString alloc]init];
    formDate=[prefstimezone objectForKey:@"timezone"];
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:formDate];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:@"MM/dd/YYYY"];
    theDate = [dateFormat stringFromDate:[NSDate date]];
    
    //datepicker.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    CGFloat yheight = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
    if(yheight>=568){
        //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        bgimage.image=[UIImage imageNamed:@"background.png"];
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        
    }else{
        bgimage.image=[UIImage imageNamed:@"background.png"];
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
    }
    }
    
    epmdateTxt.layer.borderColor=[[UIColor blackColor]CGColor];
    dateToobar.hidden=YES;
    
    datepicker.hidden=YES;
    datepicker.backgroundColor = [UIColor whiteColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yzheight = [UIScreen mainScreen].bounds.size.height;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
    if(height>=480 && height<568){
        scrollView.contentSize=CGSizeMake(width, yzheight+650);

        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];

        userlistTableView.frame=CGRectMake(20,0,self.view.bounds.size.width,self.view.bounds.size.height-50);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
    }else if(height>=568 && height<600){
        scrollView.contentSize=CGSizeMake(width, yzheight+450);

        userlistTableView.frame=CGRectMake(20,0,self.view.bounds.size.width,self.view.bounds.size.height-50);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
        
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
    }else{
        scrollView.contentSize=CGSizeMake(width, yzheight+350);

    }
    }
       userlistTableView.delegate = self;
    userlistTableView.dataSource = self;
    userlistTableView.scrollEnabled = NO;
    [self BpmDatePost];
    [self getInvitedData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    bpmSelectTxt.text=appDelegate.bpmLocationStr;
    if ([appDelegate.bpmDateArray count]==0) {
        [self BpmDatePost];
    }
    if ([appDelegate.smdTraineeStr isEqualToString: @"Yes"]){
    if (![appDelegate.tranieeStr isEqualToString:@""]) {
        invitedfistnmTxt.text=appDelegate.tranieeStr;
        smdLbletc.hidden=YES;
        bpmTxt.hidden=YES;
        bpmTxt.text=@"";
        smdCheckStr=@"";

    }else{
        if(bpmTxt.hidden==YES)
        {
            appDelegate.smdTraineeStr=@"";
            smdLbletc.hidden=NO;
            bpmTxt.hidden=NO;
            smdCheckStr=@"Yes";
            invitedfistnmTxt.text=appDelegate.traineeId;

        }
        
    }

    }

}
- (void)viewWillDisappear:(BOOL)animated {
    appDelegate.tranieeStr=@"";
    appDelegate.traineeId=@"";
    appDelegate.smdTraineeStr=@"";
    invitedfistnmTxt.text=@"";
}
-(void)doneWithNumberPad{
    [phoneTxt resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==phoneTxt){
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = [currentString length];
        if (length > 12) {
            return NO;
        }
    }
    int length = [self getLength:phoneTxt.text];
    if(length == 12) {
        if(range.length == 0)
            return NO;
    }
    if(length == 3){
        NSString *num = [self formatNumber:phoneTxt.text];
        phoneTxt.text = [NSString stringWithFormat:@"%@-",num];
        if(range.length > 0) {
            phoneTxt.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
    } else if(length == 6) {
        NSString *num = [self formatNumber:phoneTxt.text];
        phoneTxt.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0) {
            phoneTxt.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
       }
    return YES;
}
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}
-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [invitedfistnmTxt resignFirstResponder];

     if(textField==epmdateTxt){
         [epmdateTxt resignFirstResponder];
        if(viewUp==YES){
            viewUp=NO;
            //[self animateTextView:NO];
        }
        if(viewUp==NO){
            viewUp=YES;
            //[self animateTextView:YES];
        }
        dateToobar.hidden=YES;
         if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
             dateToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,307,self.view.bounds.size.width,44)];
             
         }else{
             dateToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,615,self.view.bounds.size.width,44)];
             
         }

        [dateToobar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPresseds)];
        dateToobar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:dateToobar];
        
        dateToobar.hidden=NO;
        datepicker.hidden=NO;
         datepicker.timeZone = [NSTimeZone timeZoneWithName: @"PST"];
        
        return NO;
    }
     else if (textField==bpmSelectTxt){
         [bpmSelectTxt resignFirstResponder];
         if ([appDelegate.bpmDateArray count]==0) {
             [self BpmDatePost];

         }else{
             
             BpmDateViewController *bpmDateVc;
             if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

             bpmDateVc=[[BpmDateViewController alloc] initWithNibName:@"BpmDateViewController" bundle:nil];
             }else{
                 bpmDateVc=[[BpmDateViewController alloc] initWithNibName:@"BpmDateViewController~ipad" bundle:nil];

             }
             [self presentViewController:bpmDateVc animated:YES completion:nil];
         }
         return NO;
     }
     else if (textField==invitedfistnmTxt){
         [invitedfistnmTxt resignFirstResponder];
         if ([appDelegate.traineeListArray count]==0) {
             [invitedfistnmTxt resignFirstResponder];
             [self getInvitedData];
             
         }else{
             ModelTraineeSearchViewController *modelvc;
             if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

             modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController" bundle:nil];
             }else{
                 modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController~ipad" bundle:nil];

             }
             [self presentViewController:modelvc animated:YES completion:nil];
         }
         return NO;
     }
    dateToobar.hidden=YES;
       datepicker.hidden=YES;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)doneBtnPresseds{
    
    NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
    [f2 setDateFormat:@"LL/dd/YYYY"];
    NSString *s = [f2 stringFromDate:datepicker.date];
    //epmdateTxt.text=[[NSString alloc]initWithFormat:@"%@",s];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"PST"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateString = [dateFormatter stringFromDate:datepicker.date];
    epmdateTxt.text=[dateFormatter stringFromDate:datepicker.date];
    dateToobar.hidden=YES;
    datepicker.hidden=YES;
    [self BpmDatePost];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}

-(void)getInvitedData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getUserlist"];
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
                    [activityIndicator stopAnimating];
                }else{
                    appDelegate.traineeListArray=[[NSMutableArray alloc]init];
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
                    
                    NSArray *userArray = [userDict objectForKey:@"userlist"];
                    for (int count=0; count<[userArray count]; count++) {
                        
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        BusinessVO *bvo=[[BusinessVO alloc] init];
                        
                        bvo.user_id=[[NSString alloc] init];
                        bvo.fname=[[NSString alloc] init];
                        bvo.lname=[[NSString alloc] init];
                        bvo.username=[[NSString alloc] init];
                        bvo.agentcode=[[NSString alloc] init];
                        
                        if ([activityData objectForKey:@"id"] != [NSNull null])
                            bvo.user_id=[activityData objectForKey:@"id"];
                        bvo.username=[activityData objectForKey:@"username"];
                        bvo.fname=[activityData objectForKey:@"firstname"];
                        bvo.lname=[activityData objectForKey:@"lastname"];
                        NSString *tempagentid = [[NSString alloc] initWithFormat:@"(%@)",[activityData objectForKey:@"agent_id"]];
                        bvo.agentcode=tempagentid;
                        
                        [appDelegate.traineeListArray addObject:bvo];
                    }
                    [activityIndicator stopAnimating];
                }
            }
        }];
    }
}

-(void)BpmDatePost{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];

    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        
    }else{
        appDelegate.bpmDateArray=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@&user_id=%@&bpm_date=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],[prefs objectForKey:@"loggedin"],epmdateTxt.text]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/captains_api/selectbpmoffice"];
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
                        [activityIndicator stopAnimating];
                }else{
                    appDelegate.bpmDateArray=[[NSMutableArray alloc]init];
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

                        NSArray *userArray = [userDict objectForKey:@"BPMList"];
                        for (int count=0; count<[userArray count]; count++) {
                            
                            NSDictionary *activityData=[userArray objectAtIndex:count];
                            BPMDateVO *bpmvo=[[BPMDateVO alloc] init];
                            
                            bpmvo.bpm_id=[[NSString alloc] init];
                            bpmvo.bpmLocation=[[NSString alloc] init];
                            
                            if ([activityData objectForKey:@"bpm_id"] != [NSNull null])
                                bpmvo.bpm_id=[activityData objectForKey:@"bpm_id"];
                            bpmvo.bpmLocation=[activityData objectForKey:@"bpm_office"];
                            
                            [appDelegate.bpmDateArray addObject:bpmvo];
                        }
                    if([appDelegate.bpmDateArray count]>0){
                        BPMDateVO *bpmvo=[appDelegate.bpmDateArray objectAtIndex:0];
                            appDelegate.bpmuseridStr=bpmvo.bpm_id;
                            bpmSelectTxt.text=bpmvo.bpmLocation;
                        appDelegate.bpmLocationStr=bpmvo.bpmLocation;
                    }
                    }
                   [activityIndicator stopAnimating];
                }
        }];
    }
}

-(void)postAllData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];

    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{
        if ([bpmSelectTxt.text isEqual:@"No BPMs On This Day"]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"There are no BPMs on that date, Guest can not be added!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            [activityIndicator stopAnimating];

            }else if ([bpmSelectTxt.text isEqual:@"Please select BPM location"]){
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Please select BPM location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [activityIndicator stopAnimating];

            }else{
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            if([questFirstnameTxt.text isEqualToString:@""] || [questLastnameTxt.text isEqualToString:@""] || [phoneTxt.text isEqualToString:@""] ||[invitedfistnmTxt.text isEqualToString:@""]  || [appDelegate.bpmuseridStr isEqualToString:@""]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"All fields are mandatory.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [activityIndicator stopAnimating];

            }else{
                NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
                [f2 setDateFormat:@"LL/dd/YYYY"];
                NSString *s = [f2 stringFromDate:datepicker.date];
                //epmdateTxt.text=[[NSString alloc]initWithFormat:@"%@",s];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
               // [dateFormatter setTimeZone:timeZone];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                //dateString = [dateFormatter stringFromDate:datepicker.date];
                
                NSURL *url;
                NSMutableString *httpBodyString;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                
                NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
                NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
                httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&guest_fname=%@&guest_lname=%@&guest_email=%@&phone=%@&bpm_date=%@&userlist=%@&BPM_SMD=%@&bpm_id=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],questFirstnameTxt.text,questLastnameTxt.text,emailTxt.text,phoneTxt.text,epmdateTxt.text,appDelegate.traineeId,bpmTxt.text,appDelegate.bpmuseridStr]];
                
                
                NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/captains_api/add_captain"];
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
                                
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Error adding new guest, Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                            }else if([status isEqualToString:@"ok"]){
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"New guest added successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                                [userlistTableView reloadData];
                            }
                            NSLog(@"contents : %@",content);
                        }
                    }
                    [activityIndicator stopAnimating];
                }];
            }
        }
    }
}
-(void)clearData{
    questFirstnameTxt.text=@"";
    questLastnameTxt.text=@"";
    phoneTxt.text=@"";
    epmdateTxt.text=@"";
    invitedfistnmTxt.text=@"";
    invitedLastnmTxt.text=@"";
   }

-(IBAction)postData{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if(![emailTxt.text isEqualToString:@""])
        
    {
        if([emailTest evaluateWithObject:emailTxt.text] == NO)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BSCPRO!" message:@"The email field must contain a vaild email address.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [activityIndicator stopAnimating];
        }else{
            [self smdCheck];

        }
        
    }else{
        [self smdCheck];

    }
    
}
-(void)smdCheck{
    if ([smdCheckStr isEqualToString:@"Yes"]){
        if ([bpmTxt.text isEqualToString:@""]) {
    
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"All fields are mandatory.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }else{
            [self postAllData];
            smdCheckStr=@"";
        }
        
    }else{
        [self postAllData];

    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [lblarray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Let's set some custom cell options.
    // Set the cell's background.
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(height>=480 && height<568){
        UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,5,130,55)];
        [fieldLBls setText:[lblarray objectAtIndex:[indexPath row]]];
        fieldLBls.textAlignment=NSTextAlignmentLeft;
        fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
        fieldLBls.numberOfLines = 0;
        [fieldLBls setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        [cell.contentView addSubview:fieldLBls];
        if(indexPath.row==0){
            questFirstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            questFirstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            questFirstnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:questFirstnameTxt];
            questFirstnameTxt.delegate = self;
            questFirstnameTxt.placeholder=@"First Name";
        }else if(indexPath.row==1){
            questLastnameTxt= [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            questLastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            questLastnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:questLastnameTxt];
            questLastnameTxt.delegate = self;
            questLastnameTxt.placeholder=@"Last Name";
        }else if(indexPath.row==2){
            emailTxt= [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            emailTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:emailTxt];
            emailTxt.delegate = self;
            emailTxt.placeholder=@"Email";
        }else if(indexPath.row==3){
            phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            phoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            phoneTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:phoneTxt];
            phoneTxt.delegate = self;
            phoneTxt.placeholder=@"888-888-8888";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            phoneTxt.inputAccessoryView = numberToolbar;
        }else if(indexPath.row==4){
            epmdateTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            epmdateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            epmdateTxt.textAlignment=NSTextAlignmentRight;
             epmdateTxt.text=theDate;
            [cell.contentView addSubview:epmdateTxt];
            epmdateTxt.delegate = self;
            epmdateTxt.placeholder=@"BPM DATE";
            epmdateTxt.text=theDate;

            
        }else if(indexPath.row==5){
            bpmSelectTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            bpmSelectTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            bpmSelectTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:bpmSelectTxt];
            bpmSelectTxt.delegate = self;
            if([appDelegate.bpmDateArray count]==0)
                bpmSelectTxt.text=@"No BPMs On This Day";
            else
                bpmSelectTxt.text=@"Please select one BPM Location";
        }else if(indexPath.row==6){
            invitedfistnmTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            invitedfistnmTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            invitedfistnmTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:invitedfistnmTxt];
            invitedfistnmTxt.delegate = self;
            invitedfistnmTxt.placeholder=@"Select users";
            
        }else if(indexPath.row==7){
            smdLbletc = [[UILabel alloc] initWithFrame:CGRectMake(15,0,150,60)];
            [smdLbletc setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            smdLbletc.text=@"SMD";
            [cell.contentView addSubview:smdLbletc];
            smdLbletc.hidden=YES;
            bpmTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            bpmTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            bpmTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:bpmTxt];
            bpmTxt.delegate = self;
            bpmTxt.hidden=YES;
            
            
        }else if(indexPath.row==9){
            saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [saveBtn setTitle:@"ADD TO TRACKER" forState:UIControlStateNormal];
            [saveBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [saveBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [saveBtn removeFromSuperview];
            [cell.contentView addSubview:saveBtn];
        }

    }else if(height>=568 && height<600){
    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,5,130,55)];
    [fieldLBls setText:[lblarray objectAtIndex:[indexPath row]]];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    [fieldLBls setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
    [cell.contentView addSubview:fieldLBls];
    if(indexPath.row==0){
        questFirstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        questFirstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        questFirstnameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:questFirstnameTxt];
        questFirstnameTxt.delegate = self;
        questFirstnameTxt.placeholder=@"First Name";
    }else if(indexPath.row==1){
        questLastnameTxt= [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        questLastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        questLastnameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:questLastnameTxt];
        questLastnameTxt.delegate = self;
        questLastnameTxt.placeholder=@"Last Name";
    }else if(indexPath.row==2){
        emailTxt= [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        emailTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:emailTxt];
        emailTxt.delegate = self;
        emailTxt.placeholder=@"Email";
    }else if(indexPath.row==3){
        phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        phoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        phoneTxt.textAlignment=NSTextAlignmentRight;
        [phoneTxt setKeyboardType:UIKeyboardTypeNumberPad];
        [cell.contentView addSubview:phoneTxt];
        phoneTxt.delegate = self;
        phoneTxt.placeholder=@"888-888-8888";
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        phoneTxt.inputAccessoryView = numberToolbar;
    }else if(indexPath.row==4){
        epmdateTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        epmdateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        epmdateTxt.textAlignment=NSTextAlignmentRight;
         epmdateTxt.text=theDate;
        [cell.contentView addSubview:epmdateTxt];
        epmdateTxt.delegate = self;
        epmdateTxt.placeholder=@"BPM DATE";
        epmdateTxt.text=theDate;

    }else if(indexPath.row==5){
        bpmSelectTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        bpmSelectTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        bpmSelectTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:bpmSelectTxt];
        bpmSelectTxt.delegate = self;
        bpmSelectTxt.placeholder=@"No BPMs On This Day";
        
    }else if(indexPath.row==6){
        invitedfistnmTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        invitedfistnmTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        invitedfistnmTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:invitedfistnmTxt];
        invitedfistnmTxt.delegate = self;
        invitedfistnmTxt.placeholder=@"Select users";
        
    }else if(indexPath.row==7){
        smdLbletc = [[UILabel alloc] initWithFrame:CGRectMake(15,0,150,60)];
        [smdLbletc setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        smdLbletc.text=@"SMD";
        [cell.contentView addSubview:smdLbletc];
        smdLbletc.hidden=YES;
        bpmTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        bpmTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        bpmTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:bpmTxt];
        bpmTxt.delegate = self;
        bpmTxt.hidden=YES;
        
        
    }else if(indexPath.row==9){
        saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
        [saveBtn setTitle:@"ADD TO TRACKER" forState:UIControlStateNormal];
        [saveBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn removeFromSuperview];
        [cell.contentView addSubview:saveBtn];
    }
    }else{
        UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,5,130,55)];
        [fieldLBls setText:[lblarray objectAtIndex:[indexPath row]]];
        fieldLBls.textAlignment=NSTextAlignmentLeft;
        fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
        fieldLBls.numberOfLines = 0;
        [fieldLBls setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        [cell.contentView addSubview:fieldLBls];
        if(indexPath.row==0){
            questFirstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            questFirstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            questFirstnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:questFirstnameTxt];
            questFirstnameTxt.delegate = self;
            questFirstnameTxt.placeholder=@"First Name";
        }else if(indexPath.row==1){
            questLastnameTxt= [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            questLastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            questLastnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:questLastnameTxt];
            questLastnameTxt.delegate = self;
            questLastnameTxt.placeholder=@"Last Name";
        }else if(indexPath.row==2){
            emailTxt= [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            emailTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:emailTxt];
            emailTxt.delegate = self;
            emailTxt.placeholder=@"Email";
        }else if(indexPath.row==3){
            phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            phoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            phoneTxt.textAlignment=NSTextAlignmentRight;
            [phoneTxt setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.contentView addSubview:phoneTxt];
            phoneTxt.delegate = self;
            phoneTxt.placeholder=@"888-888-8888";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            phoneTxt.inputAccessoryView = numberToolbar;
        }else if(indexPath.row==4){
            epmdateTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            epmdateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            epmdateTxt.textAlignment=NSTextAlignmentRight;
             epmdateTxt.text=theDate;
            [cell.contentView addSubview:epmdateTxt];
            epmdateTxt.delegate = self;
            epmdateTxt.placeholder=@"BPM DATE";
            epmdateTxt.text=theDate;

        }else if(indexPath.row==5){
            bpmSelectTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            bpmSelectTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            bpmSelectTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:bpmSelectTxt];
            bpmSelectTxt.delegate = self;
            bpmSelectTxt.placeholder=@"No BPMs On This Day";
            
        }else if(indexPath.row==6){
            invitedfistnmTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            invitedfistnmTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            invitedfistnmTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:invitedfistnmTxt];
            invitedfistnmTxt.delegate = self;
            invitedfistnmTxt.placeholder=@"Select users";
            
        }else if(indexPath.row==7){
            smdLbletc = [[UILabel alloc] initWithFrame:CGRectMake(15,0,150,60)];
            [smdLbletc setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            smdLbletc.text=@"SMD";
            [cell.contentView addSubview:smdLbletc];
            smdLbletc.hidden=YES;
            bpmTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            bpmTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            bpmTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:bpmTxt];
            bpmTxt.delegate = self;
            bpmTxt.hidden=YES;
            
            
        }else if(indexPath.row==9){
            saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [saveBtn setTitle:@"ADD TO TRACKER" forState:UIControlStateNormal];
            [saveBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [saveBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [saveBtn removeFromSuperview];
            [cell.contentView addSubview:saveBtn];
        }

    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@" ", @" ");
            break;
            
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
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
