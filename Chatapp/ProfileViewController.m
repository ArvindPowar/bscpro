//
//  ProfileViewController.m
//  Chatapp
//
//  Created by arvind on 7/14/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize yournameLbl,firstlastLbl,levelLbl,agentCodeLbl,licensesLbl,languagesLbl,addressLbl,cityLbl,stateLbl,zipcodeLbl,emailLbl,countryLbl,phoneLbl,selectTimezoneLbl,uplineSAMDLbl,uplineceoevcLbl,uplineSmdEmdLbl,usernameLbl,currentPasswordLbl,NewPasswordLbl,passRepLbl,yournameTxt,firstlastTxt,levelTxt,agentCodeTxt,licensesTxt,languagesTxt,addressTxt,cityTxt,stateTxt,zipcodeTxt,emailTxt,countryTxt,phoneTxt,selectTimezoneTxt,uplineSAMDTxt,uplineceoevcTxt,uplineSmdEmdTxt,usernameTxt,currentPasswordTxt,NewPasswordTxt,scrollView,updateProfile,passRetTxt,LevelPickerView,CEOPickerView,SMDPickerView,toolbar,toolbar1,toolbar2,dataArrayLevel,appDelegate,ceosmdVO,activityIndicator,typeStringCeo,typeStringSmd,countryListArray,countryPickerView,countryToolbar,timezoneArray,timezonePickerView,timezoneToolbar,licensesPickerView,languagePickerView,licensesToolbar,languageToolbar,licensesArray,languageArray,proVO,StringATASAMD,dataArrayATASMMD,SAMDpickerView,SAMDToolbar,profileArray,profileImg,profilePicture,psv,editBtnPicture,image,SAMDstr,uplineceoStr,uplinesmdStr,userlistTableView,lblarray,demoView,alertView1;



- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
 lblarray=[[NSMutableArray alloc]initWithObjects:@"FIRST NAME",@"LAST NAME",@"LEVEL",@"AGENT ID",@"LICENSES",@"LANGUAGES",@"ADDRESS",@"CITY",@"STATE/PROVINCE",@"ZIP CODE",@"E-MAIL",@"COUNTRY",@"PHONE",@"SELECT TIMEZONE",@"SELECT UPLINE SA OR MD ",@"UPLINE CEO/EVC",@"UPLINE SMD/EMD ",@"USERNAME",@"CURRENT PASSWORD",@"NEW PASSWORD",@"NEW PASSWORD REPEAT",@"",nil];
    [activityIndicator stopAnimating];
    
    [yournameTxt setDelegate:self];
    [firstlastTxt setDelegate:self];
    [levelTxt setDelegate:self];
    [agentCodeTxt setDelegate:self];
    [licensesTxt setDelegate:self];
    [languagesTxt setDelegate:self];
    [addressTxt setDelegate:self];
    [cityTxt setDelegate:self];
    [stateTxt setDelegate:self];
    [zipcodeTxt setDelegate:self];
    [emailTxt setDelegate:self];
    [countryTxt setDelegate:self];
    [phoneTxt setDelegate:self];
    [selectTimezoneTxt setDelegate:self];
    [uplineSAMDTxt setDelegate:self];
    [uplineceoevcTxt setDelegate:self];
    [uplineSmdEmdTxt setDelegate:self];
    [usernameTxt setDelegate:self];
    [currentPasswordTxt setDelegate:self];
    [NewPasswordTxt setDelegate:self];
    licensesTxt.enabled=NO;
    languagesTxt.enabled=NO;
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Profile"];
    [titleLabel setFont:[UIFont fontWithName:@"Calibri-Bold" size:20.0]];
    titleLabel.textColor=[UIColor blackColor];
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
   
    //countryListArray=[[NSMutableArray alloc]init];
    //countryListArray=[[NSMutableArray alloc]initWithObjects:@"India",@"USA",@"Vietnam",nil];
    dataArrayLevel=[[NSMutableArray alloc]init];
    dataArrayLevel=[[NSMutableArray alloc]initWithObjects:@"TA",@"A",@"SA",@"MD",@"SMD",@"EMD",@"CEO",@"EVC",@"ADM",nil];
    timezoneArray=[[NSMutableArray alloc]init];
    timezoneArray=[[NSMutableArray alloc]initWithObjects:@"Eastern",@"Central",@"Mountain",@"Mountain(Arizona)",@"Pacific",@"Alaska",@"Hawaii-Aleutian",@"India",nil];
    licensesArray=[[NSMutableArray alloc]init];
    licensesArray=[[NSMutableArray alloc]initWithObjects:@"Life",@"Life & Health",@"Series 6",@"Series 63",@"Series 65",@"Series 26",nil];
    languageArray=[[NSMutableArray alloc]init];
    languageArray=[[NSMutableArray alloc]initWithObjects:@"English",@"Spanish(Fluent)",@"Chinese(Mandarinl)",@"Hindi",@"Japanese",@"Tagolog",@"Arabic",@"Vietnamese",@"Korean",@"Portuguese",@"Bengali",@"Russian",@"French",@"Thai",@"Urdu",@"Italian",@"German",@"Javanese",@"Turkish",@"Polish",@"Persian",nil];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yheight = [UIScreen mainScreen].bounds.size.height;
    if(yheight>=568){
        scrollView.contentSize=CGSizeMake(width, yheight+1300);
    }else{
        scrollView.contentSize=CGSizeMake(width, yheight+850);
    }
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(height>=480 && height<568){
        
        profileImg=[[AsyncImageView alloc] initWithFrame:CGRectMake(70, 0, 155,100)];
        [profileImg setBackgroundColor:[UIColor clearColor]];
        [self.scrollView addSubview:profileImg];
        
        [editBtnPicture removeFromSuperview];
        [editBtnPicture.layer setFrame:CGRectMake(70,0,155,100)];
        [editBtnPicture setBackgroundColor:[UIColor clearColor]];
        [editBtnPicture addTarget:self action:@selector(UpdateImage) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:editBtnPicture];
        
        userlistTableView.frame=CGRectMake(0,100,self.view.bounds.size.width,self.view.bounds.size.height+200);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
        
    }else if(height>=568 && height<600){
        
       profileImg=[[AsyncImageView alloc] initWithFrame:CGRectMake(70, 0, 155,100)];
       [profileImg setBackgroundColor:[UIColor clearColor]];
       [self.scrollView addSubview:profileImg];
        
        
        [editBtnPicture removeFromSuperview];
        editBtnPicture=[[UIButton alloc]init];
        [editBtnPicture.layer setFrame:CGRectMake(70,0,155,100)];
        [editBtnPicture setBackgroundColor:[UIColor clearColor]];
        [editBtnPicture addTarget:self action:@selector(UpdateImage) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:editBtnPicture];
        
            userlistTableView.frame=CGRectMake(0,100,self.view.bounds.size.width,self.view.bounds.size.height+600);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
        
        

    }else{
        profileImg=[[AsyncImageView alloc] initWithFrame:CGRectMake(90, 0, 155,100)];
        [profileImg setBackgroundColor:[UIColor clearColor]];
        [self.scrollView addSubview:profileImg];
        
        [editBtnPicture removeFromSuperview];
        editBtnPicture=[[UIButton alloc]init];
        [editBtnPicture.layer setFrame:CGRectMake(90,0,155,100)];
        [editBtnPicture setBackgroundColor:[UIColor clearColor]];
        [editBtnPicture addTarget:self action:@selector(UpdateImage) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:editBtnPicture];

        userlistTableView.frame=CGRectMake(0,100,self.view.bounds.size.width,self.view.bounds.size.height+600);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
      
    }
  
       emailTxt.enabled=NO;
    usernameTxt.enabled=NO;

    typeStringCeo=@"CEO,EVC";
   
    typeStringSmd=@"CEO,EVC,SMD,EMD";
   
    userlistTableView.delegate = self;
    userlistTableView.dataSource = self;
    userlistTableView.scrollEnabled = NO;

    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self getAllData];

}
-(void)getAllData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
       profileArray=[[NSMutableArray alloc]init];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/profile_api/getUserProfile/"];
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
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSString *userArray = [[NSString alloc]init];
                userArray = [userDict objectForKey:@"message"];
                
                
                if([userArray isEqualToString:@"User not available."])
                {
                    
                }else{

                NSError *error;
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                
                NSArray *userArray = [userDict objectForKey:@"userdetail"];
                for (int count=0; count<[userArray count]; count++) {
                    
                    NSDictionary *activityData=[userArray objectAtIndex:count];
                    ProfileVO *pvo=[[ProfileVO alloc] init];
                    pvo.firstname=[[NSString alloc] init];
                    pvo.username=[[NSString alloc] init];
                    pvo.lastname=[[NSString alloc] init];
                    pvo.level=[[NSString alloc] init];
                    pvo.agentid=[[NSString alloc] init];
                    pvo.city=[[NSString alloc] init];
                    pvo.state=[[NSString alloc] init];
                    pvo.address=[[NSString alloc] init];
                    pvo.zipcode=[[NSString alloc] init];
                    pvo.phone=[[NSString alloc] init];
                    pvo.email=[[NSString alloc] init];
                    pvo.timezone=[[NSString alloc] init];
                    pvo.ceo_evc=[[NSString alloc] init];
                    pvo.smd_emd=[[NSString alloc] init];
                    pvo.country=[[NSString alloc] init];
                    pvo.profileImg=[[NSString alloc] init];
                    pvo.language=[[NSString alloc] init];
                    pvo.licenses=[[NSString alloc] init];
                    pvo.uplineSA_MD=[[NSString alloc] init];
                    
                    if ([activityData objectForKey:@"fname"] != [NSNull null])
                        pvo.firstname=[activityData objectForKey:@"fname"];
                    pvo.username=[activityData objectForKey:@"username"];
                    pvo.lastname=[activityData objectForKey:@"lname"];
                    pvo.level=[activityData objectForKey:@"level"];
                    pvo.agentid=[activityData objectForKey:@"agent_id"];
                    pvo.city=[activityData objectForKey:@"city"];
                    pvo.state=[activityData objectForKey:@"state"];
                    pvo.address=[activityData objectForKey:@"address"];
                    pvo.zipcode=[activityData objectForKey:@"zip"];
                    pvo.phone=[activityData objectForKey:@"cellphone"];
                    pvo.email=[activityData objectForKey:@"email"];
                    pvo.timezone=[activityData objectForKey:@"selet_timezone"];
                    pvo.ceo_evc=[activityData objectForKey:@"upline"];
                    pvo.smd_emd=[activityData objectForKey:@"upline_smd"];
                    pvo.country=[activityData objectForKey:@"country"];
                    pvo.profileImg=[activityData objectForKey:@"profile_image"];
                    pvo.language=[activityData objectForKey:@"language"];
                    pvo.licenses=[activityData objectForKey:@"licenses"];
                    pvo.uplineSA_MD=[activityData objectForKey:@"all_SA_MD_user"];
                    
                    [profileArray addObject:pvo];
                    pvo=[profileArray objectAtIndex:0];
                    [profileImg loadImageFromURL:[NSURL URLWithString:pvo.profileImg]];
                }
                
                [userlistTableView reloadData];
                [activityIndicator stopAnimating];
            }
            }
            [activityIndicator stopAnimating];
        }];
    }
    
