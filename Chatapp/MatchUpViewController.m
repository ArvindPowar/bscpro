//
//  MatchUpViewController.m
//  Chatapp
//
//  Created by arvind on 7/16/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "MatchUpViewController.h"
#import "SWRevealViewController.h"
#import "UIView+Toast.h"
#import "Reachability.h"
#import "ModelTraineeSearchViewController.h"
#import "BusinessVO.h"
@interface MatchUpViewController ()

@end

@implementation MatchUpViewController
@synthesize dayTxt,dateTxt,timeTxt,timezoneTxt,placeTxt,nameTxt,contactTxt,profileTxt,traineeeTxt,TraineePhTxt,ApptTxt,notesTxt,matchupLbl,dayLbl,dateLbl,timeLbl,timezoneLbl,placeLbl,nameLbl,contactLbl,profileLbl,traineeLbl,traineePhLbl,appttypeLbl,notesLbl,matchUpBtn,scrollView,dayPickerView,dayToobar,dayArrayList,timezonePickView,timezoneToolbar,timezoneArray,datepicker,timepicker,starttime,endtime,theDate,timeDuration,dateToolbar,timeToolbar,bgimage,viewUp,activityIndicator,btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btnSpan,buttonArray,profileArray,spousenameTxt,btnArray,spouseLbl,aButton,userlistTableView,lblarray,dateString,timeStrings,myDayString,theTime,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    appDelegate.traineeId=[[NSString alloc]init];
    appDelegate.tranieeStr=[[NSString alloc]init];

    [dayTxt setDelegate:self];
    [dateTxt setDelegate:self];
    [timeTxt setDelegate:self];
    [timezoneTxt setDelegate:self];
    [placeTxt setDelegate:self];
    [nameTxt setDelegate:self];
    [contactTxt setDelegate:self];
    [profileTxt setDelegate:self];
    [traineeeTxt setDelegate:self];
    [TraineePhTxt setDelegate:self];
    [ApptTxt setDelegate:self];
    [notesTxt setDelegate:self];
    [spousenameTxt setDelegate:self];
    spousenameTxt.hidden=YES;
    spouseLbl.hidden=YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"SUBMIT MATCH UP"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    lblarray=[[NSMutableArray alloc]initWithObjects:@"DAY",@"DATE",@"TIME",@"TIMEZONE",@"PLACE",@"NAME",@"CONTACT",@"PROFILE",@"TRAINEE",@"TRAINEE CONTACT",@"APPT. TYPE",@"NOTES",@"",@"",nil];

    buttonArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSTimeInterval seconds; // assume this exists
    NSDate* ts_utc = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter* df_utc = [[NSDateFormatter alloc] init];
    [df_utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df_utc setDateFormat:@"LL/dd/YYYY"];
    
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    [df_local setDateFormat:@"LL/dd/YYYY"];
    
    NSString* ts_utc_string = [df_utc stringFromDate:ts_utc];
    NSString* ts_local_string = [df_local stringFromDate:ts_utc];
    NSUserDefaults *prefstimezone = [NSUserDefaults standardUserDefaults];
    NSString *formDate=[[NSString alloc]init];
    formDate=[prefstimezone objectForKey:@"timezone"];
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:formDate];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:@"LL/dd/YYYY"];
    theDate = [dateFormat stringFromDate:now];
    
    datepicker.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(height>=568){
        //self.scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        bgimage.image=[UIImage imageNamed:@"background.png"];
       
    }else{
        bgimage.image=[UIImage imageNamed:@"background.png"];
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
    }

    
    dateTxt.layer.borderColor=[[UIColor blackColor]CGColor];
    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    
    datepicker.hidden=YES;
    datepicker.backgroundColor = [UIColor whiteColor];
    NSString *formDates=[[NSString alloc]init];
    formDates=[prefstimezone objectForKey:@"timezone"];
    NSDate *nowTime = [[NSDate alloc] init];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZones = [NSTimeZone timeZoneWithName:formDates];
 [timeFormat setTimeZone:timeZones];
    [timeFormat setDateFormat:@"hh:mm a"];
    theTime = [timeFormat stringFromDate:nowTime];
    timeStrings=theTime;
    
    timepicker.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    CGFloat yheight = [UIScreen mainScreen].bounds.size.height;
    if(yheight>=568){
        //self.scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        bgimage.image=[UIImage imageNamed:@"background.png"];
        
    }else{
        bgimage.image=[UIImage imageNamed:@"background.png"];
        timepicker.frame=CGRectMake(0, 348, self.view.bounds.size.width, 162);
    }
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    
    dayArrayList=[[NSMutableArray alloc]init];
    dayArrayList=[[NSMutableArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];
    timezoneArray=[[NSMutableArray alloc]initWithObjects:@"PST",@"MST",@"CST",@"EST",nil];
    profileArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yzheight = [UIScreen mainScreen].bounds.size.height;

    int ywidth=85;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
    CGFloat pheight = [UIScreen mainScreen].bounds.size.height;
    if(pheight>=480 && pheight<568){

        scrollView.contentSize=CGSizeMake(width, yzheight+800);

        timepicker.frame=CGRectMake(0,348, self.view.bounds.size.width, 162);
        [timepicker removeFromSuperview];
        [self.view addSubview:timepicker];
        
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];

        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+250);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
        

    }else if(pheight>=568 && pheight<600){
        scrollView.contentSize=CGSizeMake(width, yzheight+800);

        
        timepicker.frame=CGRectMake(0,348, self.view.bounds.size.width, 162);
        [timepicker removeFromSuperview];
        [self.view addSubview:timepicker];
        
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+170);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
        
       
    
    }else{
        scrollView.contentSize=CGSizeMake(width, yzheight+500);

        timepicker.frame=CGRectMake(0,348, self.view.bounds.size.width, 162);
        [timepicker removeFromSuperview];
        [self.view addSubview:timepicker];
        
        datepicker.frame=CGRectMake(0, 350,self.view.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+250);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
 
    }
    }
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    contactTxt.inputAccessoryView = numberToolbar;
    TraineePhTxt.inputAccessoryView = numberToolbar;


    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    datepicker.hidden=YES;
    datepicker.backgroundColor = [UIColor whiteColor];
    timepicker.hidden=YES;
    timepicker.backgroundColor = [UIColor whiteColor];
    
    userlistTableView.delegate = self;
    userlistTableView.dataSource = self;
    userlistTableView.scrollEnabled = NO;
    [activityIndicator stopAnimating];

    [activityIndicator stopAnimating];

    // Do any additional setup after loading the view from its nib.
}

