//
//  AddBusAgentSearchViewController.m
//  Chatapp
//
//  Created by arvind on 9/29/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "AddBusAgentSearchViewController.h"
#import "BusinessVO.h"
@interface AddBusAgentSearchViewController ()

@end

@implementation AddBusAgentSearchViewController
@synthesize traineeFieldTableView,userListArray,groupListArray,activityIndicator,appDelegate,searchBar,searchBarController,alert,plusBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
    self.traineeFieldTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.traineeFieldTableView.bounds.size.width, 0.01f)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"Select Agent"];
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
    filteredContentList=[[NSMutableArray alloc]init];
    filteredContentList=appDelegate.agentTempArray;
    
    plusBtn.frame=CGRectMake(self.view.bounds.size.width-150, 20, 40, 40);
    plusBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30];
    [plusBtn setTitle:@"\uf067" forState:UIControlStateNormal];
    [plusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(addAgent) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *barBtnRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    //[barBtnRight setTintColor:[UIColor whiteColor]];

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
    
}- (void)searchTableList {
    NSString *searchString = searchBar.text;
    filteredContentList=[[NSMutableArray alloc]init];
    for (int i=0; i<appDelegate.agentTempArray.count; i++) {
        BusinessVO *bVO=[appDelegate.agentTempArray objectAtIndex:i];
       if ([[NSString stringWithFormat:@"%@ %@",bVO.fname,bVO.lname] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)
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
        filteredContentList=appDelegate.agentTempArray;
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
        filteredContentList=appDelegate.agentTempArray;
        // tblContentList.hidden=YES;
    }
    [traineeFieldTableView reloadData];
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}

-(IBAction)addAgent{
    alert=[[UIAlertView alloc]initWithTitle:@"BSCPRO" message:@"Enter agent name here..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter trainee name"];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *agentStr=[[NSString alloc]init];
    agentStr=[alert textFieldAtIndex:0].text;
    if (![agentStr isEqualToString:@""]) {
        [appDelegate.agentIdArry addObject:agentStr];
        [appDelegate.agentSelectArray addObject:agentStr];
        if(self.presentingViewController)
            [self dismissViewControllerAnimated:NO completion:NULL];
        else
            [self.navigationController popViewControllerAnimated:YES];
    }
    [alert dismissWithClickedButtonIndex:1 animated:YES];
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
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
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
        NSString *str=[[NSString alloc]init];
        NSString *firstString =bvo.fname;
        NSString *secondString = bvo.lname;
        NSString *threestr=bvo.agentcode;
        str = [NSString stringWithFormat:@"%@ %@ %@", firstString, secondString, threestr];
        appDelegate.useridagent=[[NSString alloc]init];
        appDelegate.useridagent=bvo.user_id;
        [appDelegate.agentSelectArray addObject:str];
        [appDelegate.agentIdArry addObject:appDelegate.useridagent];
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