[activityIndicator stopAnimating];
}

-(void)doneWithNumberPad{

    [phoneTxt resignFirstResponder];
}
-(void)samddisplayInfo1{
    if(appDelegate.dataArrayATASMMD==nil || [appDelegate.dataArrayATASMMD count]==0){
        [appDelegate getDataATASMMD];
    }else{

   for (int count=0; count<[appDelegate.dataArrayATASMMD count]; count++) {
        CEOSMDVO *cvo=[appDelegate.dataArrayATASMMD objectAtIndex:count];
    if([SAMDstr isEqualToString:cvo.user_id]){
        uplineSAMDTxt.text=cvo.username;
    }
   }
    }
}
-(void)ceodisplayInfo2{
    if(appDelegate.CeoArray==nil || [appDelegate.CeoArray count]==0){
        [appDelegate getDataCED];
    }else{

     for (int count=0; count<[appDelegate.CeoArray count]; count++) {
    CEOSMDVO *cvo1=[appDelegate.CeoArray objectAtIndex:count];
    if([uplineceoStr isEqualToString:cvo1.user_id]){
        uplineceoevcTxt.text=cvo1.username;
    }
     }
    }
}
-(void)smddisplayInfo3{
    if(appDelegate.SmdArray==nil || [appDelegate.SmdArray count]==0){
        [appDelegate getDataSMD];
    }else{
    
    for (int count=0; count<[appDelegate.SmdArray count]; count++) {
        CEOSMDVO *cvo2=[appDelegate.SmdArray objectAtIndex:count];
    if([uplinesmdStr isEqualToString:cvo2.user_id]){
        uplineSmdEmdTxt.text=cvo2.username;
    }
    }
    }
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

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==levelTxt)
    {
        
        uplineceoevcTxt.text=@"";
        uplineSmdEmdTxt.text=@"";
        
        toolbar2.hidden=YES;
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        countryToolbar.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        countryPickerView.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        LevelPickerView = [[UIPickerView alloc] init];
        [LevelPickerView setDataSource: self];
        [LevelPickerView setDelegate: self];
        LevelPickerView.backgroundColor = [UIColor whiteColor];
        [LevelPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        LevelPickerView.showsSelectionIndicator = YES;
        [LevelPickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: LevelPickerView];
        LevelPickerView.hidden=NO;
        toolbar1= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [toolbar1 setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        toolbar1.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:toolbar1];
        
        toolbar1.hidden=NO;
        [levelTxt resignFirstResponder];
        
        return NO;
    }else if(textField==uplineceoevcTxt)
    {
        
        
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        countryToolbar.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        countryPickerView.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        
        
        if ([levelTxt.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SKUBAG"
                                                            message:@"Please select level first!!!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [uplineceoevcTxt resignFirstResponder];
            return NO;
            // This is faster than indexOfObject for large sets
            
        }else{
            
            CEOPickerView = [[UIPickerView alloc] init];
            [CEOPickerView setDataSource: self];
            [CEOPickerView setDelegate: self];
            CEOPickerView.backgroundColor = [UIColor whiteColor];
            [CEOPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
            CEOPickerView.showsSelectionIndicator = YES;
            [CEOPickerView selectRow:2 inComponent:0 animated:YES];
            [self.view addSubview: CEOPickerView];
            CEOPickerView.hidden=NO;
            toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
            [toolbar setBarStyle:UIBarStyleBlackOpaque];
            UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
            toolbar.items = @[barButtonDone];
            barButtonDone.tintColor=[UIColor whiteColor];
            [self.view addSubview:toolbar];
            
            toolbar.hidden=NO;
            [uplineceoevcTxt resignFirstResponder];
            
            return NO;
        }
    }else if(textField==uplineSmdEmdTxt)
    {
        
        
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        countryToolbar.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        countryPickerView.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        
        
        if([uplineceoevcTxt.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SKUBAG"
                                                            message:@"Please select CEO/EVC first..."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [uplineSmdEmdTxt resignFirstResponder];
            return NO;
        }else{
            
            SMDPickerView = [[UIPickerView alloc] init];
            [SMDPickerView setDataSource: self];
            [SMDPickerView setDelegate: self];
            SMDPickerView.backgroundColor = [UIColor whiteColor];
            [SMDPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
            SMDPickerView.showsSelectionIndicator = YES;
            [SMDPickerView selectRow:2 inComponent:0 animated:YES];
            [self.view addSubview: SMDPickerView];
            SMDPickerView.hidden=NO;
            toolbar2= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
            [toolbar2 setBarStyle:UIBarStyleBlackOpaque];
            UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
            toolbar2.items = @[barButtonDone];
            barButtonDone.tintColor=[UIColor whiteColor];
            [self.view addSubview:toolbar2];
            
            toolbar2.hidden=NO;
            [uplineSmdEmdTxt resignFirstResponder];
            return NO;
        }
    }else if(textField==countryTxt)
    {
        
        
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        countryToolbar.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        countryPickerView.hidden=YES;

            
            countryPickerView = [[UIPickerView alloc] init];
            [countryPickerView setDataSource: self];
            [countryPickerView setDelegate: self];
            countryPickerView.backgroundColor = [UIColor whiteColor];
            [countryPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
            countryPickerView.showsSelectionIndicator = YES;
            [countryPickerView selectRow:2 inComponent:0 animated:YES];
            [self.view addSubview: countryPickerView];
            countryPickerView.hidden=NO;
            countryToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
            [countryToolbar setBarStyle:UIBarStyleBlackOpaque];
            UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
            countryToolbar.items = @[barButtonDone];
            barButtonDone.tintColor=[UIColor whiteColor];
            [self.view addSubview:countryToolbar];
            
            countryToolbar.hidden=NO;
            [countryTxt resignFirstResponder];
            
            return NO;
        
    }else if(textField==selectTimezoneTxt)
    {
        
        
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        countryToolbar.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        countryPickerView.hidden=YES;
        
        
        timezonePickerView = [[UIPickerView alloc] init];
        [timezonePickerView setDataSource: self];
        [timezonePickerView setDelegate: self];
        timezonePickerView.backgroundColor = [UIColor whiteColor];
        [timezonePickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        timezonePickerView.showsSelectionIndicator = YES;
        [timezonePickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: timezonePickerView];
        timezonePickerView.hidden=NO;
        timezoneToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [timezoneToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        timezoneToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:timezoneToolbar];
        
        timezoneToolbar.hidden=NO;
        [selectTimezoneTxt resignFirstResponder];
        
        return NO;
        
    }else if(textField==licensesTxt)
    {
        
        
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        timezoneToolbar.hidden=YES;
        countryToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        countryPickerView.hidden=YES;
        
        
        licensesPickerView = [[UIPickerView alloc] init];
        [licensesPickerView setDataSource: self];
        [licensesPickerView setDelegate: self];
        licensesPickerView.backgroundColor = [UIColor whiteColor];
        [licensesPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        licensesPickerView.showsSelectionIndicator = YES;
        [licensesPickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: licensesPickerView];
        licensesPickerView.hidden=NO;
        licensesToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [licensesToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        licensesToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:licensesToolbar];
        
        licensesToolbar.hidden=NO;
        [licensesTxt resignFirstResponder];
        
        return NO;
        
    }else if(textField==languagesTxt)
    {
        
        
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        countryToolbar.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        countryPickerView.hidden=YES;
        
        
        languagePickerView = [[UIPickerView alloc] init];
        [languagePickerView setDataSource: self];
        [languagePickerView setDelegate: self];
        languagePickerView.backgroundColor = [UIColor whiteColor];
        [languagePickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        languagePickerView.showsSelectionIndicator = YES;
        [languagePickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: languagePickerView];
        languagePickerView.hidden=NO;
        languageToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [languageToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        languageToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:languageToolbar];
        
        languageToolbar.hidden=NO;
        [languagesTxt resignFirstResponder];
        
        return NO;
        
    }else if(textField==uplineSAMDTxt)
    {
           toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        timezoneToolbar.hidden=YES;
        licensesToolbar.hidden=YES;
        languageToolbar.hidden=YES;
        SAMDToolbar.hidden=YES;
        SAMDpickerView.hidden=YES;
        licensesPickerView.hidden=YES;
        languagePickerView.hidden=YES;
        timezonePickerView.hidden=YES;
        countryToolbar.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        countryPickerView.hidden=YES;
        SAMDpickerView = [[UIPickerView alloc] init];
        [SAMDpickerView setDataSource: self];
        [SAMDpickerView setDelegate: self];
        SAMDpickerView.backgroundColor = [UIColor whiteColor];
        [SAMDpickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        SAMDpickerView.showsSelectionIndicator = YES;
        [SAMDpickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: SAMDpickerView];
        SAMDpickerView.hidden=NO;
        SAMDToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [SAMDToolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed)];
        SAMDToolbar.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:SAMDToolbar];
        
        SAMDToolbar.hidden=NO;
        [languagesTxt resignFirstResponder];
        
        return NO;
        
    }
    toolbar.hidden=YES;
    toolbar1.hidden=YES;
    toolbar2.hidden=YES;
    countryToolbar.hidden=YES;
    timezoneToolbar.hidden=YES;
    licensesToolbar.hidden=YES;
    languageToolbar.hidden=YES;
    SAMDToolbar.hidden=YES;
    SAMDpickerView.hidden=YES;
    licensesPickerView.hidden=YES;
    languagePickerView.hidden=YES;
    timezonePickerView.hidden=YES;
    LevelPickerView.hidden=YES;
    CEOPickerView.hidden=YES;
    SMDPickerView.hidden=YES;
    countryPickerView.hidden=YES;
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)doneBtnPressed{
    if ([levelTxt.text isEqualToString:@"SMD"] || [levelTxt.text isEqualToString:@"EMD"]) {
        uplineSmdEmdTxt.enabled=NO;
        uplineSmdEmdTxt.text=@"I am an SMD";
        if([uplineSmdEmdTxt.text isEqualToString:@"I am an SMD"]){
            proVO=[profileArray objectAtIndex:0];
            uplinesmdStr=proVO.smd_emd;
        }
        

        
    }else if([levelTxt.text isEqualToString:@"CEO"] || [levelTxt.text isEqualToString:@"EVC"]){
        uplineceoevcTxt.enabled=NO;
        uplineceoevcTxt.text=@"MY CEO or EVC is not listed";
        
        uplineSmdEmdTxt.enabled=NO;
        uplineSmdEmdTxt.text=@"I am an SMD";
        
        uplineSAMDTxt.enabled=NO;
        uplineSAMDTxt.text=@"I am an SA & MD";
        if([uplineSmdEmdTxt.text isEqualToString:@"I am an SMD"]){
            proVO=[profileArray objectAtIndex:0];
            uplinesmdStr=proVO.smd_emd;
        }
        if([uplineceoevcTxt.text isEqualToString:@"MY CEO or EVC is not listed"]){
            proVO=[profileArray objectAtIndex:0];
             uplineceoStr=proVO.ceo_evc;
        }
        
    }else{
        uplineSAMDTxt.enabled=YES;
        uplineceoevcTxt.enabled=YES;
        uplineSmdEmdTxt.enabled=YES;
    }
    
    toolbar.hidden=YES;
    toolbar1.hidden=YES;
    toolbar2.hidden=YES;
    countryToolbar.hidden=YES;
    timezoneToolbar.hidden=YES;
    licensesToolbar.hidden=YES;
    languageToolbar.hidden=YES;
    SAMDToolbar.hidden=YES;
    SAMDpickerView.hidden=YES;
    licensesPickerView.hidden=YES;
    languagePickerView.hidden=YES;
    timezonePickerView.hidden=YES;
    LevelPickerView.hidden=YES;
    CEOPickerView.hidden=YES;
    SMDPickerView.hidden=YES;
    countryPickerView.hidden=YES;
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: LevelPickerView]) {
        return [dataArrayLevel count];
    }
    if ([pickerView isEqual:CEOPickerView]) {
        return [appDelegate.CeoArray count];
    }
    if ([pickerView isEqual:SMDPickerView]) {
        return [appDelegate.SmdArray count];
    }if ([pickerView isEqual:countryPickerView]) {
        if(appDelegate.SmdArray==nil || [appDelegate.SmdArray count]==0){
            [appDelegate getCountryData];
        }else{
        return [appDelegate.countryListArray count];
        }
    }if ([pickerView isEqual:timezonePickerView]) {
        return [timezoneArray count];
    }if ([pickerView isEqual:licensesPickerView]) {
        return [licensesArray count];
    }if ([pickerView isEqual:languagePickerView]) {
        return [languageArray count];
    }if ([pickerView isEqual:SAMDpickerView]) {
        return [appDelegate.dataArrayATASMMD count];
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
    if (pickerView ==LevelPickerView)
    {
        [levelTxt setText:[NSString stringWithFormat:@"%@",[dataArrayLevel objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }else if (pickerView ==CEOPickerView)
        
    {
        CEOSMDVO *cvo=[appDelegate.CeoArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =cvo.username;
        //NSString *secondString = cvo.firstname;
       // NSString *threestr=cvo.lastname;
        str = [NSString stringWithFormat:@"%@ ", firstString];
        [uplineceoevcTxt setText:str];
        //[uplineceoevcTxt setText:cvo.username];
        uplineceoStr=cvo.user_id;
    }else if (pickerView ==SMDPickerView)
        
    {
        CEOSMDVO *cvo=[appDelegate.SmdArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =cvo.username;
        //NSString *secondString = cvo.firstname;
        //NSString *threestr=cvo.lastname;
        str = [NSString stringWithFormat:@"%@ ", firstString];
        [uplineSmdEmdTxt setText:str];
        //[uplineSmdEmdTxt setText:cvo.username];
        uplinesmdStr=cvo.user_id;
    }else if(pickerView ==countryPickerView){
        CEOSMDVO *cvo=[appDelegate.countryListArray objectAtIndex:row];
        
        [countryTxt setText:cvo.country];
    }else if(pickerView ==timezonePickerView){
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        [selectTimezoneTxt setText:[timezoneArray objectAtIndex:row]];
    }else if(pickerView ==licensesPickerView){
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        [licensesTxt setText:[licensesArray objectAtIndex:row]];
    }else if (pickerView ==SAMDpickerView)
        
    {
        CEOSMDVO *cvo=[appDelegate.dataArrayATASMMD objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =cvo.username;
        //NSString *secondString = cvo.firstname;
       // NSString *threestr=cvo.lastname;
        str = [NSString stringWithFormat:@"%@ ", firstString];
        [uplineSAMDTxt setText:str];
        //[uplineSAMDTxt setText:cvo.username];
        SAMDstr=cvo.user_id;
    }else{
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        [languagesTxt setText:[languageArray objectAtIndex:row]];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == LevelPickerView)
    {
        return [dataArrayLevel objectAtIndex:row];
        
    }else if (pickerView == CEOPickerView)
        
    {
        CEOSMDVO *cvo=[appDelegate.CeoArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =cvo.username;
        //NSString *secondString = cvo.firstname;
        //NSString *threestr=cvo.lastname;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString];

        return str;
        
    }else if(pickerView == SMDPickerView)
{
        CEOSMDVO *cvo=[appDelegate.SmdArray objectAtIndex:row];
    NSString *str=[[NSString alloc]init];
    NSString *firstString =cvo.username;
   // NSString *secondString = cvo.firstname;
   // NSString *threestr=cvo.lastname;
    str = [NSString stringWithFormat:@"%@ ", firstString];

        return str;
    }else if(pickerView == countryPickerView){
        CEOSMDVO *cvo=[appDelegate.countryListArray objectAtIndex:row];
        
        return cvo.country;
    }else if(pickerView == timezonePickerView){
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        return [timezoneArray objectAtIndex:row];
    }else if(pickerView == licensesPickerView){
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        return [licensesArray objectAtIndex:row];
    }else if (pickerView == SAMDpickerView)
        
    {
        CEOSMDVO *cvo=[appDelegate.dataArrayATASMMD objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =cvo.username;
        //NSString *secondString = cvo.firstname;
        //NSString *threestr=cvo.lastname;
        str = [NSString stringWithFormat:@"%@", firstString];
        return str;
        
    }else{
        //RegisterVO *rvo=[cityArrayData objectAtIndex:row];
        
        return [languageArray objectAtIndex:row];
    }
    
    
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



-(void)postAllData:(NSString *)imageURL{
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    //imagecode=[UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions:0]
    NSURL *url;
    NSMutableString *httpBodyString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    NSString *pass=[[NSString alloc]init];
    pass=[prefspassword objectForKey:@"password"];
       httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&fname=%@&lname=%@&level=%@&agent_id=%@&city=%@&state=%@&address=%@&zip=%@&cellphone=%@&email=%@&selet_timezone=%@&upline=%@&upline_smd=%@&password=%@&new_password=%@&repeat_password=%@&country=%@&profile_image=%@&language=%@&licenses=-%@&all_SA_MD_user=%@&sec_user=%@&sec_pass=%@",[prefs objectForKey:@"loggedin"],yournameTxt.text,firstlastTxt.text,levelTxt.text,agentCodeTxt.text,cityTxt.text,stateTxt.text,addressTxt.text,zipcodeTxt.text,phoneTxt.text,emailTxt.text,selectTimezoneTxt.text,uplineceoStr,uplinesmdStr,currentPasswordTxt.text,NewPasswordTxt.text,passRetTxt.text,countryTxt.text,imageURL,languagesTxt.text,licensesTxt.text,SAMDstr,[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://bscpro.com/profile_api/"];
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
            NSLog(@"contents : %@",content);
            NSError *error;
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSString *userArray = [[NSString alloc]init];
            userArray = [userDict objectForKey:@"messgae"];
            NSString* sItemNameDecorated = [userArray stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            NSString* sItemNameDecora = [userArray stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            if([sItemNameDecora isEqualToString:@"The New Password field must be at least 4 characters in length."])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"The New Password field must be at least 4 characters in length.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([sItemNameDecora isEqualToString:@"The Password field must be at least 4 characters in length."])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"The Password field must be at least 4 characters in length.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([sItemNameDecora isEqualToString:@"The Confirm Password field does not match the New Password field."])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"The Confirm Password field does not match the New Password field.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else if([sItemNameDecora isEqualToString:@"Username Or Password Incorrect."])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Username Or Password Incorrect.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
           else if([sItemNameDecora isEqualToString:@"Profile update successfully"])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Profile update successfully!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
                [prefspassword setObject:NewPasswordTxt.text forKey:@"password"];
                [prefspassword synchronize];

            }else  if([sItemNameDecora isEqualToString:@"The password changed successfully."])
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"The password changed successfully.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
                [prefspassword setObject:NewPasswordTxt.text forKey:@"password"];
                [prefspassword synchronize];
            }
                [activityIndicator stopAnimating];
        }
    }];
    [activityIndicator stopAnimating];
   
}

#pragma mark - Actions

- (IBAction)postDatas
{
    if(image != nil)
    {
        [self uploadImage];
    }else{
        [self postAllData:@""];
        
    }
  }


- (UIView *)createDemoView_Camera
{
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,150)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Select Picture" forState:UIControlStateNormal];
    [topButton setBackgroundColor:[UIColor blueColor]];
    topButton.layer.cornerRadius=1.0;
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [demoView addSubview:topButton];
    
    
    UIButton *galleryOption=[[UIButton alloc] initWithFrame:CGRectMake(0,50, 300,48)];
    [galleryOption setTitle:@"Gallery" forState:UIControlStateNormal];
    [galleryOption addTarget:self
                      action:@selector(galleryOption)
            forControlEvents:UIControlEventTouchUpInside];
    [galleryOption setBackgroundColor:[UIColor blackColor]];
    galleryOption.tag=1;
    [demoView addSubview:galleryOption];
    
    UIButton *cameraOption=[[UIButton alloc] initWithFrame:CGRectMake(0,102, 300,50)];
    [cameraOption setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraOption addTarget:self
                     action:@selector(cameraOption)
           forControlEvents:UIControlEventTouchUpInside];
    [cameraOption setBackgroundColor:[UIColor blackColor]];
    cameraOption.tag=1;
    [demoView addSubview:cameraOption];
    
    
    UIButton *cancel=[[UIButton alloc] initWithFrame:CGRectMake(265,10,30,30)];
    [cancel setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(closeAlert:)
     forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:cancel];
    [demoView bringSubviewToFront:cancel];
    
    return demoView;
}

-(void)closeAlert:(id)sender{
    [alertView1 close];
}

-(void)galleryOption{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    [alertView1 close];
    
}
-(void)cameraOption{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Sorry, you do not have a camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        //[altView release];
        return;
    }
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    [alertView1 close];
    
}
-(IBAction)UpdateImage{
    alertView1 = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView1 setContainerView:[self createDemoView_Camera]];
    
    // Modify the parameters
    
    [alertView1 setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView1 setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView_, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView_ tag]);
        [alertView_ close];
    }];
    
    [alertView1 setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView1 show];
}

- (BOOL)uploadImage:(NSData *)imageData filename:(NSString *)filename{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    
    NSString *urlString = @"http://www.mobiwebcode.com/chatapp/chat_attachment.php";
    NSLog(@"urlstring is %@",urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //image filename
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",filename]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"return string %@",returnString);
    //[self clearAllData];
    [activityIndicator stopAnimating];
    
    
    [self postAllData:returnString];
    return true;
}

-(void)uploadImage{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *serverString=[[NSString alloc] initWithFormat:@"%@",[prefs objectForKey:@"loggedin"]];
    [self uploadImage:UIImageJPEGRepresentation(image, 1.0) filename:serverString];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
        [controller setDelegate:self];
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popover setDelegate:self];
        [popover presentPopoverFromRect:CGRectMake(455, 665, 30, 30) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        popover.popoverContentSize = CGSizeMake(315, 500);
        // [controller release];
    }
    else
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Camera"]){
        [self galleryOption];
    }
    else if([title isEqualToString:@"Gallery"]){
        [self cameraOption];
    }else if([title isEqualToString:@"Cancel"]){
        [alertView dismissWithClickedButtonIndex:2 animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    [editBtnPicture setBackgroundImage:image forState:UIControlStateNormal];
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    //[self performSelector:@selector(pushView) withObject:nil afterDelay:0.2];
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
    ProfileVO *pvo=[profileArray objectAtIndex:0];
    
    

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
            yournameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            yournameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            yournameTxt.textAlignment=NSTextAlignmentRight;
            yournameTxt.text=pvo.firstname;
            [cell.contentView addSubview:yournameTxt];
            yournameTxt.delegate = self;
            yournameTxt.placeholder=@"First Name";
        }else if(indexPath.row==1){
            firstlastTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            firstlastTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            firstlastTxt.textAlignment=NSTextAlignmentRight;
            firstlastTxt.text=pvo.lastname;
            [cell.contentView addSubview:firstlastTxt];
            firstlastTxt.delegate = self;
            firstlastTxt.placeholder=@"Last Name";
        }else if(indexPath.row==2){
            levelTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            levelTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            levelTxt.textAlignment=NSTextAlignmentRight;
            levelTxt.text=pvo.level;
            [cell.contentView addSubview:levelTxt];
            levelTxt.delegate = self;
            levelTxt.placeholder=@"Select Level";
        }else if(indexPath.row==3){
            agentCodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            agentCodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            agentCodeTxt.textAlignment=NSTextAlignmentRight;
            agentCodeTxt.text=pvo.agentid;
            [cell.contentView addSubview:agentCodeTxt];
            agentCodeTxt.delegate = self;
            agentCodeTxt.placeholder=@"Agent id";
            
        }else if(indexPath.row==4){
            licensesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            licensesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            licensesTxt.textAlignment=NSTextAlignmentRight;
            licensesTxt.enabled=NO;
            licensesTxt.text=pvo.licenses;
            [cell.contentView addSubview:licensesTxt];
            licensesTxt.delegate = self;
            licensesTxt.placeholder=@"Licenses";
        }else if(indexPath.row==5){
            languagesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            languagesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            languagesTxt.textAlignment=NSTextAlignmentRight;
            languagesTxt.enabled=NO;
            languagesTxt.text=pvo.language;
            [cell.contentView addSubview:languagesTxt];
            languagesTxt.delegate = self;
            languagesTxt.placeholder=@"Languages";
        }else if(indexPath.row==6){
            addressTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            addressTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            addressTxt.textAlignment=NSTextAlignmentRight;
            addressTxt.text=pvo.address;
            [cell.contentView addSubview:addressTxt];
            addressTxt.delegate = self;
            addressTxt.placeholder=@"Address";
        }else if(indexPath.row==7){
            cityTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            cityTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            cityTxt.textAlignment=NSTextAlignmentRight;
            cityTxt.text=pvo.city;
            [cell.contentView addSubview:cityTxt];
            cityTxt.delegate = self;
            cityTxt.placeholder=@"City";
        }else if(indexPath.row==8){
            stateTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            stateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            stateTxt.textAlignment=NSTextAlignmentRight;
            stateTxt.text=pvo.state;
            [cell.contentView addSubview:stateTxt];
            stateTxt.delegate = self;
            stateTxt.placeholder=@"State/Province";
        }else if(indexPath.row==9){
            zipcodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            zipcodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            zipcodeTxt.textAlignment=NSTextAlignmentRight;
            zipcodeTxt.text=pvo.zipcode;
            [cell.contentView addSubview:zipcodeTxt];
            zipcodeTxt.delegate = self;
            zipcodeTxt.placeholder=@"Zip Code";
        }else if(indexPath.row==10){
            emailTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            emailTxt.textAlignment=NSTextAlignmentRight;
            emailTxt.text=pvo.email;
            [cell.contentView addSubview:emailTxt];
            emailTxt.delegate = self;
            emailTxt.placeholder=@"E-mail";
        }else if(indexPath.row==11){
            countryTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            countryTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            countryTxt.textAlignment=NSTextAlignmentRight;
            countryTxt.text=pvo.country;
            [cell.contentView addSubview:countryTxt];
            countryTxt.delegate = self;
            countryTxt.placeholder=@"Country";
        }else if(indexPath.row==12){
            phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            phoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            phoneTxt.textAlignment=NSTextAlignmentRight;
            phoneTxt.text=pvo.phone;
            [cell.contentView addSubview:phoneTxt];
            [phoneTxt setKeyboardType:UIKeyboardTypeNumberPad];
            phoneTxt.delegate = self;
            phoneTxt.placeholder=@"Phone";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            phoneTxt.inputAccessoryView = numberToolbar;
            
        }else if(indexPath.row==13){
            selectTimezoneTxt= [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            selectTimezoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            selectTimezoneTxt.textAlignment=NSTextAlignmentRight;
            selectTimezoneTxt.text=pvo.timezone;
            [cell.contentView addSubview:selectTimezoneTxt];
            selectTimezoneTxt.delegate = self;
            selectTimezoneTxt.placeholder=@"Select Timezone";
        }else if(indexPath.row==14){
            uplineSAMDTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            uplineSAMDTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            uplineSAMDTxt.textAlignment=NSTextAlignmentRight;
            SAMDstr=pvo.uplineSA_MD;
            [self  samddisplayInfo1];
            [cell.contentView addSubview:uplineSAMDTxt];
            uplineSAMDTxt.delegate = self;
            uplineSAMDTxt.placeholder=@"Select upline SA or MD ";
        }else if(indexPath.row==15){
            uplineceoevcTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            uplineceoevcTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            uplineceoevcTxt.textAlignment=NSTextAlignmentRight;
            uplineceoStr=pvo.ceo_evc;
            [self ceodisplayInfo2];
            [cell.contentView addSubview:uplineceoevcTxt];
            uplineceoevcTxt.delegate = self;
            uplineceoevcTxt.placeholder=@"Upline CEO/EVC";
            
        }else if(indexPath.row==16){
            uplineSmdEmdTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            uplineSmdEmdTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            uplineSmdEmdTxt.textAlignment=NSTextAlignmentRight;
            uplinesmdStr=pvo.smd_emd;
            [self  smddisplayInfo3];
            [cell.contentView addSubview:uplineSmdEmdTxt];
            uplineSmdEmdTxt.delegate = self;
            uplineSmdEmdTxt.placeholder=@"Upline SMD/EMD ";
        }else if(indexPath.row==17){
            usernameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            usernameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            usernameTxt.textAlignment=NSTextAlignmentRight;
            usernameTxt.enabled=NO;
            usernameTxt.text=pvo.username;
            [cell.contentView addSubview:usernameTxt];
            usernameTxt.delegate = self;
            usernameTxt.placeholder=@"Username";
        }else if(indexPath.row==18){
            currentPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            currentPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            currentPasswordTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:currentPasswordTxt];
            currentPasswordTxt.delegate = self;
            currentPasswordTxt.placeholder=@"Current Password";
        }else if(indexPath.row==19){
            NewPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            NewPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            NewPasswordTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:NewPasswordTxt];
            NewPasswordTxt.delegate = self;
            NewPasswordTxt.placeholder=@"New Password";
        }else if(indexPath.row==20){
            passRetTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
            passRetTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            passRetTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:passRetTxt];
            passRetTxt.delegate = self;
            passRetTxt.placeholder=@"New Password Repeat";
        }else if (indexPath.row==21){
            updateProfile = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [updateProfile setTitle:@"UPDATE PROFILE" forState:UIControlStateNormal];
            [updateProfile setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [updateProfile addTarget:self action:@selector(postDatas) forControlEvents:UIControlEventTouchUpInside];
            [updateProfile removeFromSuperview];
            [cell.contentView addSubview:updateProfile];
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
        yournameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        yournameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        yournameTxt.textAlignment=NSTextAlignmentRight;
        yournameTxt.text=pvo.firstname;
        [cell.contentView addSubview:yournameTxt];
        yournameTxt.delegate = self;
        yournameTxt.placeholder=@"First Name";
    }else if(indexPath.row==1){
        firstlastTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        firstlastTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        firstlastTxt.textAlignment=NSTextAlignmentRight;
        firstlastTxt.text=pvo.lastname;
        [cell.contentView addSubview:firstlastTxt];
        firstlastTxt.delegate = self;
        firstlastTxt.placeholder=@"Last Name";
    }else if(indexPath.row==2){
        levelTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        levelTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        levelTxt.textAlignment=NSTextAlignmentRight;
         levelTxt.text=pvo.level;
        [cell.contentView addSubview:levelTxt];
        levelTxt.delegate = self;
        levelTxt.placeholder=@"Select Level";
    }else if(indexPath.row==3){
        agentCodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        agentCodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        agentCodeTxt.textAlignment=NSTextAlignmentRight;
        agentCodeTxt.text=pvo.agentid;
        [cell.contentView addSubview:agentCodeTxt];
        agentCodeTxt.delegate = self;
        agentCodeTxt.placeholder=@"Agent id";
    
    }else if(indexPath.row==4){
        licensesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        licensesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        licensesTxt.textAlignment=NSTextAlignmentRight;
        licensesTxt.enabled=NO;
        licensesTxt.text=pvo.licenses;
        [cell.contentView addSubview:licensesTxt];
        licensesTxt.delegate = self;
        licensesTxt.placeholder=@"Licenses";
    }else if(indexPath.row==5){
        languagesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        languagesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        languagesTxt.textAlignment=NSTextAlignmentRight;
        languagesTxt.enabled=NO;
        languagesTxt.text=pvo.language;
        [cell.contentView addSubview:languagesTxt];
        languagesTxt.delegate = self;
        languagesTxt.placeholder=@"Languages";
    }else if(indexPath.row==6){
        addressTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        addressTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        addressTxt.textAlignment=NSTextAlignmentRight;
        addressTxt.text=pvo.address;
        [cell.contentView addSubview:addressTxt];
        addressTxt.delegate = self;
        addressTxt.placeholder=@"Address";
    }else if(indexPath.row==7){
        cityTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        cityTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        cityTxt.textAlignment=NSTextAlignmentRight;
        cityTxt.text=pvo.city;
        [cell.contentView addSubview:cityTxt];
        cityTxt.delegate = self;
        cityTxt.placeholder=@"City";
    }else if(indexPath.row==8){
        stateTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        stateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        stateTxt.textAlignment=NSTextAlignmentRight;
        stateTxt.text=pvo.state;
        [cell.contentView addSubview:stateTxt];
        stateTxt.delegate = self;
        stateTxt.placeholder=@"State/Province";
    }else if(indexPath.row==9){
        zipcodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        zipcodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        zipcodeTxt.textAlignment=NSTextAlignmentRight;
        zipcodeTxt.text=pvo.zipcode;
        [cell.contentView addSubview:zipcodeTxt];
        zipcodeTxt.delegate = self;
        zipcodeTxt.placeholder=@"Zip Code";
    }else if(indexPath.row==10){
        emailTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        emailTxt.textAlignment=NSTextAlignmentRight;
        emailTxt.text=pvo.email;
        [cell.contentView addSubview:emailTxt];
        emailTxt.delegate = self;
        emailTxt.placeholder=@"E-mail";
    }else if(indexPath.row==11){
        countryTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        countryTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        countryTxt.textAlignment=NSTextAlignmentRight;
        countryTxt.text=pvo.country;
        [cell.contentView addSubview:countryTxt];
        countryTxt.delegate = self;
        countryTxt.placeholder=@"Country";
    }else if(indexPath.row==12){
        phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        phoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        phoneTxt.textAlignment=NSTextAlignmentRight;
        phoneTxt.text=pvo.phone;
        [cell.contentView addSubview:phoneTxt];
        [phoneTxt setKeyboardType:UIKeyboardTypeNumberPad];
        phoneTxt.delegate = self;
        phoneTxt.placeholder=@"Phone";
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        phoneTxt.inputAccessoryView = numberToolbar;

    }else if(indexPath.row==13){
        selectTimezoneTxt= [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        selectTimezoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        selectTimezoneTxt.textAlignment=NSTextAlignmentRight;
        selectTimezoneTxt.text=pvo.timezone;
        [cell.contentView addSubview:selectTimezoneTxt];
        selectTimezoneTxt.delegate = self;
        selectTimezoneTxt.placeholder=@"Select Timezone";
    }else if(indexPath.row==14){
        uplineSAMDTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        uplineSAMDTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        uplineSAMDTxt.textAlignment=NSTextAlignmentRight;
        SAMDstr=pvo.uplineSA_MD;
        [self  samddisplayInfo1];
        [cell.contentView addSubview:uplineSAMDTxt];
        uplineSAMDTxt.delegate = self;
        uplineSAMDTxt.placeholder=@"Select upline SA or MD ";
    }else if(indexPath.row==15){
        uplineceoevcTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        uplineceoevcTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        uplineceoevcTxt.textAlignment=NSTextAlignmentRight;
        uplineceoStr=pvo.ceo_evc;
        [self ceodisplayInfo2];
        [cell.contentView addSubview:uplineceoevcTxt];
        uplineceoevcTxt.delegate = self;
        uplineceoevcTxt.placeholder=@"Upline CEO/EVC";
        
    }else if(indexPath.row==16){
        uplineSmdEmdTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        uplineSmdEmdTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        uplineSmdEmdTxt.textAlignment=NSTextAlignmentRight;
        uplinesmdStr=pvo.smd_emd;
        [self  smddisplayInfo3];
        [cell.contentView addSubview:uplineSmdEmdTxt];
        uplineSmdEmdTxt.delegate = self;
        uplineSmdEmdTxt.placeholder=@"Upline SMD/EMD ";
    }else if(indexPath.row==17){
        usernameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        usernameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        usernameTxt.textAlignment=NSTextAlignmentRight;
        usernameTxt.enabled=NO;
        usernameTxt.text=pvo.username;
        [cell.contentView addSubview:usernameTxt];
        usernameTxt.delegate = self;
        usernameTxt.placeholder=@"Username";
    }else if(indexPath.row==18){
        currentPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        currentPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        currentPasswordTxt.textAlignment=NSTextAlignmentRight;
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        //currentPasswordTxt.text=[prefspassword objectForKey:@"password"];
        [currentPasswordTxt setSecureTextEntry:YES];
        [cell.contentView addSubview:currentPasswordTxt];
        currentPasswordTxt.delegate = self;
        currentPasswordTxt.placeholder=@"Current Password";
    }else if(indexPath.row==19){
        NewPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        NewPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        NewPasswordTxt.textAlignment=NSTextAlignmentRight;
        [NewPasswordTxt setSecureTextEntry:YES];
        [cell.contentView addSubview:NewPasswordTxt];
        NewPasswordTxt.delegate = self;
        NewPasswordTxt.placeholder=@"New Password";
    }else if(indexPath.row==20){
        passRetTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,150,55)];
        passRetTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        passRetTxt.textAlignment=NSTextAlignmentRight;
        [passRetTxt setSecureTextEntry:YES];
        [cell.contentView addSubview:passRetTxt];
        passRetTxt.delegate = self;
        passRetTxt.placeholder=@"New Password Repeat";
    }else if (indexPath.row==21){
        updateProfile = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
        [updateProfile setTitle:@"UPDATE PROFILE" forState:UIControlStateNormal];
        [updateProfile setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [updateProfile addTarget:self action:@selector(postDatas) forControlEvents:UIControlEventTouchUpInside];
        [updateProfile removeFromSuperview];
        [cell.contentView addSubview:updateProfile];
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
            yournameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            yournameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            yournameTxt.textAlignment=NSTextAlignmentRight;
            yournameTxt.text=pvo.firstname;
            [cell.contentView addSubview:yournameTxt];
            yournameTxt.delegate = self;
            yournameTxt.placeholder=@"First Name";
        }else if(indexPath.row==1){
            firstlastTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            firstlastTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            firstlastTxt.textAlignment=NSTextAlignmentRight;
            firstlastTxt.text=pvo.lastname;
            [cell.contentView addSubview:firstlastTxt];
            firstlastTxt.delegate = self;
            firstlastTxt.placeholder=@"Last Name";
        }else if(indexPath.row==2){
            levelTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            levelTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            levelTxt.textAlignment=NSTextAlignmentRight;
            levelTxt.text=pvo.level;
            [cell.contentView addSubview:levelTxt];
            levelTxt.delegate = self;
            levelTxt.placeholder=@"Select Level";
        }else if(indexPath.row==3){
            agentCodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            agentCodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            agentCodeTxt.textAlignment=NSTextAlignmentRight;
            agentCodeTxt.text=pvo.agentid;
            [cell.contentView addSubview:agentCodeTxt];
            agentCodeTxt.delegate = self;
            agentCodeTxt.placeholder=@"Agent id";
            
        }else if(indexPath.row==4){
            licensesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            licensesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            licensesTxt.textAlignment=NSTextAlignmentRight;
            licensesTxt.enabled=NO;
            licensesTxt.text=pvo.licenses;
            [cell.contentView addSubview:licensesTxt];
            licensesTxt.delegate = self;
            licensesTxt.placeholder=@"Licenses";
        }else if(indexPath.row==5){
            languagesTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            languagesTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            languagesTxt.textAlignment=NSTextAlignmentRight;
            languagesTxt.enabled=NO;
            languagesTxt.text=pvo.language;
            [cell.contentView addSubview:languagesTxt];
            languagesTxt.delegate = self;
            languagesTxt.placeholder=@"Languages";
        }else if(indexPath.row==6){
            addressTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            addressTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            addressTxt.textAlignment=NSTextAlignmentRight;
            addressTxt.text=pvo.address;
            [cell.contentView addSubview:addressTxt];
            addressTxt.delegate = self;
            addressTxt.placeholder=@"Address";
        }else if(indexPath.row==7){
            cityTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            cityTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            cityTxt.textAlignment=NSTextAlignmentRight;
            cityTxt.text=pvo.city;
            [cell.contentView addSubview:cityTxt];
            cityTxt.delegate = self;
            cityTxt.placeholder=@"City";
        }else if(indexPath.row==8){
            stateTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            stateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            stateTxt.textAlignment=NSTextAlignmentRight;
            stateTxt.text=pvo.state;
            [cell.contentView addSubview:stateTxt];
            stateTxt.delegate = self;
            stateTxt.placeholder=@"State/Province";
        }else if(indexPath.row==9){
            zipcodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            zipcodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            zipcodeTxt.textAlignment=NSTextAlignmentRight;
            zipcodeTxt.text=pvo.zipcode;
            [cell.contentView addSubview:zipcodeTxt];
            zipcodeTxt.delegate = self;
            zipcodeTxt.placeholder=@"Zip Code";
        }else if(indexPath.row==10){
            emailTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            emailTxt.textAlignment=NSTextAlignmentRight;
            emailTxt.text=pvo.email;
            [cell.contentView addSubview:emailTxt];
            emailTxt.delegate = self;
            emailTxt.placeholder=@"E-mail";
        }else if(indexPath.row==11){
            countryTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            countryTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            countryTxt.textAlignment=NSTextAlignmentRight;
            countryTxt.text=pvo.country;
            [cell.contentView addSubview:countryTxt];
            countryTxt.delegate = self;
            countryTxt.placeholder=@"Country";
        }else if(indexPath.row==12){
            phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            phoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            phoneTxt.textAlignment=NSTextAlignmentRight;
            phoneTxt.text=pvo.phone;
            [cell.contentView addSubview:phoneTxt];
            [phoneTxt setKeyboardType:UIKeyboardTypeNumberPad];
            phoneTxt.delegate = self;
            phoneTxt.placeholder=@"Phone";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            phoneTxt.inputAccessoryView = numberToolbar;
            
        }else if(indexPath.row==13){
            selectTimezoneTxt= [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            selectTimezoneTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            selectTimezoneTxt.textAlignment=NSTextAlignmentRight;
            selectTimezoneTxt.text=pvo.timezone;
            [cell.contentView addSubview:selectTimezoneTxt];
            selectTimezoneTxt.delegate = self;
            selectTimezoneTxt.placeholder=@"Select Timezone";
        }else if(indexPath.row==14){
            uplineSAMDTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            uplineSAMDTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            uplineSAMDTxt.textAlignment=NSTextAlignmentRight;
            SAMDstr=pvo.uplineSA_MD;
            [self  samddisplayInfo1];
            [cell.contentView addSubview:uplineSAMDTxt];
            uplineSAMDTxt.delegate = self;
            uplineSAMDTxt.placeholder=@"Select upline SA or MD ";
        }else if(indexPath.row==15){
            uplineceoevcTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            uplineceoevcTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            uplineceoevcTxt.textAlignment=NSTextAlignmentRight;
            uplineceoStr=pvo.ceo_evc;
            [self ceodisplayInfo2];
            [cell.contentView addSubview:uplineceoevcTxt];
            uplineceoevcTxt.delegate = self;
            uplineceoevcTxt.placeholder=@"Upline CEO/EVC";
            
        }else if(indexPath.row==16){
            uplineSmdEmdTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            uplineSmdEmdTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            uplineSmdEmdTxt.textAlignment=NSTextAlignmentRight;
            uplinesmdStr=pvo.smd_emd;
            [self  smddisplayInfo3];
            [cell.contentView addSubview:uplineSmdEmdTxt];
            uplineSmdEmdTxt.delegate = self;
            uplineSmdEmdTxt.placeholder=@"Upline SMD/EMD ";
        }else if(indexPath.row==17){
            usernameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            usernameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            usernameTxt.textAlignment=NSTextAlignmentRight;
            usernameTxt.enabled=NO;
            usernameTxt.text=pvo.username;
            [cell.contentView addSubview:usernameTxt];
            usernameTxt.delegate = self;
            usernameTxt.placeholder=@"Username";
        }else if(indexPath.row==18){
            currentPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            currentPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            currentPasswordTxt.textAlignment=NSTextAlignmentRight;
            NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
            //currentPasswordTxt.text=[prefspassword objectForKey:@"password"];
            [cell.contentView addSubview:currentPasswordTxt];
            currentPasswordTxt.delegate = self;
            currentPasswordTxt.placeholder=@"Current Password";
        }else if(indexPath.row==19){
            NewPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            NewPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            NewPasswordTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:NewPasswordTxt];
            NewPasswordTxt.delegate = self;
            NewPasswordTxt.placeholder=@"New Password";
        }else if(indexPath.row==20){
            passRetTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            passRetTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            passRetTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:passRetTxt];
            passRetTxt.delegate = self;
            passRetTxt.placeholder=@"New Password Repeat";
        }else if (indexPath.row==21){
            updateProfile = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [updateProfile setTitle:@"UPDATE PROFILE" forState:UIControlStateNormal];
            [updateProfile setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [updateProfile addTarget:self action:@selector(postDatas) forControlEvents:UIControlEventTouchUpInside];
            [updateProfile removeFromSuperview];
            [cell.contentView addSubview:updateProfile];
    }
    }
    return cell;
}
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
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
