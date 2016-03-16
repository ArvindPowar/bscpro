//
//  AddBusinessViewController.m
//  Chatapp
//
//  Created by arvind on 7/15/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "AddBusinessViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import "ModelTraineeSearchViewController.h"
#import "AddBusAgentSearchViewController.h"
#import "Reachability.h"

@interface AddBusinessViewController ()

@end

@implementation AddBusinessViewController
@synthesize dateTxt,firstnameTxt,lastnameTxt,agentTxt,traineeTxt,productTxt,actualTxt,noteTxt,BusinessLbl,dateLbl,clientNameLbl,agentLbl,traineeLbl,productLbl,actualLbl,noteLbl,AddBtn,datepicker,starttime,theDate,timeDuration,bgimage,viewUp,dateToobar,activityIndicator,agentPickerView,traineePickerView,toolbartrai,toolbaragt,dataArrayAgent,traineeListArray,busVo,useridStrtrai,scrollView,userlistTableView,lblarray,dateString,agentSelectArray,agentTempArray,displayTextView,buttonClose,heightView,heightCellAgent,agentIdArry,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    heightCellAgent=100;
    appDelegate=[[UIApplication sharedApplication] delegate];

lblarray=[[NSMutableArray alloc]initWithObjects:@"DATE",@"CLIENT NAME",@"",@"AGENT(S)",@"TRAINEE",@"PRODUCT",@"ACTUAL POINTS",@"NOTES",@"",nil];
   appDelegate.agentSelectArray=[[NSMutableArray alloc]init];
   appDelegate.agentTempArray=[[NSMutableArray alloc]init];
    appDelegate.agentIdArry=[[NSMutableArray alloc]init];
    [dateTxt setDelegate:self];
    [firstnameTxt setDelegate:self];
    [lastnameTxt setDelegate:self];
    [agentTxt setDelegate:self];
    [traineeTxt setDelegate:self];
    [productTxt setDelegate:self];
    [actualTxt setDelegate:self];
    [noteTxt setDelegate:self];
    //appDelegate.dataArrayAgent=[[NSMutableArray alloc]init];
    //appDelegate.traineeListArray=[[NSMutableArray alloc]init];
    appDelegate.traineeId=[[NSString alloc]init];
    appDelegate.tranieeStr=[[NSString alloc]init];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"ADD BUSINESS"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
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
    [dateFormat setDateFormat:@"LL/dd/YYYY"];
    theDate = [dateFormat stringFromDate:now];
    
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
    
    dateTxt.layer.borderColor=[[UIColor blackColor]CGColor];
    dateToobar.hidden=YES;
    
    datepicker.hidden=YES;
    datepicker.layer.backgroundColor = [UIColor whiteColor].CGColor;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yzheight = [UIScreen mainScreen].bounds.size.height;
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
   
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(height>=480 && height<568){
        scrollView.contentSize=CGSizeMake(width, yzheight+500);

        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+200);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
    }else if(height>=568 && height<600){
        scrollView.contentSize=CGSizeMake(width, yzheight+500);

        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-140);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
        
    }else{
        scrollView.contentSize=CGSizeMake(width, yzheight+200);

    }
    }
    userlistTableView.delegate = self;
    userlistTableView.dataSource = self;
    userlistTableView.scrollEnabled = NO;

  
    // Do any additional setup after loading the view from its nib.
}

-(void)getTrainee{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"There's no internet connection at all.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        NSString *string=[[NSString alloc]init];
        string=@"TA";
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@&user_id=%@&type=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],[prefs objectForKey:@"loggedin"],string]];
        
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
                    NSString *tmpagentid = [[NSString alloc] initWithFormat:@"(%@)",[activityData objectForKey:@"agent_id"]];
                    bvo.agentcode=tmpagentid;
                    
                    [appDelegate.traineeListArray addObject:bvo];
                }
                
                ModelTraineeSearchViewController *modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController" bundle:nil];
                [self presentViewController:modelvc animated:YES completion:nil];

                [activityIndicator stopAnimating];
                
            }
            
        }];
        [activityIndicator stopAnimating];
        
    }
    [activityIndicator stopAnimating];
}


