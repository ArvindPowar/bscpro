//
//  OfficeLocatorViewController.m
//  Chatapp
//
//  Created by arvind on 7/16/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "OfficeLocatorViewController.h"
#import "SWRevealViewController.h"

@interface OfficeLocatorViewController ()

@end

@implementation OfficeLocatorViewController
@synthesize officeLbl,firstLbl,searchBtn,searchBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(50, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:@"OFFICE LOCATOR"];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font =[UIFont systemFontOfSize:18];
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
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(height>=480 && height<568){
        officeLbl.layer.frame=CGRectMake(10,10,150,30);
        [officeLbl removeFromSuperview];
        [self.view addSubview:officeLbl];
        
        firstLbl.layer.frame=CGRectMake(20,45,250,30);
        [firstLbl removeFromSuperview];
        [self.view addSubview:firstLbl];
        
        
         }else if(height>=568 && height<600){
             officeLbl.layer.frame=CGRectMake(10,10,150,30);
             [officeLbl removeFromSuperview];
             [self.view addSubview:officeLbl];
             
             firstLbl.layer.frame=CGRectMake(20,45,250,30);
             [firstLbl removeFromSuperview];
             [self.view addSubview:firstLbl];
             
             

         }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
