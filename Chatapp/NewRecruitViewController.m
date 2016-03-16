//
//  NewRecruitViewController.m
//  Chatapp
//
//  Created by arvind on 7/15/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "NewRecruitViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"

@interface NewRecruitViewController ()

@end

@implementation NewRecruitViewController
@synthesize newrLBl,hireDateLbl,nameLbl,inviterLbl,contactLbl,codeLbl,followLbl,hireDateTxt,nameTxt,inviterTxt,contactTxt,codeTxt,followUpTxtView,submitBtn,complete_amaLbl,submit_licLbl,meet_spouseLbl,prospect_listLbl,field_trainingsLbl,FNALbl,Three_3_30BLbl,Fast_schoolLbl,complete_amaBtn,submit_licBtn,meet_spouseBtn,prospect_listBtn,field_trainingsBtn,FNABtn,Three_3_30Btn,Fast_schoolBtn,completeStr,submitStr,meetStr,prospectStr,fieldStr,fnaStr,threeStr,fastStr,activityIndicator,datepicker,dateToobar,starttime,theDate,timeDuration,bgimage,viewUp,scrollView,userlistTableView,lblarray,dateString,fieldTraning,fieldTraPickerView,toolbarFieldTra,fieldTraArray,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
lblarray=[[NSMutableArray alloc]initWithObjects:@"HIRE DATE",@"NAME",@"INVITER",@"CONTACT",@"CODE",@"",@"",@"",@"",@"",@"",nil];
    fieldTraArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    [contactTxt setDelegate:self];
    [hireDateTxt setDelegate:self];
    [nameTxt setDelegate:self];
    [inviterTxt setDelegate:self];
    [codeTxt setDelegate:self];
    completeStr=@"0";
    submitStr=@"0";
    fnaStr=@"0";
    meetStr=@"0";
    prospectStr=@"0";
    threeStr=@"0";
    fastStr=@"0";
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    [titleLabel setText:@"NEW RECRUIT"];
    
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:formDate];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"LL/dd/YYYY"];
    theDate = [dateFormatter stringFromDate:now];
    dateString=theDate;
    datepicker.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    CGFloat yheight = [UIScreen mainScreen].bounds.size.height;
    if(yheight>=568){
        //self.scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        bgimage.image=[UIImage imageNamed:@"background.png"];
       

        
    }else{
        bgimage.image=[UIImage imageNamed:@"background.png"];
       
    }
    hireDateTxt.layer.borderColor=[[UIColor whiteColor]CGColor];
    hireDateTxt.layer.borderWidth = 0.5f;
    dateToobar.hidden=YES;
    
    datepicker.hidden=YES;
    datepicker.backgroundColor = [UIColor whiteColor];
       CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yzheight = [UIScreen mainScreen].bounds.size.height;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
    if(height>=480 && height<568){
        scrollView.contentSize=CGSizeMake(width, yzheight+500);

        datepicker.frame=CGRectMake(0, 350,self.scrollView.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height+200);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];

    }else if(height>=568 && height<600){
 
        scrollView.contentSize=CGSizeMake(width, yzheight+500);

        datepicker.frame=CGRectMake(0, 350,self.scrollView.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-60);
        [userlistTableView removeFromSuperview];
        [self.scrollView addSubview:userlistTableView];
    }else{
        scrollView.contentSize=CGSizeMake(width, yzheight+300);
        datepicker.frame=CGRectMake(0, 350,self.scrollView.bounds.size.width, 162);
        [datepicker removeFromSuperview];
        [self.view addSubview:datepicker];
    }
    }
    
    userlistTableView.delegate = self;
    userlistTableView.dataSource = self;
    userlistTableView.scrollEnabled = NO;

    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==hireDateTxt){
        
        if(viewUp==YES){
            viewUp=NO;
            //[self animateTextView:NO];
        }
        
        if(viewUp==NO){
            viewUp=YES;
            //[self animateTextView:YES];
        }
        toolbarFieldTra.hidden=YES;
        fieldTraPickerView.hidden=YES;

        dateToobar.hidden=YES;
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

        [hireDateTxt resignFirstResponder];

        return NO;
    }else if(textField==fieldTraning)
    {
        [self.view endEditing:YES];
        dateToobar.hidden=YES;
        datepicker.hidden=NO;
        toolbarFieldTra.hidden=YES;
        fieldTraPickerView.hidden=YES;
        
        
        fieldTraPickerView = [[UIPickerView alloc] init];
        [fieldTraPickerView setDataSource: self];
        [fieldTraPickerView setDelegate: self];
        fieldTraPickerView.backgroundColor = [UIColor whiteColor];
        [fieldTraPickerView setFrame: CGRectMake(0,355,self.view.bounds.size.width,200)];
        fieldTraPickerView.showsSelectionIndicator = YES;
        [fieldTraPickerView selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: fieldTraPickerView];
        fieldTraPickerView.hidden=NO;
        toolbarFieldTra= [[UIToolbar alloc] initWithFrame:CGRectMake(0,315,self.view.bounds.size.width,44)];
        [toolbarFieldTra setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPresseds)];
        toolbarFieldTra.items = @[barButtonDone];
        barButtonDone.tintColor=[UIColor whiteColor];
        [self.view addSubview:toolbarFieldTra];
        
        toolbarFieldTra.hidden=NO;
        [fieldTraning resignFirstResponder];
        
        return NO;
        
    }
    toolbarFieldTra.hidden=YES;
    fieldTraPickerView.hidden=YES;

    dateToobar.hidden=YES;
    datepicker.hidden=YES;
    return YES;
}
-(IBAction)doneBtnPresseds{
//    NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
//    [f2 setDateFormat:@"LL/dd/YYYY"];
//    NSString *s = [f2 stringFromDate:datepicker.date];
    //hireDateTxt.text=[[NSString alloc]initWithFormat:@"%@",s];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"PST"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
   dateString = [dateFormatter stringFromDate:datepicker.date];
    hireDateTxt.text= [dateFormatter stringFromDate:datepicker.date];
       dateToobar.hidden=YES;
        datepicker.hidden=YES;
    toolbarFieldTra.hidden=YES;
    fieldTraPickerView.hidden=YES;

}

