//
//  Home.m
//  product_management
//
//  Created by Ty Votey on 6/17/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "Home.h"
#import "AddNewProduct.h"
#import "UserProfile.h"
#import "LoginForm.h"

@interface Home ()
{
      NSInteger pageNumberHome, pageNumberPopular, pageNumberActivities;
        BOOL pagingScroll;
}

@end

@implementation Home
@synthesize segementControl;
@synthesize tabBar;
@synthesize tabLogout;
@synthesize tabUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"HOME";
        [self.navigationItem setHidesBackButton:YES animated:YES];  // hide Button back from Home page 
        self.tabBarItem = [[UITabBarItem alloc] init]; // TabBarItem
        //self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Logout" image:nil tag:0] ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segementedControl:(id)sender {
    if (segementControl.selectedSegmentIndex == 0) {
        //self.view.backgroundColor = [UIColor greenColor];
        [self currently];
    }else if (segementControl.selectedSegmentIndex == 1){
        //self.view.backgroundColor = [UIColor yellowColor];
        [self list];
    
    }else if (segementControl.selectedSegmentIndex == 2){
        [self addNewProduct];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"offset y=%f", (scrollView.contentOffset.y+scrollView.frame.size.height));
    NSLog(@"content size height=%f", scrollView.contentSize.height);
    
    float scrollViewContentHeight = scrollView.contentSize.height;
    float scrollViewOriginY = scrollView.contentOffset.y;
    
    if (scrollViewContentHeight <= ((scrollViewOriginY+scrollView.frame.size.height)+50) && !pagingScroll)
    {
        switch (self.segementControl.selectedSegmentIndex)
        {
            case 0: // load next page of home data
                pagingScroll = TRUE;
                pageNumberHome = pageNumberHome + 1;
                [self currently];
                break;
            case 1: // load next page of popular data
                pagingScroll = TRUE;
                pageNumberPopular += 1;
                [self list];
                break;
            case 2: // load next page of activity data
                [self addNewProduct];
                break;
            default:
                NSLog(@"default segement");
                break;
        }
    }
}
- (void)currently  //for Home Product implement
{
    NSLog(@"HI Home Page");
    
    
}

- (void)list //for list Product page implement
{

    NSLog(@"HI list Page");
}

- (void)addNewProduct  // for add new Product page implement
{
    // Link to AddNewProduct page ;
    
    AddNewProduct * objadd = [[AddNewProduct alloc]init];
    [self.navigationController pushViewController:objadd animated:YES];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        NSLog(@"Hi logout TabBar!");
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//        alert.title = @"Logout";
//        [alert show];
        
         LoginForm * objlogout = [[LoginForm alloc] init];
        objlogout.hidesBottomBarWhenPushed = YES;
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:objlogout animated:YES];
        
    }else if (item.tag == 1){
       NSLog(@"HI tabbar 2");
        UserProfile * objUserPro = [[UserProfile alloc] init];
        [self.navigationController pushViewController:objUserPro animated:YES];
    }
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    
}

@end
