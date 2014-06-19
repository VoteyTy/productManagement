//
//  RegisterForm.h
//  product_management
//
//  Created by Apple on 6/17/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClientIOS.h"

@interface RegisterForm : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;

@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConPassword;
- (IBAction)btnRegister:(id)sender;
@end
