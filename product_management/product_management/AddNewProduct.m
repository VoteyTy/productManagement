//
//  AddNewProduct.m
//  product_management
//
//  Created by Apple on 6/19/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "AddNewProduct.h"

@interface AddNewProduct ()

@end

@implementation AddNewProduct
NSString *txtAddProductName;
NSString *txtAddProductPrice;
NSString *txtAddProductDescription;
NSString *txtAddProductCategory;
NSString *txtAddImageName;
NSString *getselected;
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
    // Do any additional setup after loading the view from its nib.
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
//  [textField resignFirstResponder];
//
//   return NO;
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


- (IBAction)btnBrowseImage:(id)sender {
}
/**************select category ***************/
- (IBAction)btnSelectCategories:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Product Category" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:nil otherButtonTitles:@"Laptop Computer", @"Desktop Computer", @"Printer", @"Scanner", @"Monitor", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault; [actionSheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    switch (buttonIndex)
    {
        case 0:
            getselected = @"Laptop Computer";
            NSLog(@"selected %@",getselected);
            
            break;
        case 1:
            getselected = @"Desktop Computer";
            NSLog(@"selected %@",getselected);
            break;
        case 2:
           getselected= @"Printer";
            NSLog(@"selected %@",getselected);
            break;
        case 3:
            getselected = @"Scanner";
            NSLog(@"selected %@",getselected);
            break;
        case 4:
           getselected = @"Monitor";
            NSLog(@"selected %@",getselected);
            break;
        
    } 
}
- (IBAction)btnSaveProduct:(id)sender {
    txtAddProductName = self.txtProductName.text;
    txtAddProductPrice = self.txtProductPrice.text;
    txtAddProductDescription = self.txtProductionDescription.text;
    txtAddProductCategory = getselected;
    currentTime = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    resultStringDate = [dateFormatter stringFromDate: currentTime];
    NSLog(@"ProductName %@",txtAddProductName);
    NSLog(@"ProductPrice %@",txtAddProductPrice);
    NSLog(@"ProductDescription %@",txtAddProductDescription);
    NSLog(@"ProductCategory %@",txtAddProductCategory);
    NSLog(@"Result date %@",resultStringDate);
//    NSDictionary *addData = @{@"Product[name]":txtAddProductName,@"Product[price]":txtAddProductPrice,@"Product[description]":txtAddProductDescription,
//                              @"Product[image]":txtAddImageName,@"Product[category]":txtAddProductCategory,
//                              @"Product[datecreated]":resultStringDate
//                              };
//    APIClientIOS *client = [APIClientIOS sharedClient];
//    [client.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];//apikey for security that we put it in AppController of cakephp
//    
//    [client POST:@"products.json" parameters:addData success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Respone Object %@", responseObject);
//    }
//         failure:^(NSURLSessionDataTask *task, NSError *error) {
//             NSLog(@"Error Message: %@", error);
//         }];
    
}


@end
