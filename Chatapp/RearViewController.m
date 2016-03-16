//
//  RearViewController.m
//  Chatapp
//
//  Created by arvind on 7/13/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "RearViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "ProfileViewController.h"
#import "NewRecruitViewController.h"
#import "NewGuestViewController.h"
#import "AddBusinessViewController.h"
#import "MatchUpViewController.h"
#import "OfficeLocatorViewController.h"
#import "UserListViewController.h"
#import "MainViewController.h"
#import "LocationViewController.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "MatchupBookViewController.h"
@interface RearViewController ()

@end

@implementation RearViewController
@synthesize rearTableView = _rearTableView;
@synthesize appDelegate,usernameLabel,selectedMenuItem,titleLabel,imageLogo;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.rearTableView.separatorColor = [UIColor clearColor];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [imageLogo loadImageFromURL:[NSURL URLWithString:[prefs objectForKey:@"profileImage"]]];
    [imageLogo setBackgroundColor:[UIColor clearColor]];
   
    self.view.backgroundColor=[UIColor colorWithHexString:@"000000"];
    self.rearTableView.backgroundColor=[UIColor colorWithHexString:@"000000"];
    self.rearTableView.alwaysBounceVertical = NO;
    self.navigationController.navigationBarHidden=YES;
    usernameLabel.text=[prefs objectForKey:@"username"];
    UIFont *customFont = [UIFont fontWithName:@"OpenSans-Light" size:16];
    usernameLabel.font = customFont;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor=[UIColor whiteColor];
    
    
    UIImageView *menuItemImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5,5,35,35)];
    
    UILabel *pictureLbl=[[UILabel alloc]initWithFrame:CGRectMake(15,10,35,35)];
    pictureLbl.text = @"";
    pictureLbl.textColor=[UIColor whiteColor];
    UILabel *menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 5, 250, 45)];
    menuItemTextLabel.font = [UIFont boldSystemFontOfSize:18];
    menuItemTextLabel.textColor=[UIColor colorWithHexString:@"fefeff"];
    
    UIFont *customFont = [UIFont fontWithName:@"OpenSans-Light" size:16];
    menuItemTextLabel.font = customFont;
    
    cell.backgroundColor=[UIColor clearColor];
    
    if (row == 6)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf0e6";
        //menuItemImageView.image=[UIImage imageNamed:@"chaticons.png"];
        menuItemTextLabel.text = @"\tCHAT";
        [menuItemTextLabel.layer setCornerRadius:10];
        if([selectedMenuItem isEqualToString:@"     CHAT"]){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecellselected.png"]];
        }
    }
    if (row == 3)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf0b0";
        menuItemTextLabel.text = @"\tADD NEW RECRUIT";
        [menuItemTextLabel.layer setCornerRadius:10];
        if([selectedMenuItem isEqualToString:@"     ADD NEW RECRUIT"]){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecellselected.png"]];
        }
    }
    else if (row == 4)
    {
        
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf007";
        menuItemTextLabel.text = @"\tADD BUSINESS";
        [menuItemTextLabel.layer setCornerRadius:10];
        if([selectedMenuItem isEqualToString:@"     ADD BUSINESS"]){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecellselected.png"]];
        }
        
    }
    else if (row == 2)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf13d";
        menuItemTextLabel.text = @"\tADD NEW GUEST";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    else if (row == 1)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf02d";
        menuItemTextLabel.text = @"\tSUBMIT MATCH UP";
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 7)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf011";
        menuItemTextLabel.text = @"\tLOGOUT";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    /*else if (row == 12)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf011";
        menuItemTextLabel.text = @"\tMATCH UP BOOK";
        [menuItemTextLabel.layer setCornerRadius:10];
    }*/
    else if (row == 5)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf022";
        menuItemTextLabel.text = @"\tBPM Check-In";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    else if (row == 0)
    {
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf0e4";
        menuItemTextLabel.text = @"\tDASHBOARD";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    [menuItemTextLabel.layer setMasksToBounds:YES];
    [cell.contentView addSubview:menuItemImageView];
    [cell.contentView addSubview:menuItemTextLabel];
    [cell.contentView addSubview:pictureLbl];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We know the frontViewController is a NavigationController
    NSInteger row = indexPath.row;
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=(int)row;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
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
