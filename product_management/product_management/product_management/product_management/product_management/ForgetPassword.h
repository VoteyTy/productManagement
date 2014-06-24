//
//  ForgetPassword.h
//  product_management
//
//  Created by Ty Votey on 6/19/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassword : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)btnResetpwd:(id)sender;

@end
