//
//  ForgetPassword.m
//  product_management
//
//  Created by Ty Votey on 6/19/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "ForgetPassword.h"
#import "APIClientIOS.h"

@interface ForgetPassword ()
{
    APIClientIOS * apiclient;
}

@end

@implementation ForgetPassword

@synthesize txtEmail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Forget Password";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    apiclient = [[APIClientIOS alloc] init];
    apiclient = [APIClientIOS sharedClient];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnResetpwd:(id)sender {
    
    NSString * userEmail = txtEmail.text;
    if ([userEmail isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Please Enter your email!", @"") message:NSLocalizedString(@"EX: abc@gmail.com", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles: nil, nil];
        [alert show];
    }
    
    else
    {
        [apiclient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [apiclient.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];
        
        NSDictionary * params = @{@"email": userEmail};
        
        [apiclient POST:@"users/login.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"HI DB: %@",responseObject);
            
            NSDictionary * objUser =[[NSDictionary alloc] initWithDictionary:[responseObject objectForKey:@"users"]];
            NSLog(@"Hi objUser:%@",objUser);
            NSString * userStatus = [objUser objectForKey:@"status"];
            if ([userStatus isEqualToString:@"error"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Reset password Fail!", @"") message:NSLocalizedString(@"The Email incorrect", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles: nil, nil];
                [alert show];
            }
            else
            {
                NSLog(@"successful");
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Errors");
        }];
    }

}
@end
