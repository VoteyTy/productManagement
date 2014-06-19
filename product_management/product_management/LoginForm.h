//
//  LoginForm.h
//  product_management
//
//  Created by Ty Votey on 6/17/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginForm : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPwd;


- (IBAction)btnLogin:(id)sender;
- (IBAction)btnForgetpwd:(id)sender;

@end
