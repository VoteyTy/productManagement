//
//  RegisterForm.m
//  product_management
//
//  Created by SOEUNG Channy on 6/17/14.


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
    
    const int movementDistance = -70; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    viewToMove.frame = CGRectOffset(viewToMove.frame, 0, movement);
    [UIView commitAnimations];
}
-(BOOL) isValidEmail:(NSString *)checkString
{
    checkString = [checkString lowercaseString];
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)btnRegister:(id)sender {
    txtAddfirstName = [self.txtFirstName.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    txtAddLastName = [self.txtLastName.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    txtAddAddress = [self.txtAddress.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];
    txtAddEmail = [self.txtEmail.text stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceCharacterSet]];
    txtAddPassword = [self.txtPassword.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    txtAddConPassword = [self.txtConPassword.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    currentTime = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    resultStringDate = [dateFormatter stringFromDate: currentTime];
    NSLog(@"Result date %@",resultStringDate);
    
    /******** User is Model Name, firstname is field name ********/
    if([txtAddfirstName isEqualToString:@""] || [txtAddLastName isEqualToString:@""] || [txtAddAddress isEqualToString:@""] || [txtAddEmail isEqualToString:@""] ||[txtAddPassword isEqualToString:@""] || [txtAddConPassword isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please insert data in the fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
    }else{
        if([txtAddPassword isEqualToString:txtAddConPassword] && [self isValidEmail:txtAddEmail]){
            NSDictionary *addData = @{@"User[firstname]":txtAddfirstName,@"User[lastname]":txtAddLastName,@"User[email]":txtAddEmail,
                                      @"User[address]":txtAddAddress,@"User[password]":txtAddPassword,@"User[datecreated]":resultStringDate
                                      };
            APIClientIOS *client = [APIClientIOS sharedClient];
            [client.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [client.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];//apikey for security that we put it in AppController of cakephp
            
            [client POST:@"users.json" parameters:addData success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"Respone Object %@", responseObject);
                LoginForm * objRegister = [[LoginForm alloc] initWithNibName:@"LoginForm" bundle:nil];
                    [self.navigationController pushViewController:objRegister animated:YES];

            }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"Error Message: %@", error);
             }];
        
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Password do not match or Invalid Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }

    }

}

@end
