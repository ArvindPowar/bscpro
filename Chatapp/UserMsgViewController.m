
//
//  UserMsgViewController.m
//  Chatapp
//
//  Created by mansoor shaikh on 13/02/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "UserMsgViewController.h"
#import "AsyncImageView.h"
#import "MsgChatVO.h"
#import "LoginVO.h"
#import "GroupChatVO.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MessageUI/MessageUI.h>
#import "Reachability.h"
#import "UserListViewController.h"
#import "SWNinePatchImageFactory.h"
#import "MainViewController.h"
#define kOFFSET_FOR_KEYBOARD 80.0
#define k_KEYBOARD_OFFSET 80.0

@interface UserMsgViewController ()
{
   
    IBOutlet UIView *textInputView;
    IBOutlet UITextField *textField;
    NSMutableArray *bubbleData;
}
@end

@implementation UserMsgViewController
@synthesize  msgText,submitBtn,MessageChatArray,SelectedIDGroup,selectIDUser,activityIndicator,SelectedName,bubbleData,userlistTableView,userlist,profileimage,appDelegate,msgChat,attachmentBtn,demoView,alertView1,image_,radiobutton1,radiobutton2,radiobutton3,selectMsgId,response,imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBarHidden=NO;
         
    // Keyboard events
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.MessageChatArray=[[NSMutableArray alloc] init];
    appDelegate.GroupChatArray=[[NSMutableArray alloc] init];
    self.userlistTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.userlistTableView.bounds.size.width, 0.01f)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:SelectedName];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;

    //self.navigationItem.title=SelectedName;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation.png"]];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [anotherButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    self.navigationController.navigationBarHidden=NO;
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];*/
    
    userlistTableView.layer.cornerRadius=5;
    
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
    if(height>=480 && height<568){
        //iphone 4
        
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height-60);
        [userlistTableView removeFromSuperview];
        [self.view addSubview:userlistTableView];
        
        msgText.layer.frame=CGRectMake(45,370,200,40);
        msgText.delegate=self;
        [msgText removeFromSuperview];
        [self.view addSubview:msgText];
        
        submitBtn.layer.frame=CGRectMake(250,370,60,40);
        [submitBtn removeFromSuperview];
        [self.view addSubview:submitBtn];
        
        attachmentBtn.layer.frame=CGRectMake(10,375,20,20);
        [attachmentBtn removeFromSuperview];
        [self.view addSubview:attachmentBtn];
        
    }else if(height>=568 && height<600){
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-60);
        [userlistTableView removeFromSuperview];
        [self.view addSubview:userlistTableView];
        msgText.delegate=self;
        msgText.layer.frame=CGRectMake(45,447,200,40);
        [msgText removeFromSuperview];
        [self.view addSubview:msgText];
        
        submitBtn.layer.frame=CGRectMake(250,449,60,40);
        [submitBtn removeFromSuperview];
        [self.view addSubview:submitBtn];
        
        attachmentBtn.layer.frame=CGRectMake(10,458,20,20);
        [attachmentBtn removeFromSuperview];
        [self.view addSubview:attachmentBtn];

    }else{
        userlistTableView.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-60);
        [userlistTableView removeFromSuperview];
        [self.view addSubview:userlistTableView];
        
        msgText.delegate=self;
        msgText.layer.frame=CGRectMake(60,550,240,40);
        [msgText removeFromSuperview];
        [self.view addSubview:msgText];
        
        submitBtn.layer.frame=CGRectMake(310,550,60,40);
        [submitBtn removeFromSuperview];
        [self.view addSubview:submitBtn];
        
        attachmentBtn.layer.frame=CGRectMake(15,560,20,20);
        [attachmentBtn removeFromSuperview];
        [self.view addSubview:attachmentBtn];
    }
    }
   }

#pragma mark - Actions

