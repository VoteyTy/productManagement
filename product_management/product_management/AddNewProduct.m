//
//  AddNewProduct.m
//  product_management
//
//  Created by SOEUNG Channy on 6/19/14.


#import "AddNewProduct.h"
#import "ProductList.h"
#import "Home.h"

@interface AddNewProduct ()

@end

@implementation AddNewProduct

NSString *txtAddProductName;
NSString *txtAddProductPrice;
NSString *txtAddProductDescription;
NSString *txtAddImageName;
NSNumber *getselected;
NSNumber *txtAddCategory;

NSString *resultStringDate;
NSDateFormatter *dateFormatter;
NSDate *currentTime;
bool moved;
UIImage *imgProduct;
NSData *dataImage;

//@synthesize ivProduct;

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

/**************** clear data in form when user click on button back ********************/

- (void)viewDidDisappear:(BOOL)animated
{
    imgProduct = nil;
    txtAddProductPrice = nil;
    txtAddProductName = nil;
    txtAddProductDescription = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnBrowseImage:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.allowsEditing=TRUE;
    [self presentViewController:picker animated:YES completion:nil];
}

/****** get image from select *****/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    imgProduct = [info objectForKey:UIImagePickerControllerOriginalImage];
//    self.imageView = photo;
    dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    //ivProduct.image = [[UIImage alloc] initWithData:dataImage];
    //NSLog(@"Image Selected %@",[[UIImage alloc] initWithData:dataImage]);
    [picker dismissViewControllerAnimated:YES completion:nil];
    //NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    NSString *imageName = [imagePath lastPathComponent];//get image name
    NSLog(@"Image Name %@",imageName);
}


/************** select category ***************/
- (IBAction)btnSelectCategories:(id)sender {
    [self.view endEditing:YES];//for hide keyborad
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Product Category" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:nil otherButtonTitles:@"Computer", @"Smart Phone", @"Printer", @"Scanner", @"Monitor", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault; [actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    switch (buttonIndex)
    {
        case 0:
            getselected = [NSNumber numberWithInt:1];
            NSLog(@"selected %@",getselected);
            
            break;
        case 1:
            getselected = [NSNumber numberWithInt:2];
            NSLog(@"selected %@",getselected);
            break;
        case 2:
            getselected = [NSNumber numberWithInt:3];
            NSLog(@"selected %@",getselected);
            break;
        case 3:
            getselected = [NSNumber numberWithInt:4];
            NSLog(@"selected %@",getselected);
            break;
        case 4:
            getselected = [NSNumber numberWithInt:5];
            NSLog(@"selected %@",getselected);
            break;
        
    } 
}
- (IBAction)btnSaveProduct:(id)sender {
    txtAddProductName = [self.txtProductName.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    txtAddProductPrice = [self.txtProductPrice.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    txtAddProductDescription = [self.txtProductionDescription.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    txtAddCategory = getselected;
    currentTime = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    resultStringDate = [dateFormatter stringFromDate: currentTime];
    NSLog(@"ProductName %@",txtAddProductName);
    NSLog(@"ProductPrice %@",txtAddProductPrice);
    NSLog(@"ProductDescription %@",txtAddProductDescription);
    NSLog(@"ProductCategory %@",txtAddCategory);
    NSLog(@"Result date %@",resultStringDate);
    
    
    NSData *jpegData = UIImageJPEGRepresentation(imgProduct, 1);
    NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
    NSString *filename = [NSString stringWithFormat:@"%f.jpg", currentInterval];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/productApi/"]];
    [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];
     if (!imgProduct || [txtAddProductName isEqualToString:@""] || [txtAddProductPrice isEqualToString:@""] || !getselected) {
         UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please insert data in the fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }else{

        NSDictionary *parameters = @{@"category_id":txtAddCategory,
                                     @"name": txtAddProductName,
                                     @"price": txtAddProductPrice,
                                     @"description": txtAddProductDescription,
                                     @"image": filename,
                                     @"datecreated": resultStringDate
                                    };
        AFHTTPRequestOperation *op = [manager POST:@"products.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //do not put image inside parameters dictionary as I did, but append it!
            [formData appendPartWithFileData:jpegData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@",  responseObject);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            Home* objHome = [[Home alloc] initWithNibName:@"Home" bundle:nil];
            
            [self.navigationController pushViewController:objHome animated:YES];
        }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        }];
        [op start];
    }
}

#pragma mark - text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.txtProductPrice)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;//add keyboard as number
    }
}

@end