-(void)radiobuttonSelected:(id)sender{
    
        switch ([sender tag]) {
            case 0:
                if([complete_amaBtn isSelected]==YES)
                {
                    [complete_amaBtn setSelected:NO];
                    completeStr=@"0";

                }
                else{
                    [complete_amaBtn setSelected:YES];
                    completeStr=@"1";
                }
                
                break;
            case 1:
                if([submit_licBtn isSelected]==YES)
                {
                    [submit_licBtn setSelected:NO];
                       submitStr=@"0";           }
                else{
                    [submit_licBtn setSelected:YES];
                         submitStr=@"1";
                }
                
                break;
            case 2:
                if([field_trainingsBtn isSelected]==YES)
                {
                    [field_trainingsBtn setSelected:NO];
                    fieldStr=@"0";

                }
                else{
                    [field_trainingsBtn setSelected:YES];
                    fieldStr=@"1";
                }
                
                break;

            case 3:
                if([FNABtn isSelected]==YES)
                {
                    [FNABtn setSelected:NO];
                    fnaStr=@"0";
                }
                else{
                    [FNABtn setSelected:YES];
                    fnaStr=@"1";
                }
                break;

            case 4:
                if([meet_spouseBtn isSelected]==YES)
                {
                    [meet_spouseBtn setSelected:NO];
                    meetStr=@"0";

                }
                else{
                    [meet_spouseBtn setSelected:YES];
                    meetStr=@"1";
                }
                
                break;

            case 5:
                if([prospect_listBtn isSelected]==YES)
                {
                    [prospect_listBtn setSelected:NO];
                    prospectStr=@"0";

                }
                else{
                    [prospect_listBtn setSelected:YES];
                    prospectStr=@"1";
                }
                
                break;

            case 6:
                if([Three_3_30Btn isSelected]==YES)
                {
                    [Three_3_30Btn setSelected:NO];
                    threeStr=@"0";
                }
                else{
                    [Three_3_30Btn setSelected:YES];
                    threeStr=@"1";
                }
                
                break;
            case 7:
                if([Fast_schoolBtn isSelected]==YES)
                {
                    [Fast_schoolBtn setSelected:NO];
                    fastStr=@"0";
                }
                else{
                    [Fast_schoolBtn setSelected:YES];
                    fastStr=@"1";
                }
                
                break;
          

        }
    }