- (IBAction)sayPressed:(id)sender
{
    if(image_ != nil)
{
    [self uploadImage];
}else{
    if (![msgText.text isEqualToString:@""]) {
        [self PostMessage:@""];
    }
    
}
    msgText.text = @"";
    [msgText resignFirstResponder];
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
-(void)viewDidAppear:(BOOL)animated{
    if (image_ ==nil) {
        [userlistTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        if([SelectedIDGroup isEqualToString:@""]){
            [self getMessgaeChat];
        }else{
            [self getGroupChat];
        }
    }else{
        if([SelectedIDGroup isEqualToString:@""]){
            [self getMessgaeChat];
        }else{
            [self getGroupChat];
        }
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
    [alertView1 setDelegate:(id)self];
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
    
    NSString *urlString = @"http://pfh.com.my/pgfh/upload/chat_attachment.php";
    NSLog(@"urlstring is %@",urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //image filename
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",filename]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"return string %@",returnString);
    //[self clearAllData];
    [activityIndicator stopAnimating];
    
    
   [self PostMessage:returnString];
    return true;
}

-(void)uploadImage{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *serverString=[[NSString alloc] initWithFormat:@"%@",[prefs objectForKey:@"loggedin"]];
    [self uploadImage:UIImageJPEGRepresentation(image_, 1.0) filename:serverString];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
        [controller setDelegate:(id)self];
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popover setDelegate:(id)self];
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
        
        picker.delegate = (id)self;
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
        
        image_ = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //[editBtnPicture setBackgroundImage:image forState:UIControlStateNormal];
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    //[self performSelector:@selector(pushView) withObject:nil afterDelay:0.2];
}

-(void)getMessgaeChat{
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
    appDelegate.MessageChatArray=[[NSMutableArray alloc] init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&receiver_id=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],selectIDUser]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chat_api/chatConversation/"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
            [self getMessgaeChat];
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            
            NSError *error;
            if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else{

            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSString *userArray = [[NSString alloc]init];
            userArray = [userDict objectForKey:@"message"];
        
           NSString* sItemNameDecora = [userArray stringByReplacingOccurrencesOfString:@"\n" withString:@""];
          if(![sItemNameDecora isEqualToString:@"No messages"])
            {
            NSArray *userArray = [userDict objectForKey:@"chatlist"];

    for (int count=0; count<[userArray count]; count++) {
        NSDictionary *activityData=[userArray objectAtIndex:count];
        MsgChatVO *mcvo=[[MsgChatVO alloc] init];
        mcvo.message_id=[[NSString alloc] init];
        appDelegate.msgchatVO.message_id=[[NSString alloc]init];
        mcvo.user_id=[[NSString alloc] init];
        mcvo.username=[[NSString alloc] init];
        mcvo.receiver_id=[[NSString alloc] init];
        mcvo.receiver=[[NSString alloc] init];
        mcvo.message_time=[[NSString alloc] init];
        mcvo.message=[[NSString alloc] init];
        mcvo.subject=[[NSString alloc] init];
        mcvo.fav_message=[[NSString alloc] init];
        mcvo.attach_image=[[NSString alloc] init];
        mcvo.attach_file=[[NSString alloc] init];
        mcvo.matchup_id=[[NSString alloc] init];
        mcvo.req_response=[[NSString alloc] init];

        if ([activityData objectForKey:@"username"] != [NSNull null])
        mcvo.message_id=[activityData objectForKey:@"message_id"];
        appDelegate.msgchatVO.message_id=[activityData objectForKey:@"message_id"];
        mcvo.user_id=[activityData objectForKey:@"user_id"];
        mcvo.username=[activityData objectForKey:@"username"];
        mcvo.receiver_id=[activityData objectForKey:@"receiver_id"];
        mcvo.receiver=[activityData objectForKey:@"receiver"];
        mcvo.message_time=[activityData objectForKey:@"message_time"];
        mcvo.message=[activityData objectForKey:@"message"];
        mcvo.subject=[activityData objectForKey:@"subject"];
        mcvo.fav_message=[activityData objectForKey:@"fav_message"];
        mcvo.attach_image=[activityData objectForKey:@"attach_image"];
        mcvo.attach_file=[activityData objectForKey:@"attach_file"];
        mcvo.matchup_id=[activityData objectForKey:@"matchup_id"];
        mcvo.req_response=[activityData objectForKey:@"req_response"];
        [appDelegate.MessageChatArray addObject:mcvo];
    }
            }

    [userlistTableView reloadData];
    [activityIndicator stopAnimating];
 }
        }
    }];
    }
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