-(void)doneWithNumberPad{
    [contactTxt resignFirstResponder];
    [TraineePhTxt resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    appDelegate.tranieeStr=@"";
    appDelegate.traineeId=@"";
    appDelegate.smdTraineeStr=@"";
}

-(void)viewDidAppear:(BOOL)animated{
    if (![appDelegate.tranieeStr isEqualToString:@""]) {
        traineeeTxt.text=appDelegate.tranieeStr;

    }else{
        traineeeTxt.text=appDelegate.traineeId;

    }

}
-(void)getTrainee{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"There's no internet connection at all.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
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
                [activityIndicator stopAnimating];

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
                    NSString *tempagentid = [[NSString alloc] initWithFormat:@"(%@)",[activityData objectForKey:@"agent_id"]];
                    bvo.agentcode=tempagentid;
                    
                    [appDelegate.traineeListArray addObject:bvo];
                }
                
                ModelTraineeSearchViewController *modelvc;
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

                modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController" bundle:nil];
                }else{
                    modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController~ipad" bundle:nil];

                }
                [self presentViewController:modelvc animated:YES completion:nil];

                [activityIndicator stopAnimating];
                
            }
            
        }];
    }
    
}

- (void)buttonClicked:(UIButton*)button
{
    NSLog(@"Button %ld clicked.", (long int)[button tag]);
    if ([[buttonArray objectAtIndex:button.tag] isEqualToString:@"0"]) {
        [buttonArray replaceObjectAtIndex:button.tag withObject:@"1"];
        //[aButton setBackgroundColor:[UIColor blueColor]];
        
    }else{
        [buttonArray replaceObjectAtIndex:button.tag withObject:@"0"];
        //[aButton setBackgroundColor:[UIColor grayColor]];
    }
    if (button.tag ==1) {
        if(spousenameTxt.hidden==YES)
        {
        spouseLbl.hidden=NO;
        spousenameTxt.hidden=NO;
       
        }else{
            spouseLbl.hidden=YES;
            spousenameTxt.hidden=YES;
           
        }
    }
    if (!button.selected)
    {
        [button setSelected:YES];
        [button setBackgroundColor:[UIColor blueColor]];
        [button setBackgroundImage:[UIImage imageNamed:@"BtnBg.png"] forState:UIControlStateSelected];
    }
    else
    {
        [button setSelected:NO];
        [button setBackgroundColor:[UIColor grayColor]];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        
        
    }
    switch (button.tag) {
            
        case 0: {
            // Make toast
            [self.view makeToast:@"25+y.o"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            
            break;
        }
            
        case 1: {
            // Make toast with a title
            [self.view makeToast:@"Married"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            
            break;
        }
            
        case 2: {
            // Make toast with an image
            [self.view makeToast:@"Dependent Children"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
            
        case 3: {
            // Make toast with an image & title
            [self.view makeToast:@"Homeowner"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
        case 4: {
            // Make toast with an image & title
            [self.view makeToast:@"Solid Career Bakground"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
        case 5: {
            // Make toast with an image & title
            [self.view makeToast:@"$40,000+Income"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
        case 6: {
            // Make toast with an image & title
            [self.view makeToast:@"Dissatisfied"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
        case 7: {
            // Make toast with an image & title
            [self.view makeToast:@"Entrepreneurial"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
        case 8: {
            // Make toast with an image & title
            [self.view makeToast:@"Spanish Speaking Preferred"duration:3.0
                        position:CSToastPositionCenter
                           image:[UIImage imageNamed:@""]];
            break;
        }
    }
  /* if (buttonArray [[button tag]==0]) {
    buttonArray[[button tag]==1];
   }else{
       buttonArray[[button tag]==0];
   }*/
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==dayTxt)
    {
        
        dayToobar.hidden=YES;
        dayPickerView.hidden=YES;
        timezoneToolbar.hidden=YES;
        timezonePickView.hidden=YES;
        
        dayPickerView = [[UIPickerView alloc] init];
        [dayPickerView setDataSource: self];
        [dayPickerView setDelegate: self];
        dayPickerView.backgroundColor = [UIColor whiteColor];
        [dayPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        dayPickerView.showsSelectionIndicator = YES;
        [dayPickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: dayPickerView];
        dayPickerView.hidden=NO;
            dayToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
            
        [dayToobar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneDay)];
        dayToobar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:dayToobar];
        
        dayToobar.hidden=NO;
        [dayTxt resignFirstResponder];
        
        return NO;
    }else if(textField==timezoneTxt)
    {
        dayToobar.hidden=YES;
        timezoneToolbar.hidden=YES;
        timezonePickView.hidden=YES;
        dayPickerView.hidden=YES;
        
        timezonePickView = [[UIPickerView alloc] init];
        [timezonePickView setDataSource: self];
        [timezonePickView setDelegate: self];
        timezonePickView.backgroundColor = [UIColor whiteColor];
        [timezonePickView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        timezonePickView.showsSelectionIndicator = YES;
        [timezonePickView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: timezonePickView];
        timezonePickView.hidden=NO;
            timezoneToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];

        [timezoneToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneTimezone)];
        timezoneToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:timezoneToolbar];
        
        timezoneToolbar.hidden=NO;
        [dayTxt resignFirstResponder];
        
        return NO;

    
    }else if(textField==dateTxt){
        
        if(viewUp==YES){
            viewUp=NO;
            //[self animateTextView:NO];
        }
        
        if(viewUp==NO){
            viewUp=YES;
            //[self animateTextView:YES];
        }
        dayToobar.hidden=YES;
        timezoneToolbar.hidden=YES;
        timezonePickView.hidden=YES;
        dayPickerView.hidden=YES;
        dateToolbar.hidden=YES;
        timeToolbar.hidden=YES;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            dateToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,307,self.view.bounds.size.width,44)];
            
        }else{
            dateToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,615,self.view.bounds.size.width,44)];
            
        }

        [dateToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneDate)];
        dateToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:dateToolbar];
        datepicker.timeZone = [NSTimeZone timeZoneWithName: @"PST"];
        dateToolbar.hidden=NO;
        datepicker.hidden=NO;
        
        [dateTxt resignFirstResponder];
        
        return NO;
    }else if (textField==timeTxt){
        if(viewUp==YES){
            viewUp=NO;
            //[self animateTextView:NO];
        }
        
        if(viewUp==NO){
            viewUp=YES;
            //[self animateTextView:YES];
        }
        dayToobar.hidden=YES;
        timezoneToolbar.hidden=YES;
        timezonePickView.hidden=YES;
        dayPickerView.hidden=YES;
        dateToolbar.hidden=YES;
        timeToolbar.hidden=YES;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

        timeToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,304,self.view.bounds.size.width,44)];
        }else{
            timeToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,600,self.view.bounds.size.width,44)];

        }
        [timeToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressedtime)];
        timeToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:timeToolbar];
        timepicker.timeZone = [NSTimeZone timeZoneWithName: @"PST"];

        dateToolbar.hidden=YES;
        datepicker.hidden=YES;
        timeToolbar.hidden=NO;
        timepicker.hidden=NO;
        [timeTxt resignFirstResponder];
        
        return NO;
        
    }else if (textField==traineeeTxt){
        [traineeeTxt resignFirstResponder];
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
    dayToobar.hidden=YES;
    dayPickerView.hidden=YES;
    timezoneToolbar.hidden=YES;
    timezonePickView.hidden=YES;
    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    datepicker.hidden=YES;
    timepicker.hidden=YES;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  if(textField==contactTxt){
      NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
      int length = [currentString length];
           if (length > 12) {
          return NO;
      }

  }if(textField==TraineePhTxt){
      NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
      int length = [currentString length];
      if (length > 12) {
          return NO;
      }
      
  }
    int length = [self getLength:contactTxt.text];
    if(length == 12) {
        if(range.length == 0)
            return NO;
    }
    if(length == 3){
        NSString *num = [self formatNumber:contactTxt.text];
        contactTxt.text = [NSString stringWithFormat:@"%@-",num];
        
        if(range.length > 0) {
            contactTxt.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            
        }
    } else if(length == 6) {
        NSString *num = [self formatNumber:contactTxt.text];
        contactTxt.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0) {
            contactTxt.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    int lengthx = [self getLength:TraineePhTxt.text];
    if(lengthx == 12) {
        if(range.length == 0)
            return NO;
    }
    if(lengthx == 3){
        NSString *num = [self formatNumber:TraineePhTxt.text];
        TraineePhTxt.text = [NSString stringWithFormat:@"%@-",num];
        
        if(range.length > 0) {
            TraineePhTxt.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            
        }
    } else if(lengthx == 6) {
        NSString *num = [self formatNumber:TraineePhTxt.text];
        TraineePhTxt.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0) {
            TraineePhTxt.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)doneBtnPressedtime{
    starttime= [[NSDateFormatter alloc] init];
    [starttime setDateFormat:@"hh:mm a"];
    NSString *st = [starttime stringFromDate:timepicker.date];
    //timeTxt.text=[[NSString alloc]initWithFormat:@"%@",st];
    
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZones = [NSTimeZone timeZoneWithName:@"PST"];
    [dateFormatters setTimeZone:timeZones];
    [dateFormatters setDateFormat:@"hh:mm a"];
    timeTxt.text = [dateFormatters stringFromDate:timepicker.date];
    timeStrings=timeTxt.text;

    dayToobar.hidden=YES;
    dayPickerView.hidden=YES;
    timezoneToolbar.hidden=YES;
    timezonePickView.hidden=YES;
    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    datepicker.hidden=YES;
    timepicker.hidden=YES;
}

-(void)doneDate{
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
    [dateFormatter setDateFormat:@"EEEE"];
    myDayString = [dateFormatter stringFromDate:datepicker.date];
    dayTxt.text=myDayString;
   
    dayToobar.hidden=YES;
    dayPickerView.hidden=YES;
    timezoneToolbar.hidden=YES;
    timezonePickView.hidden=YES;
    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    datepicker.hidden=YES;
    timepicker.hidden=YES;

}
-(void)doneDay{
    if (![dateTxt.text isEqualToString:@""]) {
        if (![dayTxt.text isEqualToString:myDayString]) {
            [self doneDate];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Day and date selected do not match!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
   
    dayToobar.hidden=YES;
    dayPickerView.hidden=YES;
    timezoneToolbar.hidden=YES;
    timezonePickView.hidden=YES;
    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    datepicker.hidden=YES;
    timepicker.hidden=YES;
}

-(void)doneTimezone{
    dayToobar.hidden=YES;
    dayPickerView.hidden=YES;
    timezoneToolbar.hidden=YES;
    timezonePickView.hidden=YES;
    dateToolbar.hidden=YES;
    timeToolbar.hidden=YES;
    datepicker.hidden=YES;
    timepicker.hidden=YES;

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: dayPickerView]) {
        return [dayArrayList count];
    }if ([pickerView isEqual:timezonePickView]) {
        return [timezoneArray count];
    }

    
    else{
        return 0;
    }
}


// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==dayPickerView)
    {
        [dayTxt setText:[NSString stringWithFormat:@"%@",[dayArrayList objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }else{
        
        [timezoneTxt setText:[timezoneArray objectAtIndex:row]];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == dayPickerView)
    {
        return [dayArrayList objectAtIndex:row];
        
    }else{
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        return [timezoneArray objectAtIndex:row];
    }
    return 0;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    
    return componentWidth;
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
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

    NSString *btnString=[[NSString alloc]init];
    
    if ([spousenameTxt.text isEqualToString:@""]) {
        spousenameTxt.text=@" ";
    }
    if([dayTxt.text isEqualToString:@""] || [dateTxt.text isEqualToString:@""] || [timeTxt.text isEqualToString:@""] ||[placeTxt.text isEqualToString:@""] || [nameTxt.text isEqualToString:@""] || [contactTxt.text isEqualToString:@""] || [traineeeTxt.text isEqualToString:@""] || [TraineePhTxt.text isEqualToString:@""] || [ApptTxt.text isEqualToString:@""] || [notesTxt.text isEqualToString:@""] || [timezoneTxt.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"All fields are mandatory.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else if (![dayTxt.text isEqualToString:myDayString]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Day and date selected do not match!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [activityIndicator stopAnimating];
    }
    
else{

    NSURL *url;
    NSMutableString *httpBodyString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    btnString = [buttonArray componentsJoinedByString:@","];

    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
             NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZones = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatters setTimeZone:timeZones];
    [dateFormatters setDateFormat:@"HH:mm:ss"];
    //timeStrings = [dateFormatters stringFromDate:timepicker.date];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&match_day=%@&match_date=%@&match_time=%@&place=%@&match_name=%@&contact=%@&trainee=%@&trainee_phone=%@&app_type=%@&notes=%@&match_timezone=%@&profile_arr=%@&spouse_name=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],dayTxt.text,dateTxt.text,timeTxt.text,placeTxt.text,nameTxt.text,contactTxt.text,traineeeTxt.text,TraineePhTxt.text,ApptTxt.text,notesTxt.text,timezoneTxt.text,btnString,spousenameTxt.text]];
    
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/matchup_api/"];
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
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Error adding match up, Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else if([status isEqualToString:@"ok"]){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Match up submitted successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [userlistTableView reloadData];
                }
            }
        }
         [activityIndicator stopAnimating];
    }];
    }
    }
}
-(void)clearData{
    dayTxt.text=@"";
    dateTxt.text=@"";
    timeTxt.text=@"";
    timezoneTxt.text=@"";
    placeTxt.text=@"";
    nameTxt.text=@"";
    contactTxt.text=@"";
    traineeeTxt.text=@"";
    TraineePhTxt.text=@"";
    ApptTxt.text=@"";
    notesTxt.text=@"";

}


