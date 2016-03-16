//
//  BpmDateViewController.m
//  Chatapp
//
//  Created by arvind on 9/28/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "BpmDateViewController.h"
#import "BPMDateVO.h"
@interface BpmDateViewController ()

@end

@implementation BpmDateViewController
@synthesize activityIndicator,appDelegate,searchBar,bpmFieldTableView,alert;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    
    // Do any additional setup after loading the view from its nib.
    self.bpmFieldTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bpmFieldTableView.bounds.size.width, 0.01f)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"BPM"];
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
    filteredContentList=appDelegate.bpmDateArray;

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
    for (int i=0; i<appDelegate.bpmDateArray.count; i++) {
        BPMDateVO *bVO=[appDelegate.bpmDateArray objectAtIndex:i];
if ([bVO.bpmLocation rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)        {
            [filteredContentList addObject:bVO];
        }
    }
    [bpmFieldTableView reloadData];
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
        filteredContentList=appDelegate.bpmDateArray;
        // tblContentList.hidden=YES;
    }
    [bpmFieldTableView reloadData];
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
    if(searchBar.text  !=nil) {
        isSearching = YES;
        [self searchTableList];
    }else {
        isSearching = NO;
        filteredContentList=[[NSMutableArray alloc]init];
        filteredContentList=appDelegate.bpmDateArray;
        // tblContentList.hidden=YES;
    }
    [bpmFieldTableView reloadData];
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
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
        BPMDateVO *bvo=[filteredContentList objectAtIndex:indexPath.row];
        
        UILabel *userTextView=[[UILabel alloc]initWithFrame:CGRectMake(30,10, 250,30)];
        [userTextView setText:bvo.bpmLocation];
        
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
        BPMDateVO *bvo=[filteredContentList objectAtIndex:indexPath.row];
        appDelegate.bpmLocationStr=[[NSString alloc]init];
              appDelegate.bpmuseridStr=bvo.bpm_id;
        appDelegate.bpmLocationStr=bvo.bpmLocation;
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
