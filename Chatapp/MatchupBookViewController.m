//
//  MatchupBookViewController.m
//  Chatapp
//
//  Created by arvind on 12/15/15.
//  Copyright © 2015 MobiWebCode. All rights reserved.
//

#import "MatchupBookViewController.h"
#import "SWRevealViewController.h"
#import "MatchupBookVo.h"
#import "Reachability.h"
#import "BusinessVO.h"
#import "AddBusAgentSearchViewController.h"
@interface MatchupBookViewController ()

@end

@implementation MatchupBookViewController
@synthesize matchupArray,activityIndicator,mainTableView,appDelegate,displayTextView,agentTxt,buttonClose;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.agentSelectArray=[[NSMutableArray alloc]init];
    appDelegate.agentTempArray=[[NSMutableArray alloc]init];
    appDelegate.agentIdArry=[[NSMutableArray alloc]init];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"MatchUp Book"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:25];
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

    matchupArray=[[NSMutableArray alloc]init];
    [self getMatchupData];
    [self getTrainee];
    // Do any additional setup after loading the view from its nib.
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
                    bvo.agentcode=[activityData objectForKey:@"agent_id"];
                    
                    [appDelegate.traineeListArray addObject:bvo];
                }
                
                
                [activityIndicator stopAnimating];
                [mainTableView reloadData];

            }
            
        }];
        [activityIndicator stopAnimating];
        
    }
    [activityIndicator stopAnimating];
}