-(void)getGroupChat{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
   appDelegate.MessageChatArray=[[NSMutableArray alloc] init];
    NSURL *url;
    NSMutableString *httpBodyString;
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@&groupId=%@",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],SelectedIDGroup]];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chat_api/groupMessages/"];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // your data or an error will be ready here
        if (error)
        {
            NSLog(@"Failed to submit request");
            [self getGroupChat];
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
            
            NSArray *userArray = [userDict objectForKey:@"groupchatlist"];
            for (int count=0; count<[userArray count]; count++) {
        NSDictionary *activityData=[userArray objectAtIndex:count];
        GroupChatVO *gcvo=[[GroupChatVO alloc] init];
        gcvo.groupid=[[NSString alloc] init];
        gcvo.message_id=[[NSString alloc] init];
        gcvo.user_id=[[NSString alloc] init];
        gcvo.username=[[NSString alloc] init];
        gcvo.receiver_id=[[NSString alloc] init];
        gcvo.receiver=[[NSString alloc] init];
        gcvo.message_time=[[NSString alloc] init];
        gcvo.message=[[NSString alloc] init];
        gcvo.subject=[[NSString alloc] init];
        gcvo.attach_image=[[NSString alloc] init];
        gcvo.attach_file=[[NSString alloc] init];
        gcvo.matchup_id=[[NSString alloc] init];

        if ([activityData objectForKey:@"username"] != [NSNull null])
            gcvo.groupid=[activityData objectForKey:@"groupid"];
        gcvo.message_id=[activityData objectForKey:@"message_id"];
        gcvo.user_id=[activityData objectForKey:@"user_id"];
        gcvo.username=[activityData objectForKey:@"username"];
        gcvo.receiver_id=[activityData objectForKey:@"receiver_id"];
        gcvo.receiver=[activityData objectForKey:@"receiver"];
        gcvo.message_time=[activityData objectForKey:@"message_time"];
        gcvo.message=[activityData objectForKey:@"message"];
         gcvo.subject=[activityData objectForKey:@"subject"];
        gcvo.attach_image=[activityData objectForKey:@"attach_image"];
        gcvo.attach_file=[activityData objectForKey:@"attach_file"];
        
        [appDelegate.MessageChatArray addObject:gcvo];
    }
    [userlistTableView reloadData];
    [activityIndicator stopAnimating];
            }
        }
    }];
    }
}

