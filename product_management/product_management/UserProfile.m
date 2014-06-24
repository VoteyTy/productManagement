//
//  UserProfile.m
//  product_management
//
//  Created by Ty Votey on 6/20/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "UserProfile.h"
#import "APIClientIOS.h"
#import "User.h"
#import "Home.h"

@interface UserProfile () {

    NSString *txtAddfirstName;
    NSString *txtAddLastName;
    NSString *txtAddAddress;
    NSString *txtAddEmail;
    NSString *txtAddPassword;
    NSString *txtAddConPassword;
    NSString *resultStringDate;
    NSDateFormatter *dateFormatter;
    NSDate *currentTime;
}

@end

@implementation UserProfile
NSDictionary * userReciver;

@synthesize txtFirstName;
@synthesize txtLastName;
@synthesize txtEmail;
@synthesize txtAddress;
@synthesize txtPassword;


bool moved;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"User Profile";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    User * objMain = [[User alloc] init];
    NSDictionary * userReciver = [objMain readSession];
    NSDictionary * userData = [[userReciver objectForKey:@"users"] objectForKey:@"User"];
    
    txtFirstName.text = [userData valueForKey:@"firstname"];
    txtLastName.text = [userData valueForKey:@"lastname"];
    txtEmail.text = [userData valueForKey:@"email"];
    txtAddress.text = [userData valueForKey:@"address"];
    txtPassword.text = [userData valueForKey:@"password"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if(!moved) {
        [self animateViewToPosition:self.view directionUP:YES];
        moved = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(moved) {
        [self animateViewToPosition:self.view directionUP:NO];
    }
    moved = NO;
    return YES;
}


-(void)animateViewToPosition:(UIView *)viewToMove directionUP:(BOOL)up {
    
    const int movementDistance = -80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    viewToMove.frame = CGRectOffset(viewToMove.frame, 0, movement);
    [UIView commitAnimations];
}


- (IBAction)btnSave:(id)sender {
    
    User * objMain = [[User alloc] init];
    NSDictionary * userReciver = [objMain readSession];
    NSDictionary * userData = [[userReciver objectForKey:@"users"] objectForKey:@"User"];
    NSString * userId = [userData valueForKey:@"id"];
    NSLog(@" HI reciver User: %@",userId);
   
//    txtFirstName.text = [userData valueForKey:@"firstname"];
//    txtLastName.text = [userData valueForKey:@"lastname"];
//    txtEmail.text = [userData valueForKey:@"email"];
//    txtAddress.text = [userData valueForKey:@"address"];
//    txtPassword.text = [userData valueForKey:@"password"];
    
    txtAddfirstName = txtFirstName.text;
    txtAddLastName = txtLastName.text;
    txtAddAddress = txtAddress.text;
    txtAddEmail = txtEmail.text;
    txtAddPassword = txtPassword.text;
    currentTime = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    resultStringDate = [dateFormatter stringFromDate: currentTime];
    NSLog(@"Result date %@",resultStringDate);

    if (userId) {
        NSDictionary * param = @{@"User[firstname]":txtAddfirstName,@"User[lastname]":txtAddLastName,@"User[email]":txtAddEmail,
                                 @"User[address]":txtAddAddress,@"User[password]":txtAddPassword,@"User[datecreated]":resultStringDate
                                 };
        APIClientIOS *client = [APIClientIOS sharedClient];
        [client.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];//apikey for security that we put it in AppController of cakephp
        
        [client PUT:[NSString stringWithFormat:@"users/%@.json", userId] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Respone Object %@", responseObject);
            
            Home * objhome = [[Home alloc] init];
            [self.navigationController pushViewController:objhome animated:YES];
            
        }
            failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error Message: %@", error);
            }];
    }
    

}
@end