-(void)doneWithNumberPad{
    [actualTxt resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    if (![appDelegate.tranieeStr isEqualToString:@""]) {
        traineeTxt.text=appDelegate.tranieeStr;
        
    }else{
        traineeTxt.text=appDelegate.traineeId;
        
    }
    [self agentfield];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==dateTxt){
        
        if(viewUp==YES){
            viewUp=NO;
            //[self animateTextView:NO];
        }
        
        if(viewUp==NO){
            viewUp=YES;
            //[self animateTextView:YES];
        }
        
        dateToobar.hidden=YES;
        toolbaragt.hidden=YES;
        toolbartrai.hidden=YES;
        dateToobar.hidden=YES;
        
        agentPickerView.hidden=YES;
        traineePickerView.hidden=YES;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            dateToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,307,self.view.bounds.size.width,44)];

        }else{
            dateToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,607,self.view.bounds.size.width,44)];

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

        [dateTxt resignFirstResponder];
        
        return NO;
    }else if(textField==traineeTxt)
    {
        [traineeTxt resignFirstResponder];
        if([appDelegate.traineeListArray count]==0)
        [self getTrainee];
        else{
            appDelegate.checkstr=[[NSString alloc]init];

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
    toolbaragt.hidden=YES;
    toolbartrai.hidden=YES;
    dateToobar.hidden=YES;
    
    agentPickerView.hidden=YES;
    traineePickerView.hidden=YES;

    dateToobar.hidden=YES;
    datepicker.hidden=YES;
    return YES;
}

-(void)pickerOpen{
    AddBusAgentSearchViewController *addSarchVC;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

    addSarchVC=[[AddBusAgentSearchViewController alloc] initWithNibName:@"AddBusAgentSearchViewController" bundle:nil];
    }else{
        addSarchVC=[[AddBusAgentSearchViewController alloc] initWithNibName:@"AddBusAgentSearchViewController~ipad" bundle:nil];

    }
    [self presentViewController:addSarchVC animated:YES completion:nil];
    [agentTxt resignFirstResponder];
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)agentfield{
    toolbaragt.hidden=YES;
    toolbartrai.hidden=YES;
    dateToobar.hidden=YES;
    agentPickerView.hidden=YES;
    traineePickerView.hidden=YES;
    dateToobar.hidden=YES;
    datepicker.hidden=YES;
    [self setButtonmethod];

}
-(IBAction)doneBtnPresseds{
    NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
    [f2 setDateFormat:@"LL/dd/YYYY"];
    NSString *s = [f2 stringFromDate:datepicker.date];
    //dateTxt.text=[[NSString alloc]initWithFormat:@"%@",s];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"PST"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateString = [dateFormatter stringFromDate:datepicker.date];
    dateTxt.text=[dateFormatter stringFromDate:datepicker.date];
    toolbaragt.hidden=YES;
    toolbartrai.hidden=YES;
    dateToobar.hidden=YES;
    
    agentPickerView.hidden=YES;
    traineePickerView.hidden=YES;

    dateToobar.hidden=YES;
    datepicker.hidden=YES;
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

-(void)getAgentCode{
    if([appDelegate.dataArrayAgent count]>0){
        [self ArrayMethod];
    }else{
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
        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getUserlist/"];
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
                        NSString *tempagentcode = [[NSString alloc] initWithFormat:@"(%@)",[activityData objectForKey:@"agent_id"]];
                        bvo.agentcode=tempagentcode;
                        
                        [appDelegate.dataArrayAgent addObject:bvo];
                    }
                }
                 [self ArrayMethod];
                [activityIndicator stopAnimating];
            }
        }];
        
        [activityIndicator stopAnimating];
    }
    [activityIndicator stopAnimating];
    }
}

-(void)postAllData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"There's no internet connection at all.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{
        NSString *agentid=[[NSString alloc]init];
        agentid = [appDelegate.agentIdArry componentsJoinedByString:@","];

    if([firstnameTxt.text isEqualToString:@""] || [lastnameTxt.text isEqualToString:@""] || [agentid isEqualToString:@""] ||[productTxt.text isEqualToString:@""] || [actualTxt.text isEqualToString:@""] || [useridStrtrai isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"All fields are mandatory.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{
    NSURL *url;
    NSMutableString *httpBodyString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    
        NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
        [f2 setDateFormat:@"LL/dd/YYYY"];
        NSString *s = [f2 stringFromDate:datepicker.date];
        dateTxt.text=[[NSString alloc]initWithFormat:@"%@",s];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        //[dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        dateString = [dateFormatter stringFromDate:datepicker.date];
        
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&product_date=%@&client_fname=%@&client_lname=%@&agent_value[]=%@&product_name=%@&actual_point=%@&trainee=%@&notes=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],dateString,firstnameTxt.text,lastnameTxt.text,agentid,productTxt.text,actualTxt.text,appDelegate.traineeId,noteTxt.text]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/product_api"];
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
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSString *messages = [[NSString alloc]init];
            messages = [userDict objectForKey:@"message"];
            NSString *status = [[NSString alloc]init];
            status = [userDict objectForKey:@"status"];
            if([status isEqualToString:@"fail"])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Error adding new business, Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([status isEqualToString:@"ok"]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"New business added successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [userlistTableView reloadData];
                           appDelegate.agentSelectArray=[[NSMutableArray alloc]init];
                appDelegate.agentIdArry=[[NSMutableArray alloc]init];
                appDelegate.tranieeStr=[[NSString alloc]init];
                appDelegate.traineeId=[[NSString alloc]init];

                [userlistTableView reloadData];
            }
            NSLog(@"contents : %@",content);
            [activityIndicator stopAnimating];
        }
    }];
    }
     [activityIndicator stopAnimating];
    }
}
-(void)clearData{
    dateTxt.text=@"";
    firstnameTxt.text=@"";
    lastnameTxt.text=@"";
    agentTxt.text=@"";
    traineeTxt.text=@"";
    productTxt.text=@"";
    actualTxt.text=@"";
    noteTxt.text=@"";
}