-(void)PostMessage:(NSString *)imageURL{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];

            if(![selectIDUser isEqualToString:@""]){
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            NSURL *url;
            NSMutableString *httpBodyString;
            
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&receiverid=%@&subject=test&messages=%@&attachment=%@&sec_user=%@&sec_pass=%@",[prefs objectForKey:@"loggedin"],selectIDUser,msgText.text,imageURL,[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
            NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chat_api/postusermessage/"];
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
                        [self getMessgaeChat];
                        [activityIndicator stopAnimating];
                }
                }
                [activityIndicator stopAnimating];
            }];
            [activityIndicator stopAnimating];
    }else if(![SelectedIDGroup isEqualToString:@""]){
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"groupId=%@&user_id=%@&subject=test&messages=%@&attachment=%@&sec_user=%@&sec_pass=%@",SelectedIDGroup,[prefs objectForKey:@"loggedin"],msgText.text,imageURL,[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"]]];
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chat_api/postusermessage/"];
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
                }else{
                    [self getGroupChat];
                    [activityIndicator stopAnimating];
            }
            }
        }];
        [activityIndicator stopAnimating];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BSCPRO"
                                                        message:@"Please check your internet connection."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    image_=nil;
    }
    [activityIndicator stopAnimating];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.MessageChatArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MsgChatVO *mcvo=[appDelegate.MessageChatArray objectAtIndex:indexPath.row];
    NSString* htmlStr = mcvo.message;
    NSString* strWithoutFormatting = [self stripTags:htmlStr];
    NSString* newString = [strWithoutFormatting stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:newString];
    UIFont *font = [UIFont systemFontOfSize:14];
    [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(![mcvo.attach_image isEqualToString:@""] ){
        return [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+140;
    }
        if ([mcvo.matchup_id isEqualToString:@""] || mcvo.matchup_id==nil){
            return [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+50;
        }else if(![mcvo.matchup_id isEqualToString:@""]){
            return [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+120;
        }
    else{
            return [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+50;
        }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (![appDelegate.MessageChatArray count]==0) {
        
    
        MsgChatVO *mcvo=[appDelegate.MessageChatArray objectAtIndex:indexPath.row];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString* htmlStr = mcvo.message;
    int value = 0;
        NSString* strWithoutFormatting = [self stripTags:htmlStr];
        NSString* newString = [strWithoutFormatting stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        NSLog(@"%@    &   %@",[prefs objectForKey:@"loggedin"],mcvo.user_id);
        if([[[prefs objectForKey:@"loggedin"] stringByReplacingOccurrencesOfString:@" " withString:@""]isEqualToString:mcvo.user_id]){
            if (![mcvo.message isEqualToString:@""]) {
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:newString];
            UIFont *font = [UIFont systemFontOfSize:14];
            [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
            AsyncImageView *userimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60, 5, 50, 50)];
            userimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
            [userimage loadImageFromURL:[NSURL URLWithString:[prefs objectForKey:@"profileImage"]]];
                [userimage.layer setCornerRadius:20.0];
                [userimage.layer setMasksToBounds:YES];
            [cell.contentView addSubview:userimage];
            
            UILabel *cmtTextView=[[UILabel alloc] initWithFrame:CGRectMake(20, 2, self.view.bounds.size.width-90, [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20)];
                value=[self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20;
            cmtTextView.backgroundColor=[UIColor clearColor];
            cell.backgroundColor=[UIColor clearColor];
            cmtTextView.lineBreakMode = NSLineBreakByWordWrapping;
            cmtTextView.numberOfLines = 0;
            cmtTextView.text=newString;
            cmtTextView.textColor=[UIColor whiteColor];
            cmtTextView.textAlignment=UITextAlignmentCenter;
                
                UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"minenew.9"];
                UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(10,2,cmtTextView.frame.size.width+17, cmtTextView.frame.size.height+10)];
                [imagView setImage:resizableImage];
                [cell.contentView addSubview:imagView];
            [cell.contentView addSubview:cmtTextView];
            }
            if (![mcvo.attach_image isEqualToString:@""]) {
                AsyncImageView *userimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60, 5, 50, 50)];
                
                [userimage loadImageFromURL:[NSURL URLWithString:[prefs objectForKey:@"profileImage"]]];
                [userimage.layer setCornerRadius:20.0];
                [userimage.layer setMasksToBounds:YES];
                [cell.contentView addSubview:userimage];
                userimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
                
                AsyncImageView *postimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(140, value+10, 100, 100)];
                [postimage loadImageFromURL:[NSURL URLWithString:mcvo.attach_image]];
                [postimage setBackgroundColor:[UIColor clearColor]];
                [cell.contentView addSubview:postimage];
            }
        }else{
             if (![mcvo.message isEqualToString:@""]) {
                  if ([mcvo.matchup_id isEqualToString:@""] || mcvo.matchup_id==nil) {
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:newString];
            UIFont *font = [UIFont systemFontOfSize:14];
            [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
            AsyncImageView *userimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(2,7, 50, 50)];
            userimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
            [userimage loadImageFromURL:[NSURL URLWithString:profileimage]];
            [userimage.layer setCornerRadius:20.0];
            [userimage.layer setMasksToBounds:YES];
            [cell.contentView addSubview:userimage];
            
            UILabel *cmtTextView=[[UILabel alloc] init];
            cmtTextView.text=newString;
            cmtTextView.textAlignment=UITextAlignmentCenter;
            cmtTextView.backgroundColor=[UIColor clearColor];
            cell.backgroundColor=[UIColor clearColor];
            cmtTextView.lineBreakMode = NSLineBreakByWordWrapping;
            cmtTextView.numberOfLines = 0;
            
            int values;
            values=[self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20;
            if (values>=100) {
                cmtTextView.layer.frame=CGRectMake(78,7, self.view.bounds.size.width-80, [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20);
                UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"someoneelsess.9"];
                UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(52,2,cmtTextView.frame.size.width+40, cmtTextView.frame.size.height+25)];
                [imagView setImage:resizableImage];
                [cell.contentView addSubview:imagView];
                [cell.contentView addSubview:cmtTextView];
            }else{
                cmtTextView.layer.frame=CGRectMake(68, 2, self.view.bounds.size.width-80, [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20);

            UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"someoneelsess.9"];
            UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(55,2,cmtTextView.frame.size.width+20, cmtTextView.frame.size.height+10)];
                [imagView setImage:resizableImage];
                [cell.contentView addSubview:imagView];
                [cell.contentView addSubview:cmtTextView];
            }
                  }
                else {
                    if ([mcvo.req_response isEqualToString:@"TRAINEE_MSG"]) {
                        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:newString];
                        UIFont *font = [UIFont systemFontOfSize:14];
                        [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
                        AsyncImageView *userimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(2,7, 50, 50)];
                        userimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
                        [userimage loadImageFromURL:[NSURL URLWithString:profileimage]];
                        [userimage.layer setCornerRadius:20.0];
                        [userimage.layer setMasksToBounds:YES];
                        [cell.contentView addSubview:userimage];
                        
                        UILabel *cmtTextView=[[UILabel alloc] init];
                        cmtTextView.text=newString;
                        cmtTextView.textAlignment=UITextAlignmentCenter;
                        cmtTextView.backgroundColor=[UIColor clearColor];
                        cell.backgroundColor=[UIColor clearColor];
                        cmtTextView.lineBreakMode = NSLineBreakByWordWrapping;
                        cmtTextView.numberOfLines = 0;
                        
                        int values;
                        values=[self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20;
                        if (values>=100) {
                            cmtTextView.layer.frame=CGRectMake(78,7, self.view.bounds.size.width-80, [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20);
                            UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"someoneelsess.9"];
                            UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(52,2,cmtTextView.frame.size.width+40, cmtTextView.frame.size.height+25)];
                            [imagView setImage:resizableImage];
                            [cell.contentView addSubview:imagView];
                            [cell.contentView addSubview:cmtTextView];
                        }else{
                            cmtTextView.layer.frame=CGRectMake(68, 2, self.view.bounds.size.width-80, [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20);
                            
                            UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"someoneelsess.9"];
                            UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(55,2,cmtTextView.frame.size.width+20, cmtTextView.frame.size.height+10)];
                            [imagView setImage:resizableImage];
                            [cell.contentView addSubview:imagView];
                            [cell.contentView addSubview:cmtTextView];
                        }
                    }else{

                     NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:newString];
                     UIFont *font = [UIFont systemFontOfSize:14];
                     [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
                     
                     UILabel *cmtTextView=[[UILabel alloc] initWithFrame:CGRectMake(10, 2, self.view.bounds.size.width-40, [self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+80)];
                     cmtTextView.backgroundColor=[UIColor clearColor];
                     cell.backgroundColor=[UIColor clearColor];
                     cmtTextView.lineBreakMode = NSLineBreakByWordWrapping;
                     cmtTextView.numberOfLines = 0;
                     cmtTextView.text=newString;
                     cmtTextView.textAlignment=UITextAlignmentCenter;
                     cmtTextView.textColor=[UIColor whiteColor];
                     UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"minenew.9"];
                     UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(10,2,cmtTextView.frame.size.width+20, cmtTextView.frame.size.height+10)];
                     [imagView setImage:resizableImage];
                     [cell.contentView addSubview:imagView];
                     [cell.contentView addSubview:cmtTextView];
                     
                     value=[self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+80;
                     radiobutton1 = [[UIButton alloc] initWithFrame:CGRectMake(80,value-35, 30,30)];
                     [radiobutton1 setTag:1000+[mcvo.message_id intValue]];
                     
                     radiobutton2 = [[UIButton alloc] initWithFrame: CGRectMake(140,value-35, 30, 30)];
                     [radiobutton2 setTag:2000+[mcvo.message_id intValue]];
                     
                     radiobutton3 = [[UIButton alloc] initWithFrame:CGRectMake(220,value-35, 30, 30)];
                     [radiobutton3 setTag:3000+[mcvo.message_id intValue]];
                     
                     if ([mcvo.req_response isEqualToString:@"YES"]) {
                         [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateNormal];
                         [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         
                         [cell.contentView addSubview:radiobutton1];
                         [cell.contentView addSubview:radiobutton2];
                         [cell.contentView addSubview:radiobutton3];
                     }else if ([mcvo.req_response isEqualToString:@"NO"]){
                         [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateNormal];
                         [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         
                         [cell.contentView addSubview:radiobutton1];
                         [cell.contentView addSubview:radiobutton2];
                         [cell.contentView addSubview:radiobutton3];
                         
                     }else if ([mcvo.req_response isEqualToString:@"MAYBE"]){
                         [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateNormal];
                         [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:
                          UIControlStateNormal];
                         [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
                         [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
                         [cell.contentView addSubview:radiobutton1];
                         [cell.contentView addSubview:radiobutton2];
                         [cell.contentView addSubview:radiobutton3];
                         
                     }else{
                         [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
                         [cell.contentView addSubview:radiobutton1];
                         
                         [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
                      
                         [cell.contentView addSubview:radiobutton2];
                         
                         [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
                         [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
                        
                         [cell.contentView addSubview:radiobutton3];
                     }
                    [radiobutton1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
                    [radiobutton2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
                    [radiobutton3 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
                     UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(55,value-30,30,25)];
                     [userTextView setText:@"Yes"];
                     userTextView.textColor=[UIColor whiteColor];
                     userTextView.font=[UIFont fontWithName:@"Calibri" size:16.0];
                     [cell.contentView addSubview:userTextView];
                     
                     UILabel *userTextViews=[[UILabel alloc]initWithFrame:CGRectMake(115,value-30,30,25)];
                     [userTextViews setText:@"No"];
                     userTextViews.textColor=[UIColor whiteColor];
                     userTextViews.font=[UIFont fontWithName:@"Calibri" size:16.0];
                     [cell.contentView addSubview:userTextViews];
                     
                     UILabel *userTextViewss=[[UILabel alloc]initWithFrame:CGRectMake(175,value-30,50,25)];
                     [userTextViewss setText:@"Maybe"];
                     userTextViewss.textColor=[UIColor whiteColor];
                     userTextViewss.font=[UIFont fontWithName:@"Calibri" size:16.0];
                     [cell.contentView addSubview:userTextViewss];
                 }
                }
             }
            if (![mcvo.attach_image isEqualToString:@""]) {
                NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:newString];
                UIFont *font = [UIFont systemFontOfSize:14];
                [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
                value=[self textViewHeightForAttributedText:title andWidth:self.view.bounds.size.width-80]+20;
                AsyncImageView *userimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(2, 7, 50, 50)];
                userimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chatusericon.png"]];
                [userimage loadImageFromURL:[NSURL URLWithString:profileimage]];
                [userimage.layer setCornerRadius:20.0];
                [userimage.layer setMasksToBounds:YES];
                [cell.contentView addSubview:userimage];
                
                AsyncImageView *postimage=[[AsyncImageView alloc] initWithFrame:CGRectMake(60,value+13,100, 100)];
                [postimage loadImageFromURL:[NSURL URLWithString:mcvo.attach_image]];
                [postimage setBackgroundColor:[UIColor clearColor]];
                [cell.contentView addSubview:postimage];
            }
    }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [appDelegate.MessageChatArray count]){
    MsgChatVO *mcvo=[appDelegate.MessageChatArray objectAtIndex:indexPath.row];
    selectMsgId=mcvo.message_id;
}
}
-(void)deleteMessage: (int) row{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
    }else{
        
        MsgChatVO *msgchat=[appDelegate.MessageChatArray objectAtIndex:row];
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/chatuser/deleteMessage/?msg_id=%@",msgchat.message_id];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        
        [self getMessgaeChat];
        [activityIndicator stopAnimating];

    }
    [activityIndicator stopAnimating];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteMessage:indexPath.row];
    }
}

-(void)radiobuttonSelected:(id)sender{
    UIButton *button=(UIButton*)sender;
    int messageid=0;
    for(int count=0; count<appDelegate.MessageChatArray.count;count++){
         MsgChatVO *msgchat=[appDelegate.MessageChatArray objectAtIndex:count];
        if ((button.tag-1000)==[msgchat.message_id intValue]) {
            response=@"YES";
            [self postResponse:[msgchat.message_id intValue]];
            break;
        }else  if ((button.tag-2000)==[msgchat.message_id intValue]) {
            response=@"NO";
            [self postResponse:[msgchat.message_id intValue]];
            break;
        }else  if ((button.tag-3000)==[msgchat.message_id intValue]) {
            response=@"MAYBE";
            [self postResponse:[msgchat.message_id intValue]];
            break;
        }
    }
 
}


-(void)postResponse:(int)messageid{
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
        NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"sec_user=%@&sec_pass=%@&user_response=%@&message_id=%d",[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],response,messageid]];
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://www.bscpro.com/chat_api/matchupReqReponse"];
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                NSLog(@"Failed to submit request");
                [self postResponse:messageid];
                [activityIndicator stopAnimating];
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSString *userArray = [[NSString alloc]init];
                userArray = [userDict objectForKey:@"status"];
                NSString *message = [[NSString alloc]init];
                message = [userDict objectForKey:@"message"];
                if([userArray isEqualToString:@"fail"])
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else if ([userArray isEqualToString:@"ok"]){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self getMessgaeChat];
                }
                NSError *error;
                [activityIndicator stopAnimating];
            }
        }];
    }
    //[activityIndicator stopAnimating];
}


- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}



#pragma mark - Keyboard events

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = textInputView.frame;
        frame.origin.y -= kbSize.height;
        textInputView.frame = frame;
        frame = userlistTableView.frame;
        frame.size.height -= kbSize.height;
        userlistTableView.frame = frame;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = textInputView.frame;
        frame.origin.y += kbSize.height;
        textInputView.frame = frame;
        frame = userlistTableView.frame;
        frame.size.height += kbSize.height;
        userlistTableView.frame = frame;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -233; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
