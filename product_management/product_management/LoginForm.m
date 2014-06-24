//
//  LoginForm.m
//  product_management
//
//  Created by Ty Votey on 6/17/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "LoginForm.h"
#import "Home.h"
#import "ForgetPassword.h"
#import "APIClientIOS.h"
#import "AddNewProduct.h"
#import "RegisterForm.h"
#import "User.h"


@interface LoginForm (){
    APIClientIOS * apiclient;
    NSString * userNameText, *passWordText;

}

@end

@implementation LoginForm

@synthesize txtEmail;
@synthesize txtPwd;

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

    
    apiclient = [[APIClientIOS alloc] init];
    apiclient = [APIClientIOS sharedClient];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnLogin:(id)sender {
    
    NSString * userEmail = txtEmail.text;  // get value from text field
    NSString * userPwd = txtPwd.text;
    if ([userEmail isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Please Enter your email!", @"") message:NSLocalizedString(@"EX: abc@gmail.com", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles: nil, nil];
        [alert show];
    }
    else   if ([userPwd isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Please Enter your Password!", @"") message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles: nil, nil];
        [alert show];
    }
    else
    {
        [apiclient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [apiclient.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];
        
        NSDictionary * params = @{@"email": userEmail, @"password":userPwd};  // get data from text field
        
        [apiclient POST:@"users/login.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"HI DB: %@",responseObject); // users/loging.json is add parram to compare with api userscontroller login function 
            
            NSDictionary * objUser =[[NSDictionary alloc] initWithDictionary:[responseObject objectForKey:@"users"]];
            NSLog(@"Hi objUser:%@",objUser);
            NSString * userStatus = [objUser objectForKey:@"status"];
            if ([userStatus isEqualToString:@"error"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login faile!", @"") message:NSLocalizedString(@"The Email and Password doesn't match", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles: nil, nil];
                [alert show];
            }
            else
            {
                NSLog(@"successful");
                Home * objHome = [[Home alloc] init];
                //objHome.userId = self.
                [self.navigationController pushViewController:objHome animated:YES];
//                NSData * conData = [NSKeyedArchiver archivedDataWithRootObject:objUser];
//                NSLog(@"HI Condata: %@",conData);
            }
            
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:responseObject forKey:@"UserLoginIdSession"];
//            //    [defaults setObject:userNameText forKey:@"username"];
//            //    [defaults setObject:passWordText forKey:@"password"];
//            
//            NSLog(@" Defaults %@",[defaults objectForKey:@"UserLoginIdSession"]);
//            [defaults synchronize];
             User * objMain = [[User alloc] init];
            [objMain saveSession:responseObject];
//            NSDictionary * reciver = [objMain readSession];
//            NSLog(@" HI reciver: %@",reciver);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Errors");
        }];
    }
}

- (IBAction)btnForgetpwd:(id)sender {
    
    ForgetPassword * objForgetPwd = [[ForgetPassword alloc] init];
    [self.navigationController pushViewController:objForgetPwd animated:YES];
}

- (IBAction)btnRegister:(id)sender {
    RegisterForm * objRegister = [[RegisterForm alloc] initWithNibName:@"RegisterForm" bundle:nil];
    //AddNewProduct* objRegister = [[AddNewProduct alloc] initWithNibName:@"AddNewProduct" bundle:nil];
    
    [self.navigationController pushViewController:objRegister animated:YES];
}
@end