-(IBAction)postData{
    [self postAllData];
    
}

-(void)ArrayMethod{
    NSArray *array = [NSArray arrayWithArray:appDelegate.dataArrayAgent];
    NSArray *array1 = [NSArray arrayWithArray:appDelegate.agentSelectArray];
    appDelegate.agentTempArray=[[NSMutableArray alloc]init];
    //[agentPickerView reloadAllComponents];
    for(int i = 0;i<[array count];i++)
    {
        
        BusinessVO *bvo=[array objectAtIndex:i];
        
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        
       
            if(![array1 containsObject:str])
            {
                [appDelegate.agentTempArray addObject:bvo];
            }
    }
    if ([appDelegate.agentSelectArray count]==0) {
        appDelegate.agentIdArry=[[NSMutableArray alloc]init];
    }
    if ([appDelegate.agentSelectArray count]>=2 || [appDelegate.agentIdArry count]>=2) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Only 2 agents can be selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        toolbaragt.hidden=YES;
        agentPickerView.hidden=YES;
        
    }else{
        
        [self pickerOpen];
    }

   

}
-(void)setButtonmethod{
    int height=0;
    
    for(int i = 0;i<[appDelegate.agentSelectArray count];i++)
    {
        buttonClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonClose addTarget:self action:@selector(deleteField:) forControlEvents:UIControlEventTouchUpInside];
        //[button setTitle:@"Show View" forState:UIControlStateNormal];
        [buttonClose setBackgroundImage:[UIImage imageNamed:@"unnamed.png"] forState:UIControlStateNormal];
        buttonClose.tag=i+100;
        buttonClose.frame = CGRectMake(150,height,25,25);
        [displayTextView addSubview:buttonClose];
        
        agentTxt = [[UITextField alloc] initWithFrame:CGRectMake(0,height,150,30)];
        agentTxt.font=[UIFont fontWithName:@"Calibri" size:14.0];
        agentTxt.textAlignment=NSTextAlignmentRight;
        agentTxt.tag=i+200;
        agentTxt.text=[appDelegate.agentSelectArray objectAtIndex:i];
        [displayTextView addSubview:agentTxt];
        agentTxt.delegate = self;
        height=height+35;
        if (i==3) {
            heightView=heightView+30;
            heightCellAgent=heightCellAgent+40;
            }
    }
}

-(void)deleteField:(UIButton*)button{
    int j=button.tag;
    agentTxt=(UITextField*)[displayTextView viewWithTag:j+200];

        [appDelegate.agentSelectArray removeObjectAtIndex:j-100];
        [appDelegate.agentIdArry removeObject:appDelegate.useridagent];
        [button removeFromSuperview];
        [agentTxt removeFromSuperview];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [userlistTableView reloadData];
        [self performSelector:@selector(setButtonmethod) withObject:nil afterDelay:0.2];
    }];
    

}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
    /*if ([pickerView isEqual: agentPickerView]) {
        return [agentTempArray count];
    }*/ if ([pickerView isEqual: traineePickerView]) {
        return [traineeListArray count];
    }
       else{
        return 0;
    }
}


// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    /*if (pickerView ==agentPickerView)
    {
        BusinessVO *bvo=[agentTempArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        useridagent=bvo.user_id;
        NSString *newvlsu=[[NSString alloc]init];
        
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        //newvlsu=[NSString stringWithFormat:@"%@,\n %@",agentTxt.text,str];
        if (useridagent==nil) {
            agentTxt.text=@"";
        }else{
          //agentTxt.text=str;
            if ([agentSelectArray count]<=1 || [agentIdArry count]<=1) {
                [agentSelectArray addObject:str];
                [agentIdArry addObject:useridagent];
            }
            }
        
    }else*/ if (pickerView ==traineePickerView)
        
    {
        BusinessVO *bvo=[traineeListArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
         useridStrtrai=bvo.user_id;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        if (useridStrtrai==nil) {
            traineeTxt.text=@"";
        }else{
            [traineeTxt setText:str];

        }
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    /*if (pickerView == agentPickerView)
    {
            BusinessVO *bvo=[agentTempArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        //newvlsu=[NSString stringWithFormat:@"%@,\n %@",agentTxt.text,str];
        if (useridagent==nil) {
            agentTxt.text=@"";
        }else{
        //[agentTxt setText:str];
        //[agentSelectArray addObject:str];
                  }
        return str;
        
    }else*/ if (pickerView == traineePickerView)
        
    {
        BusinessVO *bvo=[traineeListArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        if (useridStrtrai==nil) {
            traineeTxt.text=@"";
        }else{
            [traineeTxt setText:str];
            
        }

        return str;
    }else{
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        return 0;
    }
    
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = self.view.bounds.size.width;
    
    return componentWidth;
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
            dateTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            dateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            dateTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:dateTxt];
            dateTxt.delegate = self;
            dateTxt.placeholder=@"Select Date";
            dateTxt.text=theDate;

        }else if(indexPath.row==1){
            firstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            firstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            firstnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:firstnameTxt];
            firstnameTxt.delegate = self;
            firstnameTxt.placeholder=@"First Name";
        }else if(indexPath.row==2){
            lastnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            lastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            lastnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:lastnameTxt];
            lastnameTxt.delegate = self;
            lastnameTxt.placeholder=@"Last Name";
        }else if(indexPath.row==3){
            heightView=100;
            displayTextView=[[UIView alloc]initWithFrame:CGRectMake(100, 10,180,heightView)];
            [displayTextView setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:displayTextView];
            UIButton *buttons = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [buttons addTarget:self action:@selector(getAgentCode) forControlEvents:UIControlEventTouchUpInside];
            [buttons setTitle:@"ADD" forState:UIControlStateNormal];
            //[buttons setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
            buttons.frame = CGRectMake(cell.bounds.size.width-40,0,40,30);
            [cell.contentView addSubview:buttons];
            
            
        }else if(indexPath.row==4){
            traineeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            traineeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            traineeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:traineeTxt];
            traineeTxt.delegate = self;
            traineeTxt.text=appDelegate.tranieeStr;
            traineeTxt.placeholder=@"Select TRainee";
            
        }else if(indexPath.row==5){
            productTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            productTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            productTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:productTxt];
            productTxt.delegate = self;
            productTxt.placeholder=@"FFIUL";
            
        }else if(indexPath.row==6){
            
            actualTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            actualTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            actualTxt.textAlignment=NSTextAlignmentRight;
            [actualTxt setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.contentView addSubview:actualTxt];
            actualTxt.delegate = self;
            actualTxt.placeholder=@"Example:4200";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            actualTxt.inputAccessoryView = numberToolbar;
        }else if(indexPath.row==7){
            noteTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            noteTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            noteTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:noteTxt];
            noteTxt.delegate = self;
            noteTxt.placeholder=@"Example: Meds scheduled for 4/15@6pm-recieved 3 referrals";
        }else if(indexPath.row==8){
            AddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width+10,60)];
            [AddBtn setTitle:@"ADD TO TRACKER" forState:UIControlStateNormal];
            [AddBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [AddBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [AddBtn removeFromSuperview];
            [cell.contentView addSubview:AddBtn];
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
        dateTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        dateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        dateTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:dateTxt];
        dateTxt.delegate = self;
        dateTxt.placeholder=@"Select Date";
        dateTxt.text=theDate;

    }else if(indexPath.row==1){
        firstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        firstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        firstnameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:firstnameTxt];
        firstnameTxt.delegate = self;
        firstnameTxt.placeholder=@"First Name";
    }else if(indexPath.row==2){
        lastnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        lastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        lastnameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lastnameTxt];
        lastnameTxt.delegate = self;
        lastnameTxt.placeholder=@"Last Name";
    }else if(indexPath.row==3){
        heightView=100;
        displayTextView=[[UIView alloc]initWithFrame:CGRectMake(100, 10,180,heightView)];
        [displayTextView setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:displayTextView];
        UIButton *buttons = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttons addTarget:self action:@selector(getAgentCode) forControlEvents:UIControlEventTouchUpInside];
        [buttons setTitle:@"ADD" forState:UIControlStateNormal];
        //[buttons setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        buttons.frame = CGRectMake(cell.bounds.size.width-40,0,40,30);
        [cell.contentView addSubview:buttons];

        
    }else if(indexPath.row==4){
        traineeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        traineeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        traineeTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:traineeTxt];
        traineeTxt.delegate = self;
        traineeTxt.text=appDelegate.tranieeStr;
        traineeTxt.placeholder=@"Select Trainee";
        
    }else if(indexPath.row==5){
        productTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        productTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        productTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:productTxt];
        productTxt.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        productTxt.delegate = self;
        productTxt.placeholder=@"FFIUL";
        
    }else if(indexPath.row==6){
        
        actualTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        actualTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        actualTxt.textAlignment=NSTextAlignmentRight;
        [actualTxt setKeyboardType:UIKeyboardTypeNumberPad];
        [cell.contentView addSubview:actualTxt];
        actualTxt.delegate = self;
        actualTxt.placeholder=@"EXAMPLE:4200";
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        actualTxt.inputAccessoryView = numberToolbar;
    }else if(indexPath.row==7){
        noteTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        noteTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        noteTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:noteTxt];
        noteTxt.delegate = self;
        noteTxt.placeholder=@"Example: Meds scheduled for 4/15@6pm-recieved 3 referrals";
    }else if(indexPath.row==8){
        AddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width+10,60)];
        [AddBtn setTitle:@"ADD TO TRACKER" forState:UIControlStateNormal];
        [AddBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [AddBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        [AddBtn removeFromSuperview];
        [cell.contentView addSubview:AddBtn];
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
            dateTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            dateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            dateTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:dateTxt];
            dateTxt.delegate = self;
            dateTxt.placeholder=@"Select Date";
            dateTxt.text=theDate;

        }else if(indexPath.row==1){
            firstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            firstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            firstnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:firstnameTxt];
            firstnameTxt.delegate = self;
            firstnameTxt.placeholder=@"First Name";
        }else if(indexPath.row==2){
            lastnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            lastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            lastnameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:lastnameTxt];
            lastnameTxt.delegate = self;
            lastnameTxt.placeholder=@"Last Name";
        }else if(indexPath.row==3){
            heightView=100;
            displayTextView=[[UIView alloc]initWithFrame:CGRectMake(100, 10,180,heightView)];
            [displayTextView setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:displayTextView];
            UIButton *buttons = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [buttons addTarget:self action:@selector(getAgentCode) forControlEvents:UIControlEventTouchUpInside];
            [buttons setTitle:@"ADD" forState:UIControlStateNormal];
            //[buttons setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
            buttons.frame = CGRectMake(cell.bounds.size.width-40,0,40,30);
            [cell.contentView addSubview:buttons];
            
            
        }else if(indexPath.row==4){
            traineeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            traineeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            traineeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:traineeTxt];
            traineeTxt.delegate = self;
            traineeTxt.text=appDelegate.tranieeStr;
            traineeTxt.placeholder=@"Select Trainee";
            
        }else if(indexPath.row==5){
            productTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            productTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            productTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:productTxt];
            productTxt.delegate = self;
            productTxt.placeholder=@"FFIUL";
            
        }else if(indexPath.row==6){
            
            actualTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            actualTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            actualTxt.textAlignment=NSTextAlignmentRight;
            [agentTxt setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.contentView addSubview:actualTxt];
            actualTxt.delegate = self;
            actualTxt.placeholder=@"EXAMPLE:4200";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            actualTxt.inputAccessoryView = numberToolbar;
        }else if(indexPath.row==7){
            noteTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            noteTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            noteTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:noteTxt];
            noteTxt.delegate = self;
            noteTxt.placeholder=@"Example: Meds scheduled for 4/15@6pm-recieved 3 referrals";
        }else if(indexPath.row==8){
            AddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width+10,60)];
            [AddBtn setTitle:@"ADD TO TRACKER" forState:UIControlStateNormal];
            [AddBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [AddBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [AddBtn removeFromSuperview];
            [cell.contentView addSubview:AddBtn];
        }

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==3){
        
        return heightCellAgent;
    }else{
        
        return 60;
    }
    
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange lowercaseCharRange = [string rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    
    if (lowercaseCharRange.location != NSNotFound) {
        textField.text = [textField.text stringByReplacingCharactersInRange:range
                                                                 withString:[string uppercaseString]];
        return NO;
    }
    
    return YES;
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
