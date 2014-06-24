//
//  Home.h
//  product_management
//
//  Created by Ty Votey on 6/17/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIViewController

@property (nonatomic,retain) NSString * userId;

- (IBAction)segementedControl:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segementControl;
@end
