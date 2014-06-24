//
//  AddNewProduct.m
//  product_management
//
//  Created by SOEUNG Channy on 6/19/14.


#import "AddNewProduct.h"

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

@synthesize ivProduct;

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
    ivProduct.image = [[UIImage alloc] initWithData:dataImage];
    //NSLog(@"Image Selected %@",[[UIImage alloc] initWithData:dataImage]);
    [picker dismissViewControllerAnimated:YES completion:nil];
    //NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    NSString *imageName = [imagePath lastPathComponent];//get image name
    NSLog(@"Image Name %@",imageName);
}


/**************select category ***************/
- (IBAction)btnSelectCategories:(id)sender {
    
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
    txtAddProductName = self.txtProductName.text;
    txtAddProductPrice = self.txtProductPrice.text;
    txtAddProductDescription = self.txtProductionDescription.text;
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
    
//    NSDictionary *addProduct = @{@"Product[name]":txtAddProductName,@"Product[price]":txtAddProductPrice,@"Product[description]":txtAddProductDescription,
//                              @"Product[category]":txtAddProductCategory,
//                              @"Product[datecreated]":resultStringDate
//                              };
//    APIClientIOS *client = [APIClientIOS sharedClient];
//    [client.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];//apikey for security that we put it in AppController of cakephp
//    
//    [client POST:@"products.json" parameters:addProduct success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Respone Object %@", responseObject);
//    }
//    failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"Error Message: %@", error);
//    }];
    
    
    NSData *jpegData = UIImageJPEGRepresentation(imgProduct, 1);
    NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
    NSString *filename = [NSString stringWithFormat:@"%f.jpg", currentInterval];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/productApi/"]];
    [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];
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
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
    
}


@end
