//
//  LocationViewController.m
//  Chatapp
//
//  Created by arvind on 8/25/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "LocationViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
@interface LocationViewController ()
@property(nonatomic) double longitudeLabelS;
@property(nonatomic) double latitudeLabelS;
@end

@implementation LocationViewController{
    CLLocationManager *locationManager;
}
@synthesize longitudeLabel,latitudeLabel,longitudeLabelS,latitudeLabelS,appDelegate,activityIndicator,loginBtn,officeId,checkinBtn,sItemNameDecora;
- (void)viewDidLoad {
    [super viewDidLoad];
    loginBtn.hidden = YES;
    checkinBtn.hidden = YES;
    
    NSUserDefaults *prefsCheck = [NSUserDefaults standardUserDefaults];
    NSString *chin=[[NSString alloc]init];
    chin=[prefsCheck objectForKey:@"checkIn"];
    
        if ([chin isEqualToString:@"You have checked in to the pune BPM"] || [chin isEqualToString:@"You already checked in this office location."] || [chin isEqualToString:@"No Office Found"]) {
            loginBtn.hidden=YES;
            if ([chin isEqualToString:@"You already checked in this office location."]) {
                checkinBtn.userInteractionEnabled = YES;
                checkinBtn = [[UIButton alloc]init];
                //[checkinBtn addTarget:self action:@selector(postData)forControlEvents:UIControlEventTouchUpInside];
                checkinBtn.frame = CGRectMake(20,200,280,80);
                [checkinBtn setBackgroundColor:[UIColor grayColor]];
                checkinBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                checkinBtn.titleLabel.numberOfLines = 0;
                [checkinBtn setTitle:chin forState:UIControlStateNormal];
                [checkinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                checkinBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
                [self.view addSubview:checkinBtn];

            }else{
            checkinBtn = [[UIButton alloc]init];
            [checkinBtn addTarget:self action:@selector(postData)forControlEvents:UIControlEventTouchUpInside];
            checkinBtn.frame = CGRectMake(20,200,280,80);
            [checkinBtn setBackgroundImage: [UIImage imageNamed:@"btnBg.png"] forState:UIControlStateNormal];
            checkinBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            checkinBtn.titleLabel.numberOfLines = 0;
            [checkinBtn setTitle:chin forState:UIControlStateNormal];
            [checkinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            checkinBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
            [self.view addSubview:checkinBtn];
            }
        }else{
            locationManager = [[CLLocationManager alloc] init];
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
                NSUInteger code = [CLLocationManager authorizationStatus];
                if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                    // choose one request according to your business.
                    if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                        [locationManager requestAlwaysAuthorization];
                    } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                        [locationManager  requestWhenInUseAuthorization];
                    } else {
                        NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                    }
                }
            }
            [locationManager startUpdatingLocation];
            

        }
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"LOCATION"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    
    // Do any additional setup after loading the view from its nib.
}
-(void)GetData{
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
        appDelegate.newuserListArray=[[NSMutableArray alloc] init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&latitude=%@&longitude=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],latitudeLabel,longitudeLabel]];
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/office_api/findnearoffice"];
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
                
                if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] == nil) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Oops, we encountered an error or the site may be down for maintenance.  Please try again in a few minutes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else{

                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                
                officeId = [[NSString alloc]init];
                    officeId = [userDict objectForKey:@"officeId"];
                    
                NSString *userArray = [[NSString alloc]init];
                userArray = [userDict objectForKey:@"BPMoffice"];
                
                    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:userArray];
                    UIFont *font = [UIFont systemFontOfSize:14];
                    [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
                if([userArray isEqualToString:@"No Office Found Near You."] )
                {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No Office Found Near You.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else if([userArray isEqualToString:@"There are no BPMs right now."]){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"There are no BPMs right now.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else{
                    loginBtn = [[UIButton alloc]init];
                    [loginBtn addTarget:self action:@selector(postData)forControlEvents:UIControlEventTouchUpInside];
                    loginBtn.frame = CGRectMake(30,200,260,[self textViewHeightForAttributedText:[[NSAttributedString alloc] initWithString :userArray] andWidth:self.view.bounds.size.width-100]+100);
                    [loginBtn setBackgroundImage: [UIImage imageNamed:@"btnBg.png"] forState:UIControlStateNormal];
                    [loginBtn setTitle:userArray forState:UIControlStateNormal];
                    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    loginBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
                    [self.view addSubview:loginBtn];
                    
        
                }

                
            }
            }
            [activityIndicator stopAnimating];
        }];
    }
    [activityIndicator stopAnimating];
    
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
-(void)postData{
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
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            NSUserDefaults *prefspassword = [NSUserDefaults standardUserDefaults];
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&sec_user=%@&sec_pass=%@&office_id=%@",[prefs objectForKey:@"loggedin"],[prefsusername objectForKey:@"username"],[prefspassword objectForKey:@"password"],officeId]];
            NSString *urlString = [[NSString alloc]initWithFormat:@"https://bscpro.com/office_api/addbpmoffice"];
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
                        NSString *userArray = [[NSString alloc]init];
                        userArray = [userDict objectForKey:@"CheckBPMoffice "];
                        NSString* sItemNameDecorated = [userArray stringByReplacingOccurrencesOfString:@" " withString:@"_"];
                        sItemNameDecora = [sItemNameDecorated stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:userArray];
                        UIFont *font = [UIFont systemFontOfSize:14];
                        [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
                        if([sItemNameDecora isEqualToString:@"You_have_checked_in_to_the_pune_BPM"])
                        {
                            loginBtn.hidden=YES;
                            checkinBtn = [[UIButton alloc]init];
                            //[checkinBtn addTarget:self action:@selector(postData)forControlEvents:UIControlEventTouchUpInside];
                            checkinBtn.userInteractionEnabled = YES;
                            [checkinBtn setBackgroundColor:[UIColor grayColor]];
                            checkinBtn.frame = CGRectMake(20,200,280,[self textViewHeightForAttributedText:[[NSAttributedString alloc] initWithString :userArray] andWidth:self.view.bounds.size.width-100]+100);
                            [checkinBtn setBackgroundImage: [UIImage imageNamed:@"btnBg.png"] forState:UIControlStateNormal];
                            checkinBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                            checkinBtn.titleLabel.numberOfLines = 0;
                            [checkinBtn setTitle:userArray forState:UIControlStateNormal];
                            [checkinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            checkinBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
                            [self.view addSubview:checkinBtn];

                        }else if ([sItemNameDecora isEqualToString:@"You_already_checked_in_this_office_location."]){
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"You already checked in this office location.!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            

                            [alert show];
                            loginBtn.hidden=YES;
                            checkinBtn = [[UIButton alloc]init];
                            //[checkinBtn addTarget:self action:@selector(postData)forControlEvents:UIControlEventTouchUpInside];
                            checkinBtn.userInteractionEnabled = YES;
                            [checkinBtn setBackgroundColor:[UIColor grayColor]];
                            checkinBtn.frame = CGRectMake(20,200,280,[self textViewHeightForAttributedText:[[NSAttributedString alloc] initWithString :userArray] andWidth:self.view.bounds.size.width-100]+100);
                            [checkinBtn setBackgroundImage: [UIImage imageNamed:@"btnBg.png"] forState:UIControlStateNormal];
                            checkinBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                            checkinBtn.titleLabel.numberOfLines = 0;
                            [checkinBtn setTitle:userArray forState:UIControlStateNormal];
                            [checkinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            checkinBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
                            [self.view addSubview:checkinBtn];
                        }else if ([sItemNameDecora isEqualToString:@"No_Office_Found"]){
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"No Office Found!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                            [alert show];

                        }
                        NSUserDefaults *prefsCheck = [NSUserDefaults standardUserDefaults];
                        [prefsCheck setObject:userArray forKey:@"checkIn"];
                        [prefsCheck synchronize];
                        [activityIndicator stopAnimating];
                    }
                    
                }
            }];
            
        [activityIndicator stopAnimating];
    }
}
- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}
/*- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation=[locations lastObject];
    latitudeLabelS=newLocation.coordinate.latitude;
    longitudeLabelS=newLocation.coordinate.longitude;
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:latitudeLabelS longitude:longitudeLabelS] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *locality = [placemark name];
            NSLog(@"locality %@",locality);
            if([placemark locality]!=nil)
                appDelegate.currentlocation=[NSString stringWithFormat:@"%@",[placemark country]];
            else
                appDelegate.currentlocation=[NSString stringWithFormat:@"%@",[placemark country]];
            
            
            NSLog(@"appDelegate.currentlocation = %@",appDelegate.currentlocation);
            [locationManager stopUpdatingLocation];
        }
    }];
}
*/
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    [locationManager stopUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitudeLabel= [NSString stringWithFormat:@"%.2f", currentLocation.coordinate.longitude];
        latitudeLabel= [NSString stringWithFormat:@"%.2f", currentLocation.coordinate.latitude];
        [locationManager stopUpdatingLocation];

        [self GetData];
    }
    [locationManager stopUpdatingLocation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
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
