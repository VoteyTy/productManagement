//
//  UserProfile.h
//  product_management
//
//  Created by Ty Votey on 6/20/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfile : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;


- (IBAction)btnSave:(id)sender;

@property (nonatomic,retain) NSString * userId;

@end