-(void)doneWithNumberPad{
    [contactTxt resignFirstResponder];
    [fieldTraning resignFirstResponder];

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: fieldTraPickerView]) {
        return [fieldTraArray count];
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
    if (pickerView ==fieldTraPickerView)
    {
        [fieldTraning setText:[NSString stringWithFormat:@"%@",[fieldTraArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == fieldTraPickerView)
    {
        return [fieldTraArray objectAtIndex:row];
        
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==contactTxt){
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

    if([nameTxt.text isEqualToString:@""] || [inviterTxt.text isEqualToString:@""] || [contactTxt.text isEqualToString:@""] ||[codeTxt.text isEqualToString:@""] || [followUpTxtView.text isEqualToString:@""]){
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
       // hireDateTxt.text=[[NSString alloc]initWithFormat:@"%@",s];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//[dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        //dateString = [dateFormatter stringFromDate:datepicker.date];
        
        
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&hire_date=%@&name=%@&inviter=%@&contact=%@&code=%@&follow_up=%@&complete_ama=%@&submit_lic=%@&meet_spouse=%@&prospect_list=%@&field_trainings=%@&FNA=%@&Three_3_30=%@&Fast_school=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],hireDateTxt.text,nameTxt.text,inviterTxt.text,contactTxt.text,codeTxt.text,followUpTxtView.text,completeStr,submitStr,meetStr,prospectStr,fieldTraning.text,fnaStr,threeStr,fastStr]];
   
        
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/speedfilter_api/"];
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
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Error adding new recruit, Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([status isEqualToString:@"ok"]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"New recruit added successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
-(void)clearData{
    hireDateTxt.text=@"";
    nameTxt.text=@"";
    inviterTxt.text=@"";
    contactTxt.text=@"";
    codeTxt.text=@"";
    fieldTraning.text=@"";
    followUpTxtView.text=@"";
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
            hireDateTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            hireDateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            hireDateTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:hireDateTxt];
            hireDateTxt.delegate = self;
            hireDateTxt.placeholder=@"Select Date";
            hireDateTxt.text=theDate;

        }else if(indexPath.row==1){
            nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            nameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            nameTxt.textAlignment=NSTextAlignmentRight;
            nameTxt.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
            [cell.contentView addSubview:nameTxt];
            nameTxt.delegate = self;
            nameTxt.placeholder=@"First and Last Name";
        }else if(indexPath.row==2){
            inviterTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            inviterTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            inviterTxt.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
            inviterTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:inviterTxt];
            inviterTxt.delegate = self;
            inviterTxt.placeholder=@"First and Last Name";
        }else if(indexPath.row==3){
            contactTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            contactTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            contactTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:contactTxt];
            [contactTxt setKeyboardType:UIKeyboardTypeNumberPad];
            contactTxt.delegate = self;
            contactTxt.placeholder=@"__-__-___";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            contactTxt.inputAccessoryView = numberToolbar;
        }else if(indexPath.row==4){
            codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
            codeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            codeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:codeTxt];
            codeTxt.delegate = self;
            codeTxt.placeholder=@"Code #";
            
        }else if(indexPath.row==5){
            complete_amaLbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
            [complete_amaLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            complete_amaLbl.text=@"COMPLETE AMA";
            [cell.contentView addSubview:complete_amaLbl];
            
            complete_amaBtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
            [complete_amaBtn setTag:0];
            [complete_amaBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [complete_amaBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [complete_amaBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [complete_amaBtn removeFromSuperview];
            [cell.contentView addSubview:complete_amaBtn];
            
            meet_spouseLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
            [meet_spouseLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            meet_spouseLbl.text=@"MEET SPOUSE";
            
            [cell.contentView addSubview:meet_spouseLbl];
            
            
            meet_spouseBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [meet_spouseBtn setTag:4];
            [meet_spouseBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [meet_spouseBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [meet_spouseBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [meet_spouseBtn removeFromSuperview];
            [cell.contentView addSubview:meet_spouseBtn];
            
        }else if(indexPath.row==6){
            
            submit_licLbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
            [submit_licLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            submit_licLbl.text=@"SUBMTI LIC";
            [cell.contentView addSubview:submit_licLbl];
            
            submit_licBtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
            [submit_licBtn setTag:1];
            [submit_licBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [submit_licBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [submit_licBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [submit_licBtn removeFromSuperview];
            [cell.contentView addSubview:submit_licBtn];
            
            prospect_listLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
            [prospect_listLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            prospect_listLbl.text=@"PROSPECT LIST";
            
            [cell.contentView addSubview:prospect_listLbl];
            
            
            prospect_listBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [prospect_listBtn setTag:5];
            [prospect_listBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [prospect_listBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [prospect_listBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [prospect_listBtn removeFromSuperview];
            [cell.contentView addSubview:prospect_listBtn];
            
            
        }else if(indexPath.row==7){
            fieldTraning = [[UITextField alloc] initWithFrame:CGRectMake(10,5,80,60)];
            fieldTraning.font=[UIFont fontWithName:@"Calibri" size:16.0];
            fieldTraning.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:fieldTraning];
            fieldTraning.delegate = self;
            fieldTraning.placeholder=@"Field Training";
            
            Three_3_30BLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
            [Three_3_30BLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            Three_3_30BLbl.text=@"3-3-30";
            
            [cell.contentView addSubview:Three_3_30BLbl];
            
            
            Three_3_30Btn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [Three_3_30Btn setTag:6];
            [Three_3_30Btn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [Three_3_30Btn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [Three_3_30Btn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [Three_3_30Btn removeFromSuperview];
            [cell.contentView addSubview:Three_3_30Btn];

        }else if(indexPath.row==8){
            FNALbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
            [FNALbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            FNALbl.text=@"FNA";
            [cell.contentView addSubview:FNALbl];
            
            FNABtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
            [FNABtn setTag:3];
            [FNABtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [FNABtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [FNABtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [FNABtn removeFromSuperview];
            [cell.contentView addSubview:FNABtn];
            
            Fast_schoolLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,100,60)];
            [Fast_schoolLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            Fast_schoolLbl.text=@"FAST START SCHOOL";
            Fast_schoolLbl.lineBreakMode = NSLineBreakByWordWrapping;
            Fast_schoolLbl.numberOfLines = 0;

            [cell.contentView addSubview:Fast_schoolLbl];
            
            
            Fast_schoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [Fast_schoolBtn setTag:7];
            [Fast_schoolBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [Fast_schoolBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [Fast_schoolBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [Fast_schoolBtn removeFromSuperview];
            [cell.contentView addSubview:Fast_schoolBtn];
            
        }else if(indexPath.row==9){
            followLbl = [[UILabel alloc] initWithFrame:CGRectMake(15,5,150,55)];
            [followLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            followLbl.text=@"FOLLOW UP";
            [cell.contentView addSubview:followLbl];
            
            followUpTxtView= [[UITextField alloc] initWithFrame:CGRectMake(130,5,150,55)];
            followUpTxtView.font=[UIFont fontWithName:@"Calibri" size:16.0];
            followUpTxtView.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:followUpTxtView];
            followUpTxtView.delegate = self;
            followUpTxtView.placeholder=@"Follow Up";
        }else if(indexPath.row==10){
            submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [submitBtn setTitle:@"SUBMIT" forState:UIControlStateNormal];
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [submitBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [submitBtn removeFromSuperview];
            [cell.contentView addSubview:submitBtn];
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
        hireDateTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        hireDateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        hireDateTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:hireDateTxt];
        hireDateTxt.delegate = self;
        hireDateTxt.placeholder=@"Select Date";
        hireDateTxt.text=theDate;
            }else if(indexPath.row==1){
        nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        nameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        nameTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:nameTxt];
        nameTxt.delegate = self;
        nameTxt.placeholder=@"First and Last Name";
    }else if(indexPath.row==2){
        inviterTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        inviterTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        inviterTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:inviterTxt];
        inviterTxt.delegate = self;
        inviterTxt.placeholder=@"First and Last Name";
    }else if(indexPath.row==3){
        contactTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        contactTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        contactTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:contactTxt];
        [contactTxt setKeyboardType:UIKeyboardTypeNumberPad];
        contactTxt.delegate = self;
        contactTxt.placeholder=@"__-__-___";
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        contactTxt.inputAccessoryView = numberToolbar;
    }else if(indexPath.row==4){
        codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(130,5,180,55)];
        codeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
        codeTxt.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:codeTxt];
        codeTxt.delegate = self;
        codeTxt.placeholder=@"Code #";
    
    }else if(indexPath.row==5){
        complete_amaLbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
        [complete_amaLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        complete_amaLbl.text=@"COMPLETE AMA";
        [cell.contentView addSubview:complete_amaLbl];
        
        complete_amaBtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
        [complete_amaBtn setTag:0];
        [complete_amaBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [complete_amaBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [complete_amaBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [complete_amaBtn removeFromSuperview];
        [cell.contentView addSubview:complete_amaBtn];
        
        meet_spouseLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
        [meet_spouseLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        meet_spouseLbl.text=@"MEET SPOUSE";

        [cell.contentView addSubview:meet_spouseLbl];

        
        meet_spouseBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
        [meet_spouseBtn setTag:4];
        [meet_spouseBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [meet_spouseBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [meet_spouseBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [meet_spouseBtn removeFromSuperview];
       [cell.contentView addSubview:meet_spouseBtn];

    }else if(indexPath.row==6){
        
        submit_licLbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
        [submit_licLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        submit_licLbl.text=@"SUBMTI LIC";
        [cell.contentView addSubview:submit_licLbl];
        
        submit_licBtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
        [submit_licBtn setTag:1];
        [submit_licBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [submit_licBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [submit_licBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [submit_licBtn removeFromSuperview];
        [cell.contentView addSubview:submit_licBtn];
        
        prospect_listLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
        [prospect_listLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        prospect_listLbl.text=@"PROSPECT LIST";
        
        [cell.contentView addSubview:prospect_listLbl];
        
        
        prospect_listBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
        [prospect_listBtn setTag:5];
        [prospect_listBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [prospect_listBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [prospect_listBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [prospect_listBtn removeFromSuperview];
        [cell.contentView addSubview:prospect_listBtn];

        
    }else if(indexPath.row==7){
        fieldTraning = [[UITextField alloc] initWithFrame:CGRectMake(35,0,100,40)];
        fieldTraning.font=[UIFont fontWithName:@"Calibri" size:16.0];
        fieldTraning.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:fieldTraning];
        fieldTraning.delegate = self;
        fieldTraning.placeholder=@"Field Training";
        
        Three_3_30BLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
        [Three_3_30BLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        Three_3_30BLbl.text=@"3-3-30";
        
        [cell.contentView addSubview:Three_3_30BLbl];
        
        
        Three_3_30Btn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
        [Three_3_30Btn setTag:6];
        [Three_3_30Btn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [Three_3_30Btn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [Three_3_30Btn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [Three_3_30Btn removeFromSuperview];
        [cell.contentView addSubview:Three_3_30Btn];

        
    }else if(indexPath.row==8){
        FNALbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
        [FNALbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        FNALbl.text=@"FNA";
        [cell.contentView addSubview:FNALbl];
        
        FNABtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
        [FNABtn setTag:3];
        [FNABtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [FNABtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [FNABtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [FNABtn removeFromSuperview];
        [cell.contentView addSubview:FNABtn];
        
        Fast_schoolLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,100,60)];
        [Fast_schoolLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        Fast_schoolLbl.text=@"FAST START SCHOOL";
        Fast_schoolLbl.lineBreakMode = NSLineBreakByWordWrapping;
        Fast_schoolLbl.numberOfLines = 0;
        [cell.contentView addSubview:Fast_schoolLbl];
        
        
        Fast_schoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
        [Fast_schoolBtn setTag:7];
        [Fast_schoolBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [Fast_schoolBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
        [Fast_schoolBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [Fast_schoolBtn removeFromSuperview];
        [cell.contentView addSubview:Fast_schoolBtn];
        
      

    }else if(indexPath.row==9){
        followLbl = [[UILabel alloc] initWithFrame:CGRectMake(15,5,150,55)];
        [followLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
        followLbl.text=@"FOLLOW UP";
        [cell.contentView addSubview:followLbl];
        
        followUpTxtView= [[UITextField alloc] initWithFrame:CGRectMake(130,5,150,55)];
        followUpTxtView.font=[UIFont fontWithName:@"Calibri" size:16.0];
        followUpTxtView.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:followUpTxtView];
        followUpTxtView.delegate = self;
        followUpTxtView.placeholder=@"Follow Up";
    }else if(indexPath.row==10){
        submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
        [submitBtn setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [submitBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        [submitBtn removeFromSuperview];
        [cell.contentView addSubview:submitBtn];
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
            hireDateTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            hireDateTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            hireDateTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:hireDateTxt];
            hireDateTxt.delegate = self;
            hireDateTxt.placeholder=@"Select Date";
            hireDateTxt.text=theDate;

        }else if(indexPath.row==1){
            nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            nameTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            nameTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:nameTxt];
            nameTxt.delegate = self;
            nameTxt.placeholder=@"First and Last Name";
        }else if(indexPath.row==2){
            inviterTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            inviterTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            inviterTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:inviterTxt];
            inviterTxt.delegate = self;
            inviterTxt.placeholder=@"First and Last Name";
        }else if(indexPath.row==3){
            contactTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            contactTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            contactTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:contactTxt];
            [contactTxt setKeyboardType:UIKeyboardTypeNumberPad];
            contactTxt.delegate = self;
            contactTxt.placeholder=@"__-__-___";
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            contactTxt.inputAccessoryView = numberToolbar;
        }else if(indexPath.row==4){
            codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            codeTxt.font=[UIFont fontWithName:@"Calibri" size:16.0];
            codeTxt.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:codeTxt];
            codeTxt.delegate = self;
            codeTxt.placeholder=@"Code #";
            
        }else if(indexPath.row==5){
            complete_amaLbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
            [complete_amaLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            complete_amaLbl.text=@"COMPLETE AMA";
            [cell.contentView addSubview:complete_amaLbl];
            
            complete_amaBtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
            [complete_amaBtn setTag:0];
            [complete_amaBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [complete_amaBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [complete_amaBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [complete_amaBtn removeFromSuperview];
            [cell.contentView addSubview:complete_amaBtn];
            
            meet_spouseLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
            [meet_spouseLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            meet_spouseLbl.text=@"MEET SPOUSE";
            
            [cell.contentView addSubview:meet_spouseLbl];
            
            
            meet_spouseBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [meet_spouseBtn setTag:4];
            [meet_spouseBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [meet_spouseBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [meet_spouseBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [meet_spouseBtn removeFromSuperview];
            [cell.contentView addSubview:meet_spouseBtn];
            
        }else if(indexPath.row==6){
            
            submit_licLbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
            [submit_licLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            submit_licLbl.text=@"SUBMTI LIC";
            [cell.contentView addSubview:submit_licLbl];
            
            submit_licBtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
            [submit_licBtn setTag:1];
            [submit_licBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [submit_licBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [submit_licBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [submit_licBtn removeFromSuperview];
            [cell.contentView addSubview:submit_licBtn];
            
            prospect_listLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
            [prospect_listLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            prospect_listLbl.text=@"PROSPECT LIST";
            
            [cell.contentView addSubview:prospect_listLbl];
            
            
            prospect_listBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [prospect_listBtn setTag:5];
            [prospect_listBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [prospect_listBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [prospect_listBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [prospect_listBtn removeFromSuperview];
            [cell.contentView addSubview:prospect_listBtn];
            
            
        }else if(indexPath.row==7){
            fieldTraning = [[UITextField alloc] initWithFrame:CGRectMake(25,5,140,60)];
            fieldTraning.font=[UIFont fontWithName:@"Calibri" size:16.0];
            fieldTraning.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:fieldTraning];
            fieldTraning.delegate = self;
            fieldTraning.placeholder=@"Field Training";
            
            Three_3_30BLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,150,60)];
            [Three_3_30BLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            Three_3_30BLbl.text=@"3-3-30";
            
            [cell.contentView addSubview:Three_3_30BLbl];
            
            
            Three_3_30Btn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [Three_3_30Btn setTag:6];
            [Three_3_30Btn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [Three_3_30Btn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [Three_3_30Btn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [Three_3_30Btn removeFromSuperview];
            [cell.contentView addSubview:Three_3_30Btn];
            
            
        }else if(indexPath.row==8){
            FNALbl = [[UILabel alloc] initWithFrame:CGRectMake(50,0,150,60)];
            [FNALbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            FNALbl.text=@"FNA";
            [cell.contentView addSubview:FNALbl];
            
            FNABtn= [[UIButton alloc] initWithFrame:CGRectMake(25,20,20,20)];
            [FNABtn setTag:3];
            [FNABtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [FNABtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [FNABtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [FNABtn removeFromSuperview];
            [cell.contentView addSubview:FNABtn];
            
            Fast_schoolLbl = [[UILabel alloc] initWithFrame:CGRectMake(205,0,100,60)];
            [Fast_schoolLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            Fast_schoolLbl.text=@"FAST START SCHOOL";
            Fast_schoolLbl.lineBreakMode = NSLineBreakByWordWrapping;
            Fast_schoolLbl.numberOfLines = 0;
            [cell.contentView addSubview:Fast_schoolLbl];
            
            
            Fast_schoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(180,20,20,20)];
            [Fast_schoolBtn setTag:7];
            [Fast_schoolBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [Fast_schoolBtn setBackgroundImage:[UIImage imageNamed:@"OnbxCheck.png"] forState:UIControlStateSelected];
            [Fast_schoolBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [Fast_schoolBtn removeFromSuperview];
            [cell.contentView addSubview:Fast_schoolBtn];
            
        }else if(indexPath.row==9){
            followLbl = [[UILabel alloc] initWithFrame:CGRectMake(15,5,150,55)];
            [followLbl setFont:[UIFont fontWithName:@"Calibri-Bold" size:16.0]];
            followLbl.text=@"FOLLOW UP";
            [cell.contentView addSubview:followLbl];
            
            followUpTxtView= [[UITextField alloc] initWithFrame:CGRectMake(150,5,200,55)];
            followUpTxtView.font=[UIFont fontWithName:@"Calibri" size:16.0];
            followUpTxtView.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:followUpTxtView];
            followUpTxtView.delegate = self;
            followUpTxtView.placeholder=@"Follow Up";
        }else if(indexPath.row==10){
            submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,60)];
            [submitBtn setTitle:@"SUBMIT" forState:UIControlStateNormal];
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"proBtn.png"] forState:UIControlStateNormal];
            [submitBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
            [submitBtn removeFromSuperview];
            [cell.contentView addSubview:submitBtn];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
