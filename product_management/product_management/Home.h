//
//  Home.h
//  product_management
//
//  Created by Ty Votey on 6/17/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIViewController<UITabBarDelegate,UIScrollViewDelegate>

@property (nonatomic,retain) NSString * userId;

- (IBAction)segementedControl:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segementControl;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;

@property (strong, nonatomic) IBOutlet UITabBarItem *tabLogout;
@property (strong, nonatomic) IBOutlet UITabBarItem *tabUser;
@property (strong, nonatomic) IBOutlet UIView *vhome;

@property (strong, nonatomic) IBOutlet UIScrollView *scViewHome;


@end
