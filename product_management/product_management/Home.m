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
#import "ProductList.h"
#import "HomeView.h"
#import "APIClientIOS.h"
#import "EditProduct.h"
#import "User.h"

@interface Home ()
{
    APIClientIOS * apiClient;
    NSInteger pageNumberHome, pageNumberPopular, pageNumberActivities;
        BOOL pagingScroll;
    NSArray * arrItems;
    NSMutableArray * products;
    UIImageView * imgView;
    UILabel * lbtxt;
NSArray * segmentedViewControllers;
    
}

@end

@implementation Home
@synthesize segementControl;
@synthesize tabBar;
@synthesize tabLogout;
@synthesize tabUser;
@synthesize scViewHome;

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
    [self addScrollView];
}

-(void)addScrollView{
   
    apiClient = [APIClientIOS sharedClient];
    [apiClient GET:@"products.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
        NSLog(@"respone Product List %@", responseObject);

         NSDictionary * objproduct = [[responseObject objectForKey:@"products"] valueForKey:@"Product"];
          NSLog(@"Product List %@", objproduct);
         NSArray * txtName = [objproduct valueForKey:@"name"];
         NSLog(@"HI image: %@",txtName);
         NSArray * images = [objproduct valueForKey:@"image"];
         NSLog(@"HI image: %@",images);
         int i;
         int y=80;
         
         for (i= 0; i<[images count]; i++) {
             
             // get URL of Image View
             NSString * imgPath = [NSString stringWithFormat:@"http://localhost:8888/productApi/product/%@",[images objectAtIndex:i]];
             NSURL* imgURL = [NSURL URLWithString:imgPath];
             NSData* data = [[NSData alloc] initWithContentsOfURL:imgURL];
//             if ([data isEqualToData:nil]) {
//                 NSLog(@"No image");
//             }else
//             {
//                 NSLog(@"Have Image");
//             }
             
             imgView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
             [imgView setFrame:CGRectMake(5,y,100, 80)];
             y += imgView.frame.size.height+10;
             
             // for text View
             lbtxt = [[UILabel alloc] initWithFrame:CGRectMake(5, y, 300, 25)];
             lbtxt.text = [txtName objectAtIndex:i];
             lbtxt.textColor = [UIColor redColor];
             
             [scViewHome addSubview:lbtxt];
             [scViewHome addSubview:imgView];
              y += lbtxt.frame.size.height+10;
         }
         scViewHome.contentSize = CGSizeMake(imgView.frame.size.width, y);
         scViewHome.delegate = self;
         
//         NSString * imgPath = [NSString stringWithFormat:@"http://localhost:8888/productApi/product/%@",[images objectAtIndex:0]];
//         
//         NSURL* imgURL = [NSURL URLWithString:imgPath];
//         NSData* data = [[NSData alloc] initWithContentsOfURL:imgURL];
//         //imgView.image = [UIImage imageWithData:data];
//         
//         lbtxt = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, 50, 50)];
//         lbtxt.text = [txtName objectAtIndex:0];
//         lbtxt.textColor = [UIColor redColor];
//         
//         
//         imgView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
//         [imgView setFrame:CGRectMake(10, 20, 50, 50)];
//         //scViewHome.accessibilityActivationPoint = CGPointMake(100, 100);
//         scViewHome= [[UIScrollView alloc]initWithFrame:CGRectMake(20, 100, 220, 340)];
//         //imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dell1.jpg"]];
//         scViewHome.minimumZoomScale = 0.5;
//         scViewHome.maximumZoomScale = 3;
//         scViewHome.contentSize = CGSizeMake(imgView.frame.size.width,imgView.frame.size.height+(lbtxt.frame.size.height));
//         
//         scViewHome.delegate = self;
//         [scViewHome addSubview:lbtxt];
//         [scViewHome addSubview:imgView];
//         [self.view addSubview:scViewHome];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error Message: %@", error);
     }];
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imgView;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"Did end decelerating");
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    NSLog(@"Did end dragging");
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"Did begin decelerating");
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"Did begin dragging");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"offset y=%f", (scrollView.contentOffset.y+scrollView.frame.size.height));
//    NSLog(@"content size height=%f", scrollView.contentSize.height);
//    
//    float scrollViewContentHeight = scrollView.contentSize.height;
//    float scrollViewOriginY = scrollView.contentOffset.y;
//    
//    if (scrollViewContentHeight <= ((scrollViewOriginY+scrollView.frame.size.height)+50) && !pagingScroll)
//    {
//        switch (self.segementControl.selectedSegmentIndex)
//        {
//            case 0: // load next page of home data
//                pagingScroll = TRUE;
//                pageNumberHome = pageNumberHome + 1;
//                [self currently];
//                break;
//            case 1: // load next page of popular data
//                pagingScroll = TRUE;
//                pageNumberPopular += 1;
//                [self list];
//                break;
//            case 2: // load next page of activity data
//                [self addNewProduct];
//                break;
//            default:
//                NSLog(@"default segement");
//                break;
//        }
//    }
//}

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

- (void)currently  //for Home Product implement
{
    NSLog(@"HI Home Page");
    [self addScrollView];
    
}

- (void)list //for list Product page implement
{

    NSLog(@"HI list Page");
    ProductList * objlist = [[ProductList alloc] init];
    [self.navigationController pushViewController:objlist animated:YES];
    
}

- (void)addNewProduct  // for add new Product page implement
{
    
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
       
        UserProfile * objUserPro = [[UserProfile alloc] init];
        [self.navigationController pushViewController:objUserPro animated:YES];
        
    }
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    
}


@end
