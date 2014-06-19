//
//  RegisterForm.m
//  product_management
//
//  Created by Apple on 6/17/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "RegisterForm.h"

@interface RegisterForm ()

@end

@implementation RegisterForm
NSString *txtAddfirstName;
NSString *txtAddLastName;
NSString *txtAddAddress;
NSString *txtAddEmail;
NSString *txtAddPassword;
NSString *txtAddConPassword;
NSString *resultStringDate;
NSDateFormatter *dateFormatter;
NSDate *currentTime;
bool moved;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//
//    
//    [textField resignFirstResponder];
//    
//    return NO;
//}
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

- (IBAction)btnRegister:(id)sender {
    txtAddfirstName = self.txtFirstName.text;
    txtAddLastName = self.txtLastName.text;
    txtAddAddress = self.txtAddress.text;
    txtAddEmail = self.txtEmail.text;
    txtAddPassword = self.txtPassword.text;
    txtAddConPassword = self.txtConPassword.text;
    currentTime = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    resultStringDate = [dateFormatter stringFromDate: currentTime];
    NSLog(@"Result date %@",resultStringDate);
    
    /******** User is Model Name, firstname is field name ********/
    if([txtAddPassword isEqualToString:txtAddConPassword]){
        NSDictionary *addData = @{@"User[firstname]":txtAddfirstName,@"User[lastname]":txtAddLastName,@"User[email]":txtAddEmail,
                              @"User[address]":txtAddAddress,@"User[password]":txtAddPassword,@"User[datecreated]":resultStringDate
                              };
        APIClientIOS *client = [APIClientIOS sharedClient];
        [client.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];//apikey for security that we put it in AppController of cakephp
        
        [client POST:@"users.json" parameters:addData success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Respone Object %@", responseObject);
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error Message: %@", error);
        }];
        
    }

}

@end