-(IBAction)postData{
    [self postAllData];
    
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
    NSUserDefaults *prefsFIRSTNAME = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefslastName = [NSUserDefaults standardUserDefaults];
    NSString *firstString = [prefsFIRSTNAME objectForKey:@"firstName"];
    NSString *lastname=[prefslastName objectForKey:@"lastName"];

    NSString *firstlastname=[[NSString alloc]init];
    firstlastname=[NSString stringWithFormat:@"%@ %@",firstString,lastname];
    // Let's set some custom cell options.
    // Set the cell's background.
    CGFloat pheight = [UIScreen mainScreen].bounds.size.height;
    if(pheight>=480 && pheight<568){
        UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,5,130,55)];
        [fieldLBls setText:[lblarray objectAtIndex:[indexPath row]]];
        fieldLBls.textAlignment=NSTextAlignmentLeft;
        fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
        fieldLBls.numberOfLines = 0;
        [fieldLBls setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        [cell.contentView addSubview:fieldLBls];
        if(indexPath.row==0){
            dayTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            dayTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            dayTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:dayTxt];
            dayTxt.delegate = self;
            dayTxt.placeholder=@"Select Day";
        }else if(indexPath.row==1){
            dateTxt= [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            dateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            dateTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:dateTxt];
            dateTxt.delegate = self;
            dateTxt.placeholder=@"Select Date";
            dateTxt.text=theDate;

        }else if(indexPath.row==2){
            timeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            timeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            timeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:timeTxt];
            timeTxt.delegate = self;
            timeTxt.placeholder=@"Select Time";
            timeTxt.text=theTime;

        }else if(indexPath.row==3){
            timezoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            timezoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            timezoneTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:timezoneTxt];
            timezoneTxt.delegate = self;
            timezoneTxt.text=@"PST";
            
        }else if(indexPath.row==4){
            placeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            placeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            placeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:placeTxt];
            placeTxt.delegate = self;
            placeTxt.placeholder=@"Enter The Specific Address";
            
        }else if(indexPath.row==5){
            nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            nameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            nameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:nameTxt];
            nameTxt.delegate = self;
            nameTxt.placeholder=@"First and Last Name";
            
        }else if(indexPath.row==6){
            contactTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            contactTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            contactTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:contactTxt];
            contactTxt.delegate = self;
            contactTxt.placeholder=@"Cell or Best Contact Number of Prospect";
            [contactTxt setKeyboardType:UIKeyboardTypeNumberPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            contactTxt.inputAccessoryView = numberToolbar;
            
        }else if(indexPath.row==7){
            int ywidth=75;
            
            for( int i = 0; i < 9; i++ ) {
                aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                aButton = [[UIButton alloc] initWithFrame:CGRectMake(ywidth,15,40,30)];
                [aButton setTag:i];
                aButton.backgroundColor=[UIColor grayColor];
                NSString *string = [NSString stringWithFormat:@"%d",i+1];
                
                if ([string isEqualToString:@"6"]) {
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(75,60,40,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:5];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }if ([string isEqualToString:@"7"]) {
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(125,60,40,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:6];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }if ([string isEqualToString:@"8"]) {
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(175,60,40,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:7];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
                if ([string isEqualToString:@"9"]) {
                    string=@"SPAN";
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(225,60,50,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:8];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
                [aButton setTitle:string forState:UIControlStateNormal];
                aButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
                [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:aButton];
                ywidth=ywidth+50;
            }
        }else if(indexPath.row==8){
            traineeeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            traineeeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            traineeeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:traineeeTxt];
            traineeeTxt.delegate = self;
            traineeeTxt.placeholder=@"Select Trainee";
            
        }else if(indexPath.row==9){
            TraineePhTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            TraineePhTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            TraineePhTxt.textAlignment=NSTextAlignmentRight;
            [TraineePhTxt setKeyboardType:UIKeyboardTypeNumberPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            TraineePhTxt.inputAccessoryView = numberToolbar;
            [cell.contentView addSubview:TraineePhTxt];
            TraineePhTxt.delegate = self;
            TraineePhTxt.placeholder=@"Phone #";
            
        }else if(indexPath.row==10){
            ApptTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            ApptTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            ApptTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:ApptTxt];
            ApptTxt.delegate = self;
            ApptTxt.placeholder=@"Appt. Type";
            
        }else if(indexPath.row==11){
            notesTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            notesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            notesTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:notesTxt];
            notesTxt.delegate = self;
            notesTxt.placeholder=@"Notes";
            
            
        }else if(indexPath.row==12){
            spouseLbl = [[UILabel alloc] initWithFrame:CGRectMake(15,0,150,60)];
            [spouseLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            spouseLbl.text=@"SPOUSE'S NAME";
            [cell.contentView addSubview:spouseLbl];
            spouseLbl.hidden=YES;
            spousenameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            spousenameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            spousenameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:spousenameTxt];
            spousenameTxt.delegate = self;
            spousenameTxt.placeholder=@"Spouse Name";
            spousenameTxt.hidden=YES;
        }else if(indexPath.row==13){
            matchUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [matchUpBtn setTitle:@"SUBMIT MATCH UP" forState:UIControlStateNormal];
            [matchUpBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [matchUpBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [matchUpBtn removeFromSuperview];
            [cell.contentView addSubview:matchUpBtn];
        }

    }else if(pheight>=568 && pheight<600){
    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,5,130,55)];
    [fieldLBls setText:[lblarray objectAtIndex:[indexPath row]]];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    [fieldLBls setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
    [cell.contentView addSubview:fieldLBls];
    if(indexPath.row==0){
        dayTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        dayTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        dayTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:dayTxt];
        dayTxt.delegate = self;
        dayTxt.placeholder=@"Select Day";
    }else if(indexPath.row==1){
        dateTxt= [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        dateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        dateTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:dateTxt];
        dateTxt.delegate = self;
        dateTxt.placeholder=@"Select Date";
        dateTxt.text=theDate;

    }else if(indexPath.row==2){
        timeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        timeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        timeTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:timeTxt];
        timeTxt.delegate = self;
        timeTxt.placeholder=@"Select Time";
        timeTxt.text=theTime;

    }else if(indexPath.row==3){
        timezoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        timezoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        timezoneTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:timezoneTxt];
        timezoneTxt.delegate = self;
        timezoneTxt.text=@"PST";
        
    }else if(indexPath.row==4){
        placeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        placeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        placeTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:placeTxt];
        placeTxt.delegate = self;
        placeTxt.placeholder=@"Enter The Specific Address";
        
    }else if(indexPath.row==5){
        nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        nameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        nameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:nameTxt];
        nameTxt.delegate = self;
        nameTxt.placeholder=@"First and Last Name";
        
    }else if(indexPath.row==6){
        contactTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        contactTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        contactTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:contactTxt];
        contactTxt.delegate = self;
        contactTxt.placeholder=@"Cell or Best Contact Number of Prospect";
        [contactTxt setKeyboardType:UIKeyboardTypeNumberPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        contactTxt.inputAccessoryView = numberToolbar;

    }else if(indexPath.row==7){
        int ywidth=75;

        for( int i = 0; i < 9; i++ ) {
            aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            aButton = [[UIButton alloc] initWithFrame:CGRectMake(ywidth,15,40,30)];
            [aButton setTag:i];
            aButton.backgroundColor=[UIColor grayColor];
            NSString *string = [NSString stringWithFormat:@"%d",i+1];
            
            if ([string isEqualToString:@"6"]) {
                aButton = [[UIButton alloc] initWithFrame:CGRectMake(75,60,40,30)];
                [aButton setTitle:string forState:UIControlStateNormal];
                [aButton setTag:5];
                aButton.backgroundColor=[UIColor grayColor];
                [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }if ([string isEqualToString:@"7"]) {
                aButton = [[UIButton alloc] initWithFrame:CGRectMake(125,60,40,30)];
                [aButton setTitle:string forState:UIControlStateNormal];
                [aButton setTag:6];
                aButton.backgroundColor=[UIColor grayColor];
                [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }if ([string isEqualToString:@"8"]) {
                aButton = [[UIButton alloc] initWithFrame:CGRectMake(175,60,40,30)];
                [aButton setTitle:string forState:UIControlStateNormal];
                [aButton setTag:7];
                aButton.backgroundColor=[UIColor grayColor];
                [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            if ([string isEqualToString:@"9"]) {
                string=@"SPAN";
                aButton = [[UIButton alloc] initWithFrame:CGRectMake(225,60,50,30)];
                [aButton setTitle:string forState:UIControlStateNormal];
                [aButton setTag:8];
                aButton.backgroundColor=[UIColor grayColor];
                [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            [aButton setTitle:string forState:UIControlStateNormal];
            aButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
           [cell.contentView addSubview:aButton];
            ywidth=ywidth+50;
        }
    }else if(indexPath.row==8){
        traineeeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        traineeeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        traineeeTxt.textAlignment=NSTextAlignmentRight;
        //traineeeTxt.text=firstlastname;
        [cell.contentView addSubview:traineeeTxt];
        traineeeTxt.delegate = self;
        traineeeTxt.placeholder=@"Select Trainee";
        
    }else if(indexPath.row==9){
        TraineePhTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        TraineePhTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        TraineePhTxt.textAlignment=NSTextAlignmentRight;
        [TraineePhTxt setKeyboardType:UIKeyboardTypeNumberPad];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        TraineePhTxt.inputAccessoryView = numberToolbar;

        [cell.contentView addSubview:TraineePhTxt];
        TraineePhTxt.delegate = self;
        TraineePhTxt.placeholder=@"Phone #";
        
    }else if(indexPath.row==10){
        ApptTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        ApptTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        ApptTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:ApptTxt];
        ApptTxt.delegate = self;
        ApptTxt.placeholder=@"Appt. Type";
        
    }else if(indexPath.row==11){
        notesTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        notesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        notesTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:notesTxt];
        notesTxt.delegate = self;
        notesTxt.placeholder=@"NOTES";
        
    
}else if(indexPath.row==12){
    spouseLbl = [[UILabel alloc] initWithFrame:CGRectMake(15,0,150,60)];
    [spouseLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
    spouseLbl.text=@"SPOUSE'S NAME";
    [cell.contentView addSubview:spouseLbl];
    spouseLbl.hidden=YES;
    spousenameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
    spousenameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
    spousenameTxt.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:spousenameTxt];
    spousenameTxt.delegate = self;
    spousenameTxt.placeholder=@"Spouse Name";
    spousenameTxt.hidden=YES;
}else if(indexPath.row==13){
        matchUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
        [matchUpBtn setTitle:@"SUBMIT MATCH UP" forState:UIControlStateNormal];
        [matchUpBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [matchUpBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        [matchUpBtn removeFromSuperview];
        [cell.contentView addSubview:matchUpBtn];
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
            dayTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            dayTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            dayTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:dayTxt];
            dayTxt.delegate = self;
            dayTxt.placeholder=@"Select Day";
        }else if(indexPath.row==1){
            dateTxt= [[UITextField alloc] initWithFrame:CGRectMake(150,5,180,55)];
            dateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            dateTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:dateTxt];
            dateTxt.delegate = self;
            dateTxt.placeholder=@"Select Date";
            dateTxt.text=theDate;

        }else if(indexPath.row==2){
            timeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            timeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            timeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:timeTxt];
            timeTxt.delegate = self;
            timeTxt.placeholder=@"Select Time";
            timeTxt.text=theTime;

        }else if(indexPath.row==3){
            timezoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,180,55)];
            timezoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            timezoneTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:timezoneTxt];
            timezoneTxt.delegate = self;
            timezoneTxt.text=@"PST";
            
        }else if(indexPath.row==4){
            placeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            placeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            placeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:placeTxt];
            placeTxt.delegate = self;
            placeTxt.placeholder=@"Enter The Specific Address";
            
        }else if(indexPath.row==5){
            nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            nameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            nameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:nameTxt];
            nameTxt.delegate = self;
            nameTxt.placeholder=@"First and Last Name";
            
        }else if(indexPath.row==6){
            contactTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            contactTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            contactTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:contactTxt];
            contactTxt.delegate = self;
            contactTxt.placeholder=@"Cell or Best Contact Number of Prospect";
            [contactTxt setKeyboardType:UIKeyboardTypeNumberPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            contactTxt.inputAccessoryView = numberToolbar;
            
        }else if(indexPath.row==7){
            int ywidth=75;
            
            for( int i = 0; i < 9; i++ ) {
                aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                aButton = [[UIButton alloc] initWithFrame:CGRectMake(ywidth,15,40,30)];
                [aButton setTag:i];
                aButton.backgroundColor=[UIColor grayColor];
                NSString *string = [NSString stringWithFormat:@"%d",i+1];
                
                if ([string isEqualToString:@"6"]) {
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(75,60,40,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:5];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }if ([string isEqualToString:@"7"]) {
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(125,60,40,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:6];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }if ([string isEqualToString:@"8"]) {
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(175,60,40,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:7];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
                if ([string isEqualToString:@"9"]) {
                    string=@"SPAN";
                    aButton = [[UIButton alloc] initWithFrame:CGRectMake(225,60,50,30)];
                    [aButton setTitle:string forState:UIControlStateNormal];
                    [aButton setTag:8];
                    aButton.backgroundColor=[UIColor grayColor];
                    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
                [aButton setTitle:string forState:UIControlStateNormal];
                aButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
                [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:aButton];
                ywidth=ywidth+50;
            }
        }else if(indexPath.row==8){
            traineeeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            traineeeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            traineeeTxt.textAlignment=NSTextAlignmentRight;
            //traineeeTxt.text=firstlastname;
            [cell.contentView addSubview:traineeeTxt];
            traineeeTxt.delegate = self;
            traineeeTxt.placeholder=@"Select Trainee";
            
        }else if(indexPath.row==9){
            TraineePhTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            TraineePhTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            TraineePhTxt.textAlignment=NSTextAlignmentRight;
            [TraineePhTxt setKeyboardType:UIKeyboardTypeNumberPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            TraineePhTxt.inputAccessoryView = numberToolbar;

            [cell.contentView addSubview:TraineePhTxt];
            TraineePhTxt.delegate = self;
            TraineePhTxt.placeholder=@"Phone #";
            
        }else if(indexPath.row==10){
            ApptTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            ApptTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            ApptTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:ApptTxt];
            ApptTxt.delegate = self;
            ApptTxt.placeholder=@"Appt. Type";
            
        }else if(indexPath.row==11){
            notesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            notesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            notesTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:notesTxt];
            notesTxt.delegate = self;
            notesTxt.placeholder=@"Notes";
            
            
        }else if(indexPath.row==12){
            spouseLbl = [[UILabel alloc] initWithFrame:CGRectMake(15,0,130,60)];
            [spouseLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            spouseLbl.text=@"SPOUSE'S NAME";
            [cell.contentView addSubview:spouseLbl];
            spouseLbl.hidden=YES;
            spousenameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            spousenameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            spousenameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:spousenameTxt];
            spousenameTxt.delegate = self;
            spousenameTxt.placeholder=@"Spouse Name";
            spousenameTxt.hidden=YES;
        }else if(indexPath.row==13){
            matchUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [matchUpBtn setTitle:@"SUBMIT MATCH UP" forState:UIControlStateNormal];
            [matchUpBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [matchUpBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [matchUpBtn removeFromSuperview];
            [cell.contentView addSubview:matchUpBtn];
        }

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==7){
     return 100;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
