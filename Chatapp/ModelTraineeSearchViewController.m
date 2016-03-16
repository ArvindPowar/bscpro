//
//  ModelTraineeSearchViewController.m
//  Chatapp
//
//  Created by arvind on 9/12/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "ModelTraineeSearchViewController.h"
#import "BusinessVO.h"
@interface ModelTraineeSearchViewController ()

@end

@implementation ModelTraineeSearchViewController
@synthesize traineeFieldTableView,userListArray,groupListArray,activityIndicator,appDelegate,searchBar,searchBarController,alert,plusBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    // Do any additional setup after loading the view from its nib.
    self.traineeFieldTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.traineeFieldTableView.bounds.size.width, 0.01f)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Trainee"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    //self.navigationItem.title=@"Users";
    
    //searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0,200, 40)];
    searchBar.showsCancelButton = YES;
    [searchBar setDelegate:self];
    //[self.view addSubview:searchBar];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation.png"]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden=NO;
    
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    filteredContentList=[[NSMutableArray alloc]init];
    filteredContentList=appDelegate.traineeListArray;
    if ([appDelegate.checkstr isEqualToString:@"CEO"] || [appDelegate.checkstr isEqualToString:@"SMD"]) {
        plusBtn.hidden=YES;
    }
    
    plusBtn.frame=CGRectMake(self.view.bounds.size.width-150, 20, 40, 40);
    plusBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30];
    [plusBtn setTitle:@"\uf067" forState:UIControlStateNormal];
    [plusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(Newmessage) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *barBtnRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    //[barBtnRight setTintColor:[UIColor whiteColor]];
    //[self.view addSubview:plusBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)cancelAction{
    if(self.presentingViewController)
        [self dismissViewControllerAnimated:NO completion:NULL];
    else
        [self.navigationController popViewControllerAnimated:YES];

}
- (void)searchTableList {
    NSString *searchString = searchBar.text;
    filteredContentList=[[NSMutableArray alloc]init];
    for (int i=0; i<appDelegate.traineeListArray.count; i++) {
        BusinessVO *bVO=[appDelegate.traineeListArray objectAtIndex:i];
        NSComparisonResult result;
        if([bVO.fname  length] >= [searchString length]){
         result = [bVO.fname compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        }
        if (result == NSOrderedSame)
        {
            [filteredContentList addObject:bVO];
        }
    }
    [traineeFieldTableView reloadData];
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length != 0){
        isSearching = YES;
        [self searchTableList];
        
    }else {
        isSearching = NO;
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=appDelegate.traineeListArray;
        // tblContentList.hidden=YES;
    }
    [traineeFieldTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    NSLog(@"Cancel clicked");
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar {
    NSLog(@"Search Clicked");
    [self.searchBar resignFirstResponder];
    if(searchBar.text  !=nil) {
        isSearching = YES;
        [self searchTableList];
    }else {
        isSearching = NO;
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=appDelegate.traineeListArray;
        // tblContentList.hidden=YES;
    }
    [traineeFieldTableView reloadData];
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
-(IBAction)Newmessage{
    
       alert=[[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Enter trainee name is here..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter trainee name"];
    
    [alert show];
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        appDelegate.traineeId=[[NSString alloc]init];
    appDelegate.tranieeStr=[[NSString alloc]init];
    appDelegate.smdTraineeStr=@"Yes";
        appDelegate.traineeId=[alert textFieldAtIndex:0].text;
        [alert dismissWithClickedButtonIndex:1 animated:YES];
    
    if ([appDelegate.checkstr isEqualToString:@"CEO"]) {
        appDelegate.checkstr=[[NSString alloc]init];

        appDelegate.ceoFirstlastname=[[NSString alloc]init];
        appDelegate.ceoFirstlastname=[alert textFieldAtIndex:0].text;;
        
    }else if([appDelegate.checkstr isEqualToString:@"SMD"]) {
        appDelegate.checkstr=[[NSString alloc]init];
        appDelegate.smdfirstlastname=[[NSString alloc]init];
        appDelegate.smdfirstlastname=[alert textFieldAtIndex:0].text;;
        
    }
    if(self.presentingViewController)
        [self dismissViewControllerAnimated:NO completion:NULL];
    else
        [self.navigationController popViewControllerAnimated:YES];
  }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [filteredContentList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    NSString *firstlastname=[[NSString alloc]init];
    if(indexPath.row < [filteredContentList count]){
        BusinessVO *bvo=[filteredContentList objectAtIndex:indexPath.row];
        
        UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(30,10, 250,30)];
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        if ([appDelegate.checkstr isEqualToString:@"CEO"] || [appDelegate.checkstr isEqualToString:@"SMD"]) {

            str = [NSString stringWithFormat:@"%@ %@", firstString, secondString];

        }else{
            str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];

        }
        [userTextView setText:str];
       
        userTextView.font=[UIFont fontWithName:@"Calibri" size:16.0];
        [userTextView setTextColor:[UIColor blackColor]];
        [cell.contentView addSubview:userTextView];
            
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [filteredContentList count]){
        BusinessVO *bvo=[filteredContentList objectAtIndex:indexPath.row];
        appDelegate.tranieeStr=[[NSString alloc]init];
        appDelegate.traineeId=[[NSString alloc]init];
       
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        NSString *userid=[[NSString alloc]init];
        if ([appDelegate.checkstr isEqualToString:@"CEO"]) {
            appDelegate.checkstr=[[NSString alloc]init];
            appDelegate.ceouserid=[[NSString alloc]init];
             appDelegate.ceoFirstlastname=[[NSString alloc]init];
            appDelegate.ceoFirstlastname=[NSString stringWithFormat:@"%@ %@", firstString, secondString];
            appDelegate.ceouserid=bvo.user_id;

        }else if([appDelegate.checkstr isEqualToString:@"SMD"]) {
            appDelegate.checkstr=[[NSString alloc]init];
            appDelegate.smdfirstlastname=[[NSString alloc]init];
            appDelegate.smduserid=[[NSString alloc]init];
            appDelegate.smdfirstlastname=[NSString stringWithFormat:@"%@ %@", firstString, secondString];
            appDelegate.smduserid=bvo.user_id;
        }
        userid=bvo.user_id;
        appDelegate.traineeId=userid;
        appDelegate.tranieeStr=str;
       appDelegate.smdTraineeStr=@"Yes";
    if(self.presentingViewController)
        [self dismissViewControllerAnimated:NO completion:NULL];
    else
        [self.navigationController popViewControllerAnimated:YES];
    }
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
