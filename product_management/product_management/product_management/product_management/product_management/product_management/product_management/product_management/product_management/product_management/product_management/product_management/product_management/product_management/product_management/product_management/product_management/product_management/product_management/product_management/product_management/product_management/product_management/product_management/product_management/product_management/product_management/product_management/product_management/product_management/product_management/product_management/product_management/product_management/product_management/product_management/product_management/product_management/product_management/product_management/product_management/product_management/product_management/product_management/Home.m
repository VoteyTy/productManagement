//
//  Home.m
//  product_management
//
//  Created by Ty Votey on 6/17/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "Home.h"

@interface Home ()

@end

@implementation Home
@synthesize segementControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"HOME";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segementedControl:(id)sender {
    if (segementControl.selectedSegmentIndex == 0) {
        self.view.backgroundColor = [UIColor greenColor];
    }else if (segementControl.selectedSegmentIndex == 1){
        self.view.backgroundColor = [UIColor yellowColor];
    
    }
    
}
@end