-(void)getMatchupData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];

    NSURL *url;
    NSMutableString *httpBodyString;
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/matchup_api/matchupList"];
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
                [activityIndicator stopAnimating];

            }
            else
            {
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                
                NSArray *userArray = [userDict objectForKey:@"matchups"];
                for (int count=0; count<[userArray count]; count++) {
                    
                    NSDictionary *activityData=[userArray objectAtIndex:count];
                    MatchupBookVo *match=[[MatchupBookVo alloc] init];
                    
                    match.match_id=[[NSString alloc] init];
                    match.user_id=[[NSString alloc] init];
                    match.matchday=[[NSString alloc] init];
                    match.date_match=[[NSString alloc] init];
                    
                    match.match_time=[[NSString alloc] init];
                    match.matchup_timezone=[[NSString alloc] init];
                    match.matchup_modified=[[NSString alloc] init];
                    match.place_match=[[NSString alloc] init];
                    match.spouse_name=[[NSString alloc] init];
                    match.contact_match=[[NSString alloc] init];
                    match.match_profile=[[NSString alloc] init];
                    match.match_trainee=[[NSString alloc] init];
                    
                    match.trainee_ph=[[NSString alloc] init];
                    match.appttype=[[NSString alloc] init];
                    match.trainer_types_select=[[NSString alloc] init];
                    match.notes_match=[[NSString alloc] init];
                    match.accept_trainer_matchup=[[NSString alloc] init];
                    match.update_notification=[[NSString alloc] init];
                    
                    match.teamcallsid=[[NSString alloc] init];
                    match.update_notification=[[NSString alloc] init];
                    match.submitted_matchup_date=[[NSString alloc] init];
                    match.read_matchup=[[NSString alloc] init];
                    match.elem_order=[[NSString alloc] init];
                    
                    
                    if ([activityData objectForKey:@"match_id"] != [NSNull null])
                        match.match_id=[activityData objectForKey:@"match_id"];
                        match.user_id=[activityData objectForKey:@"user_id"];
                        match.matchday=[activityData objectForKey:@"matchday"];
                        match.date_match=[activityData objectForKey:@"date_match"];
                        match.match_time=[activityData objectForKey:@"match_time"];
                        match.matchup_timezone=[activityData objectForKey:@"matchup_timezone"];
                    match.matchup_modified=[activityData objectForKey:@"matchup_modified"];
                    match.place_match=[activityData objectForKey:@"place_match"];
                    match.match_name=[activityData objectForKey:@"match_name"];
                    match.spouse_name=[activityData objectForKey:@"spouse_name"];
                    match.contact_match=[activityData objectForKey:@"contact_match"];
                    match.match_profile=[activityData objectForKey:@"match_profile"];
                    match.match_trainee=[activityData objectForKey:@"match_trainee"];
                    match.trainee_ph=[activityData objectForKey:@"trainee_ph"];
                    match.appttype=[activityData objectForKey:@"appttype"];
                    match.trainer_types_select=[activityData objectForKey:@"trainer_types_select"];
                    match.notes_match=[activityData objectForKey:@"notes_match"];
                    match.accept_trainer_matchup=[activityData objectForKey:@"accept_trainer_matchup"];
                    match.update_notification=[activityData objectForKey:@"update_notification"];
                     match.teamcallsid=[activityData objectForKey:@"teamcallsid"];
                    match.submitted_matchup_date=[activityData objectForKey:@"submitted_matchup_date"];
                    match.read_matchup=[activityData objectForKey:@"read_matchup"];
                    match.elem_order=[activityData objectForKey:@"elem_order"];
                    
                    [matchupArray addObject:match];
                }
                [activityIndicator stopAnimating];

            }
        }
        }];
    [activityIndicator stopAnimating];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setButtonmethod];
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
                            bvo.agentcode=[activityData objectForKey:@"agent_id"];
                            
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
-(void)deleteField:(UIButton*)button{
    int j=(int)button.tag;
    agentTxt=(UITextField*)[displayTextView viewWithTag:j+200];
    
    [appDelegate.agentSelectArray removeObjectAtIndex:j-100];
    [appDelegate.agentIdArry removeObject:appDelegate.useridagent];
    [button removeFromSuperview];
    [agentTxt removeFromSuperview];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [mainTableView reloadData];
        [self performSelector:@selector(setButtonmethod) withObject:nil afterDelay:0.2];
    }];
    
    
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
        agentTxt.delegate = (id)self;
        height=height+35;
       
    }
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
        
    }else{
        
        [self pickerOpen];
    }
    
    
    
}
-(void)pickerOpen{
    AddBusAgentSearchViewController *addSarchVC;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {

    addSarchVC=[[AddBusAgentSearchViewController alloc] initWithNibName:@"AddBusAgentSearchViewController" bundle:nil];
    }else{
        addSarchVC=[[AddBusAgentSearchViewController alloc] initWithNibName:@"AddBusAgentSearchViewController~ipad" bundle:nil];

    }
    [self presentViewController:addSarchVC animated:YES completion:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [matchupArray count];
    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    MatchupBookVo *mvo=[matchupArray objectAtIndex:indexPath.row];
    UILabel *matchup,*matchupname,*dayLbl,*dayDisLbl,*dateLbl,*dateDisLbl,*timeLbl,*timeDisp,*zonelbl,*placelbl,*placedisplbl,*namelbl,*namedislbl,*contactlbl,*contactdislbl,*profilelbl,*profiledislbl,*traineelbl,*traineeDisp,*tcontactlbl,*tcontactDisp,*apptplbl,*apptplblDisplbl,*chTrainer;
    
    
    int heightVale=0;
    
    matchup=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,85,30)];
    [matchup setFont:[UIFont boldSystemFontOfSize:18]];
    matchup.lineBreakMode = NSLineBreakByWordWrapping;
    matchup.numberOfLines = 0;
    matchup.text=@"Match Up";
    matchup.textColor=[UIColor blackColor];
    [cell.contentView addSubview:matchup];

    matchupname=[[UILabel alloc] initWithFrame:CGRectMake(90,heightVale,200,30)];
    [matchupname setFont:[UIFont boldSystemFontOfSize:16]];
    matchupname.lineBreakMode = NSLineBreakByWordWrapping;
    matchupname.numberOfLines = 0;
    NSString *matchupID=[[NSString alloc]init];
    NSString *matchupIDs=[[NSString alloc]init];
    matchupID=mvo.match_id;
   
    NSString *matchupName=[[NSString alloc]init];
    for (int count=0; count<[appDelegate.traineeListArray count]; count++) {
        BusinessVO *bVO=[appDelegate.traineeListArray objectAtIndex:count];
        
        if ([mvo.match_id isEqualToString:bVO.user_id]) {
            NSString *secondString = bVO.fname;
            NSString *threestr=bVO.lname;
            matchupName = [NSString stringWithFormat:@"%@ %@", secondString, threestr];

            }
    }
    matchupIDs=[NSString stringWithFormat:@"%@ - Sent from %@",matchupID,matchupName];
    matchupname.text=matchupIDs;
    matchupname.textColor=[UIColor grayColor];
    [cell.contentView addSubview:matchupname];
    
    heightVale=heightVale+30;
    dayLbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,50,30)];
    [dayLbl setFont:[UIFont boldSystemFontOfSize:16]];
    dayLbl.lineBreakMode = NSLineBreakByWordWrapping;
    dayLbl.numberOfLines = 0;
    dayLbl.text=@"Day:";
    dayLbl.textColor=[UIColor blackColor];
    
    
    [cell.contentView addSubview:dayLbl];
    
    dayDisLbl=[[UILabel alloc] initWithFrame:CGRectMake(40,heightVale,100,30)];
    [dayDisLbl setFont:[UIFont systemFontOfSize:16]];
    dayDisLbl.lineBreakMode = NSLineBreakByWordWrapping;
    dayDisLbl.numberOfLines = 0;
    dayDisLbl.text=mvo.matchday;
    dayDisLbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:dayDisLbl];
    
    dateLbl=[[UILabel alloc] initWithFrame:CGRectMake(150,heightVale,50,30)];
    [dateLbl setFont:[UIFont boldSystemFontOfSize:16]];
    dateLbl.lineBreakMode = NSLineBreakByWordWrapping;
    dateLbl.numberOfLines = 0;
    dateLbl.text=@"Date:";
    dateLbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:dateLbl];
    
    dateDisLbl=[[UILabel alloc] initWithFrame:CGRectMake(194,heightVale,100,30)];
    [dateDisLbl setFont:[UIFont systemFontOfSize:16]];
    dateDisLbl.lineBreakMode = NSLineBreakByWordWrapping;
    dateDisLbl.numberOfLines = 0;
    NSString *dateString=[[NSString alloc]init];
    NSString *dateStrings=[[NSString alloc]init];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
   // NSDate *facebookdate = [fbdateFormat dateFromString:mvo.date_match];
    

    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setDateFormat:@"MMM dd,yyy"];
    NSDate *date = [dateFormat dateFromString:mvo.date_match];
    dateStrings = [inFormat stringFromDate:date];
    dateDisLbl.text=dateStrings;
    dateDisLbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:dateDisLbl];
    
    heightVale=heightVale+30;
    timeLbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,50,30)];
    [timeLbl setFont:[UIFont boldSystemFontOfSize:16]];
    timeLbl.lineBreakMode = NSLineBreakByWordWrapping;
    timeLbl.numberOfLines = 0;
    timeLbl.text=@"Time:";
    timeLbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:timeLbl];
    
    timeDisp=[[UILabel alloc] initWithFrame:CGRectMake(52,heightVale,100,30)];
    [timeDisp setFont:[UIFont systemFontOfSize:16]];
    
    timeDisp.lineBreakMode = NSLineBreakByWordWrapping;
    timeDisp.numberOfLines = 0;
    NSString *timeStrings=[[NSString alloc]init];
    
    NSDateFormatter *dateFormats = [[NSDateFormatter alloc] init];
    [dateFormats setDateFormat:@"HH:mm:ss"];
    // NSDate *facebookdate = [fbdateFormat dateFromString:mvo.date_match];
    
    
    NSDateFormatter *inFormats = [[NSDateFormatter alloc] init];
    [inFormats setDateFormat:@"hh:mm a"];
    NSDate *dates = [dateFormats dateFromString:mvo.match_time];
    timeStrings = [inFormats stringFromDate:dates];
    timeDisp.text=timeStrings;
    timeDisp.textColor=[UIColor grayColor];
    [cell.contentView addSubview:timeDisp];
    
    zonelbl=[[UILabel alloc] initWithFrame:CGRectMake(125,heightVale,100,30)];
    [zonelbl setFont:[UIFont systemFontOfSize:16]];
    zonelbl.lineBreakMode = NSLineBreakByWordWrapping;
    zonelbl.numberOfLines = 0;
    zonelbl.text=mvo.matchup_timezone;
    zonelbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:zonelbl];
    
    placelbl=[[UILabel alloc] initWithFrame:CGRectMake(160,heightVale,50,30)];
    [placelbl setFont:[UIFont boldSystemFontOfSize:16]];
    placelbl.lineBreakMode = NSLineBreakByWordWrapping;
    placelbl.numberOfLines = 0;
    placelbl.text=@"Place:";
    placelbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:placelbl];
    
    placedisplbl=[[UILabel alloc] initWithFrame:CGRectMake(217,heightVale,100,30)];
    [placedisplbl setFont:[UIFont systemFontOfSize:16]];
    placedisplbl.lineBreakMode = NSLineBreakByWordWrapping;
    placedisplbl.numberOfLines = 0;
    placedisplbl.text=mvo.place_match;
    placedisplbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:placedisplbl];
    heightVale=heightVale+30;
    namelbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,100,30)];
    [namelbl setFont:[UIFont boldSystemFontOfSize:16]];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    namelbl.text=@"Name:";
    namelbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:namelbl];
    
    namedislbl=[[UILabel alloc] initWithFrame:CGRectMake(60,heightVale,100,30)];
    [namedislbl setFont:[UIFont systemFontOfSize:16]];
    namedislbl.lineBreakMode = NSLineBreakByWordWrapping;
    namedislbl.numberOfLines = 0;
    namedislbl.text=mvo.match_name;
    namedislbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:namedislbl];
    heightVale=heightVale+35;
    contactlbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,100,30)];
    [contactlbl setFont:[UIFont boldSystemFontOfSize:16]];
    contactlbl.lineBreakMode = NSLineBreakByWordWrapping;
    contactlbl.numberOfLines = 0;
    contactlbl.text=@"Contact:";
    contactlbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:contactlbl];
    
    contactdislbl=[[UILabel alloc] initWithFrame:CGRectMake(78,heightVale,100,30)];
    [contactdislbl setFont:[UIFont systemFontOfSize:16]];
    contactdislbl.lineBreakMode = NSLineBreakByWordWrapping;
    contactdislbl.numberOfLines = 0;
    contactdislbl.text=mvo.contact_match;
    contactdislbl.textColor=[UIColor blueColor];
    [cell.contentView addSubview:contactdislbl];
    heightVale=heightVale+30;
    profilelbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale+3,100,30)];
    [profilelbl setFont:[UIFont boldSystemFontOfSize:16]];
    profilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    profilelbl.numberOfLines = 0;
    profilelbl.text=@"Profile:";
    profilelbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:profilelbl];
    
    profiledislbl=[[UILabel alloc] initWithFrame:CGRectMake(65,heightVale,250,40)];
    [profiledislbl setFont:[UIFont systemFontOfSize:16]];
    profiledislbl.lineBreakMode = NSLineBreakByWordWrapping;
    profiledislbl.numberOfLines = 0;
    
     NSArray* profileArray = [mvo.match_profile componentsSeparatedByString: @","];
   NSMutableArray *buttonArray=[[NSMutableArray alloc]init];
    NSString* firstval,*secval,*thival,*forval,*fivval,*sixval,*sevval,*egval,*neval;
     firstval = [profileArray objectAtIndex:0];
    if ([firstval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"25+y.o"];
    }
    secval = [profileArray objectAtIndex:1];
    if ([secval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"Married"];
    }
    thival = [profileArray objectAtIndex:2];
    if ([thival isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"Dependent Children"];
    }
    forval = [profileArray objectAtIndex:3];
    if ([forval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"Homeowner"];
    }
    fivval = [profileArray objectAtIndex:4];
    if ([fivval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"Solid Career Bakground"];
    }
    sixval = [profileArray objectAtIndex:5];
    if ([sixval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"$40,000+Income"];
    }
    sevval = [profileArray objectAtIndex:6];
    if ([sevval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"Dissatisfied"];
    }
    egval = [profileArray objectAtIndex:7];
    if ([egval isEqualToString:@"1"]) {
        
        [buttonArray addObject:@"Entrepreneurial"];
    }
         neval = [profileArray objectAtIndex:8];
         if ([neval isEqualToString:@"1"]) {
             
             [buttonArray addObject:@"Spanish Speaking Preferred"];
         }
    
   NSString *btnString = [buttonArray componentsJoinedByString:@","];

    profiledislbl.text=btnString;
    
    profiledislbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:profiledislbl];
    heightVale=heightVale+35;

    traineelbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,100,30)];
    [traineelbl setFont:[UIFont boldSystemFontOfSize:16]];
    traineelbl.lineBreakMode = NSLineBreakByWordWrapping;
    traineelbl.numberOfLines = 0;
    traineelbl.text=@"Trainee:";
    traineelbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:traineelbl];
    
    traineeDisp=[[UILabel alloc] initWithFrame:CGRectMake(73,heightVale,100,30)];
    [traineeDisp setFont:[UIFont systemFontOfSize:16]];
    traineeDisp.lineBreakMode = NSLineBreakByWordWrapping;
    traineeDisp.numberOfLines = 0;
        traineeDisp.text=mvo.match_trainee;
    traineeDisp.textColor=[UIColor grayColor];
    [cell.contentView addSubview:traineeDisp];
    heightVale=heightVale+30;

    tcontactlbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,150,30)];
    [tcontactlbl setFont:[UIFont boldSystemFontOfSize:16]];
    tcontactlbl.lineBreakMode = NSLineBreakByWordWrapping;
    tcontactlbl.numberOfLines = 0;
    tcontactlbl.text=@"Trainee Contact:";
    tcontactlbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:tcontactlbl];
    
    tcontactDisp=[[UILabel alloc] initWithFrame:CGRectMake(145,heightVale,100,30)];
    [tcontactDisp setFont:[UIFont systemFontOfSize:16]];
    tcontactDisp.lineBreakMode = NSLineBreakByWordWrapping;
    tcontactDisp.numberOfLines = 0;
    tcontactDisp.text=mvo.trainee_ph;
    tcontactDisp.textColor=[UIColor blueColor];
    [cell.contentView addSubview:tcontactDisp];
    heightVale=heightVale+30;

    apptplbl=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,100,30)];
    [apptplbl setFont:[UIFont boldSystemFontOfSize:16]];
    apptplbl.lineBreakMode = NSLineBreakByWordWrapping;
    apptplbl.numberOfLines = 0;
    apptplbl.text=@"Appt.Type:";
    apptplbl.textColor=[UIColor blackColor];
    [cell.contentView addSubview:apptplbl];
    
    apptplblDisplbl=[[UILabel alloc] initWithFrame:CGRectMake(98,heightVale,100,30)];
    [apptplblDisplbl setFont:[UIFont systemFontOfSize:16]];
    apptplblDisplbl.lineBreakMode = NSLineBreakByWordWrapping;
    apptplblDisplbl.numberOfLines = 0;
    apptplblDisplbl.text=mvo.appttype;
    apptplblDisplbl.textColor=[UIColor grayColor];
    [cell.contentView addSubview:apptplblDisplbl];
     heightVale=heightVale+30;
    
    chTrainer=[[UILabel alloc] initWithFrame:CGRectMake(5,heightVale,200,30)];
    [chTrainer setFont:[UIFont boldSystemFontOfSize:16]];
    chTrainer.lineBreakMode = NSLineBreakByWordWrapping;
    chTrainer.numberOfLines = 0;
    chTrainer.text=@"Choose a Field Trainer:";
    chTrainer.textColor=[UIColor blackColor];
    [cell.contentView addSubview:chTrainer];
     heightVale=heightVale+30;
    displayTextView=[[UIView alloc]initWithFrame:CGRectMake(10, heightVale,180,60)];
    [displayTextView setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:displayTextView];
    UIButton *buttons = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttons addTarget:self action:@selector(getAgentCode) forControlEvents:UIControlEventTouchUpInside];
    [buttons setTitle:@"ADD" forState:UIControlStateNormal];
    //[buttons setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    buttons.frame = CGRectMake(cell.bounds.size.width-40,heightVale,40,60);
    [cell.contentView addSubview:buttons];

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380;
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
