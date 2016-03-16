//
//  RegisterViewController.m
//  Chatapp
//
//  Created by arvind on 7/8/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "ModelTraineeSearchViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize yournameLbl,firstlastLbl,agentCodeLbl,agentCodeNO,authoCodeLbl,yourAuthoLbl,username,yourusernameLbl,passwordLbl,confirmPassLbl,emailLbl,yourEmailLbl,levelLbl,selectTypeLbl,uplineceoLbl,selectuplineCeoLbl,uplineSmdLbl,selectiplineSmdLbl,firstnameTxt,lastnameTxt,agentCodeTxt,authoCodeTxt,userNameTxt,passwordTxt,confirmPasswordTxt,emailTxt,levelTxt,uplineceTxt,uplineSmdTxt,createBtn,cancelBtn,scrollView,alertview_postAdvt,LevelPickerView,CEOPickerView,SMDPickerView,toolbar,toolbar1,toolbar2,dataArrayLevel,CeoArray,SmdArray,ceosmdVO,characters,activityIndicator,typeStringCeo,typeStringSmd,appDelegate,userlistTableView,lblarray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
lblarray=[[NSMutableArray alloc]initWithObjects:@"FIRST NAME",@"LAST NAME",@"AGENT CODE",@"USERNAME",@"PASSWORD",@"CONFIRM PASSWORD",@"EMAIL",@"LEVEL",@"UPLINE CEO/EVC",@"UPLINE SMD/EMD",@"PROMO CODE",@"",@"",nil];
    [firstnameTxt setDelegate:self];
    [lastnameTxt setDelegate:self];
    [agentCodeTxt setDelegate:self];
    [authoCodeTxt setDelegate:self];
    [userNameTxt setDelegate:self];
    [passwordTxt setDelegate:self];
    [confirmPasswordTxt setDelegate:self];
    [emailTxt setDelegate:self];
    [levelTxt setDelegate:self];
    [uplineceTxt setDelegate:self];
    [uplineSmdTxt setDelegate:self];
    appDelegate.checkstr=[[NSString alloc]init];

    appDelegate=[[UIApplication sharedApplication] delegate];

    self.navigationItem.hidesBackButton=YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"REGISTER"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    //self.navigationItem.title=@"Users";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden=NO;
    
    dataArrayLevel=[[NSMutableArray alloc]init];
    CeoArray=[[NSMutableArray alloc]init];
    SmdArray=[[NSMutableArray alloc]init];
    
    dataArrayLevel=[[NSMutableArray alloc]initWithObjects:@"TA",@"A",@"SA",@"MD",@"SMD",@"EMD",@"CEO",@"EVC",nil];
    //CeoArray=[[NSMutableArray alloc]initWithObjects:@"Upline CEO/EVC",@"kashrastan",@"BrittanioceoEVC",@"visionbuilders",@"mcoleman",@"freedombuilders",@"frank",@"n_sandoval04",nil];
    //SmdArray=[[NSMutableArray alloc]initWithObjects:@"Brittanioceo",@"kashrastan",@"lvery40",@"BrittanioceoEVC",@"BrittanioceoEMD",@"BrittanioceoSMD",@"TeamIntegrityChamps",@"roygaytan",@"Lmceagle",@"sporty14god",@"ABELV",@"etowe",@"PGCEO",@"visionbuilders",@"fourish",@"Triumph",@"mcoleman",@"chris",@"freedombuilders",@"frank",@"n_sandoval04",@"mrgan",@"Nichilewent",@"BlanceEaton",@"Sentinels",@"Jazzy10()",@"Jayworkman",@"macari021",nil];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yheight = [UIScreen mainScreen].bounds.size.height;
    if(yheight>=568){
        scrollView.contentSize=CGSizeMake(width, yheight+500);
    }else{
        scrollView.contentSize=CGSizeMake(width, yheight+630);
    }
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(height>=480 && height<568){

        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+600);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];

        
        }else if(height>=568 && height<600){
            userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+50);
            [userlistTableView removeFromSuperview];
            [self.scrollView addSubview:userlistTableView];

        }
    
    userlistTableView.delegate = self;
    userlistTableView.dataSource = self;
    userlistTableView.scrollEnabled = NO;
    typeStringCeo=@"CEO,EVC";
    [self getDataCED];
    typeStringSmd=@"CEO,EVC,SMD,EMD";
    [self getDataSMD];    // Do any additional setup after loading the view from its nib.
}
-(IBAction)registerAction{
    
    BOOL firstname=[self validateTextField:firstnameTxt];
    BOOL lastname=[self validateTextField:lastnameTxt];
    BOOL agectcode=[self validateTextField:agentCodeTxt];
    BOOL authocode= [self validateTextField:authoCodeTxt];
    BOOL username= [self validateTextField:userNameTxt];
    BOOL password= [self validateTextField:passwordTxt];
    BOOL confpass= [self validateTextField:confirmPasswordTxt];
    BOOL email= [self validateTextField:emailTxt];
    BOOL level= [self validateTextField:levelTxt];
    BOOL unceo= [self validateTextField:uplineceTxt];
    BOOL unsmd= [self validateTextField:uplineSmdTxt];

    if(firstname && lastname && agectcode && username && password && confpass && email && level && unceo && unsmd)
    {
        
        [self registerSaveAction];
        
    }else{
        //[self mandatoryFieldvalidatios ];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Please fill up all mandatory fields!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    //[activityIndicator stopAnimating];
    
}
- (UIView *)mandatoryFieldValidation
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 145)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=11;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor whiteColor]CGColor];
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [topButton setTitle:@"BSC PRO" forState:UIControlStateNormal];
    [topButton setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=15;
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [demoView addSubview:topButton];
    
    UITextView *cmtMessage=[[UITextView alloc] initWithFrame:CGRectMake(0, 51,300,50)];
    cmtMessage.text=@"Please fill up all mandatory fields";
    cmtMessage.editable=false;
    cmtMessage.font=[UIFont systemFontOfSize:20];
    cmtMessage.backgroundColor=[UIColor blackColor];
    cmtMessage.textColor=[UIColor whiteColor];
    [demoView addSubview:cmtMessage];
    
    
    UIButton *register_ok_Button=[[UIButton alloc] initWithFrame:CGRectMake(0,102,300,40)];
    [register_ok_Button setTitle:@"OK" forState:UIControlStateNormal];
    [register_ok_Button addTarget:self
                           action:@selector(closeAlert_postAdvt:)
                 forControlEvents:UIControlEventTouchUpInside];
    [register_ok_Button setBackgroundColor:[UIColor blackColor]];
    register_ok_Button.tag=1;
    [demoView addSubview:register_ok_Button];
    
    return demoView;
}
-(void)mandatoryFieldvalidatios{
    alertview_postAdvt = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertview_postAdvt setContainerView:[self mandatoryFieldValidation]];
    
    // Modify the parameters
    
    [alertview_postAdvt setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertview_postAdvt setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView_, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView_ tag]);
        [alertView_ close];
    }];
    
    [alertview_postAdvt setUseMotionEffects:true];
    
    // And launch the dialog
    [alertview_postAdvt show];
    
}
-(void)closeAlert_postAdvt:(id)sender{
    [alertview_postAdvt close];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)validateTextField:(UITextField*)txtField{
    if (![txtField.text isEqualToString:@""])
    {
        return true;
    }
    else{
        return false;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==levelTxt)
    {
        
        uplineceTxt.text=@"";
        uplineSmdTxt.text=@"";
        
        toolbar2.hidden=YES;
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
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
    }else if(textField==uplineceTxt)
    {
        
       
        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        
        
        [uplineceTxt resignFirstResponder];
        if([appDelegate.CeoArray count]==0)
            [self getDataCED];
        else{
            ModelTraineeSearchViewController *modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController" bundle:nil];
            appDelegate.traineeListArray=appDelegate.CeoArray;
                       appDelegate.checkstr=@"CEO";
            [self presentViewController:modelvc animated:YES completion:nil];
        }
    

    
            toolbar.hidden=NO;
            [uplineceTxt resignFirstResponder];
            
            return NO;
        
    }else if(textField==uplineSmdTxt)
    {
        

        toolbar.hidden=YES;
        toolbar1.hidden=YES;
        toolbar2.hidden=YES;
        
        LevelPickerView.hidden=YES;
        CEOPickerView.hidden=YES;
        SMDPickerView.hidden=YES;
        
         [uplineSmdTxt resignFirstResponder];
        if([appDelegate.SmdArray count]==0)
            [self getDataSMD];
        else{
            ModelTraineeSearchViewController *modelvc=[[ModelTraineeSearchViewController alloc] initWithNibName:@"ModelTraineeSearchViewController" bundle:nil];
            appDelegate.traineeListArray=appDelegate.SmdArray;
                       appDelegate.checkstr=@"SMD";
            [self presentViewController:modelvc animated:YES completion:nil];
        }
        
        
            toolbar2.hidden=NO;
        
            return NO;
        
    }
    
    
    toolbar.hidden=YES;
    toolbar1.hidden=YES;
    toolbar2.hidden=YES;
    LevelPickerView.hidden=YES;
    CEOPickerView.hidden=YES;
    SMDPickerView.hidden=YES;

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)doneBtnPressed{
    if ([levelTxt.text isEqualToString:@"SMD"] || [levelTxt.text isEqualToString:@"EMD"]) {
        uplineSmdTxt.enabled=NO;
        uplineSmdTxt.text=@"I am an SMD";
         uplineceTxt.enabled=YES;
    }else if([levelTxt.text isEqualToString:@"CEO"] || [levelTxt.text isEqualToString:@"EVC"]){
        appDelegate.smduserid=@"";
        appDelegate.ceouserid=@"";
        uplineceTxt.enabled=NO;
        uplineceTxt.text=@"I am an EVC/CEO";
        uplineSmdTxt.enabled=NO;
        uplineSmdTxt.text=@"I am an SMD/EMD";
        
        
    }else{
        uplineceTxt.enabled=YES;
        uplineSmdTxt.enabled=YES;
    }

    toolbar.hidden=YES;
    toolbar1.hidden=YES;
    toolbar2.hidden=YES;
    LevelPickerView.hidden=YES;
    CEOPickerView.hidden=YES;
    SMDPickerView.hidden=YES;
    
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
        //NSString *firstString =cvo.username;
        NSString *secondString = cvo.fname;
        NSString *threestr=cvo.lname;
        str = [NSString stringWithFormat:@"%@ %@", secondString, threestr];
        [uplineceTxt setText:str];
    }else if (pickerView ==SMDPickerView)
        
    {
        CEOSMDVO *cvo=[appDelegate.SmdArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        //NSString *firstString =cvo.username;
        NSString *secondString = cvo.fname;
        NSString *threestr=cvo.lname;
        str = [NSString stringWithFormat:@"%@ %@",secondString, threestr];
        [uplineSmdTxt setText:str];
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
        //NSString *firstString =cvo.username;
        NSString *secondString = cvo.fname;
        NSString *threestr=cvo.lname;
        str = [NSString stringWithFormat:@"%@ %@", secondString, threestr];
        return str;
        
    }else{
        CEOSMDVO *cvo=[appDelegate.SmdArray objectAtIndex:row];
        NSString *str=[[NSString alloc]init];
        //NSString *firstString =cvo.username;
        NSString *secondString = cvo.fname;
        NSString *threestr=cvo.lname;
        str = [NSString stringWithFormat:@"%@ %@", secondString, threestr];
        return str;
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
-(void)getDataSMD{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{

    appDelegate.SmdArray=[[NSMutableArray alloc] init];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

    NSURL *url;
    NSMutableString *httpBodyString;
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];

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
                
                [appDelegate.SmdArray addObject:csvo];
            }
            
            
            [activityIndicator stopAnimating];
            }
        
                  }];
    
    
}
}
-(void)getDataCED{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{

    appDelegate.CeoArray=[[NSMutableArray alloc] init];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
 
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
                
                [appDelegate.CeoArray addObject:csvo];
            }
            
            
            [activityIndicator stopAnimating];
        }
        
    }];
    
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    if([uplineSmdTxt.text isEqualToString:@"I am an SMD"]){
        appDelegate.smduserid=@"";
    uplineceTxt.text= appDelegate.ceoFirstlastname;
    }else if ([uplineceTxt.text isEqualToString:@"I am an EVC/CEO"] || [uplineSmdTxt.text isEqualToString:@"I am an SMD/EMD"]){
        appDelegate.smduserid=@"";
        appDelegate.ceouserid=@"";

    }
    else{
               uplineceTxt.text= appDelegate.ceoFirstlastname;

    uplineSmdTxt.text=appDelegate.smdfirstlastname;
    }
}
-(void)registerSaveAction{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{

    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if([agentCodeTxt.text length]<4 ){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Agent code at least 4 characters in length!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];


    }else if ([passwordTxt.text length]<4){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Password at least 4 characters in length!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else if (![passwordTxt.text isEqual:confirmPasswordTxt.text]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"The confirm password field does not match the password field!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else if ([emailTest evaluateWithObject:emailTxt.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BSCPRO!" message:@"The email field must contain a vaild email address.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else if ([userNameTxt.text length]<4){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"The username filed must be at least 4 characters in length!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];

    }else{

        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"fname=%@&lname=%@&agent_id=%@&authorization_code=%@&username=%@&password=%@&confirm_password=%@&email=%@&usertype=%@&upline=%@&upline_smd=%@",firstnameTxt.text,lastnameTxt.text,agentCodeTxt.text,authoCodeTxt.text,userNameTxt.text,passwordTxt.text,confirmPasswordTxt.text,emailTxt.text,levelTxt.text,appDelegate.ceouserid,appDelegate.smduserid]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/auth_api"];
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
                NSString *mesagess = [[NSString alloc]init];
                mesagess = [userDict objectForKey:@"messgae"];
                    NSString *status = [[NSString alloc]init];
                    status = [userDict objectForKey:@"status"];

                if([status isEqualToString:@"fail"])
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:mesagess delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else if ([status isEqualToString:@"ok"]){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:mesagess delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    LoginViewController *loginvc=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                    [self.navigationController pushViewController:loginvc animated:YES];
                }
                [activityIndicator stopAnimating];

                }
            }
        }];
        [activityIndicator stopAnimating];

    }
     [activityIndicator stopAnimating];
    }
}
-(void)cancelAction{
    LoginViewController *loginvc=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginvc animated:YES];
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
    UILabel *fieldLBls=[[UILabel alloc]initWithFrame:CGRectMake(15,5,130,55)];
    [fieldLBls setText:[lblarray objectAtIndex:[indexPath row]]];
    fieldLBls.textAlignment=NSTextAlignmentLeft;
    fieldLBls.lineBreakMode = NSLineBreakByWordWrapping;
    fieldLBls.numberOfLines = 0;
    [fieldLBls setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
    [cell.contentView addSubview:fieldLBls];
    if(indexPath.row==0){
        firstnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        firstnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        firstnameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:firstnameTxt];
        firstnameTxt.delegate = self;
        firstnameTxt.placeholder=@"First Name";
    }else if(indexPath.row==1){
        lastnameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        lastnameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        lastnameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lastnameTxt];
        lastnameTxt.delegate = self;
        lastnameTxt.placeholder=@"Last Name";
    }else if(indexPath.row==2){
        agentCodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        agentCodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        agentCodeTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:agentCodeTxt];
        agentCodeTxt.delegate = self;
        agentCodeTxt.placeholder=@"Agent Id";

    }else if(indexPath.row==10){
        authoCodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        authoCodeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        authoCodeTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:authoCodeTxt];
        authoCodeTxt.delegate = self;
        authoCodeTxt.placeholder=@"Optional";
        
           }else if(indexPath.row==3){
        userNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        userNameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        userNameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:userNameTxt];
        userNameTxt.delegate = self;
        userNameTxt.placeholder=@"User Name";
    }else if(indexPath.row==4){
        passwordTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        passwordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        passwordTxt.textAlignment=NSTextAlignmentRight;
        [passwordTxt setSecureTextEntry:YES];
        [cell.contentView addSubview:passwordTxt];
        passwordTxt.delegate = self;
        passwordTxt.placeholder=@"Password";
    }else if(indexPath.row==5){
        confirmPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        confirmPasswordTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        confirmPasswordTxt.textAlignment=NSTextAlignmentRight;
        [confirmPasswordTxt setSecureTextEntry:YES];
        [cell.contentView addSubview:confirmPasswordTxt];
        confirmPasswordTxt.delegate = self;
        confirmPasswordTxt.placeholder=@"Confirm Password";
    }else if(indexPath.row==6){
        emailTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        emailTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        emailTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:emailTxt];
        emailTxt.delegate = self;
        emailTxt.placeholder=@"Email";
    }else if(indexPath.row==7){
        levelTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        levelTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        levelTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:levelTxt];
        levelTxt.delegate = self;
        levelTxt.placeholder=@"Select Type";
    }else if(indexPath.row==8){
        uplineceTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        uplineceTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        uplineceTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:uplineceTxt];
        uplineceTxt.delegate = self;
        uplineceTxt.placeholder=@"Upline CEO/EVC";
    }else if(indexPath.row==9){
        uplineSmdTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        uplineSmdTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        uplineSmdTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:uplineSmdTxt];
        uplineSmdTxt.delegate = self;
        uplineSmdTxt.placeholder=@"Select Your SMD";
    }else if (indexPath.row==11){
        createBtn = [[UIButton alloc] initWithFrame:CGRectMake(30,5,250,40)];
        [createBtn setTitle:@"CREATE ACCOUNT" forState:UIControlStateNormal];
        [createBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [createBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [createBtn removeFromSuperview];
        [cell.contentView addSubview:createBtn];
        
        
        
    }else if (indexPath.row==12){
        cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(60,5,165,40)];
        [cancelBtn setTitle:@"CANCEL" forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn removeFromSuperview];
        [cell.contentView addSubview:cancelBtn];
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
