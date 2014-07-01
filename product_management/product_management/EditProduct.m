//
//  EditProduct.m
//  product_management
//
//  Created by Ty Votey on 6/20/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "EditProduct.h"
#import "APIClientIOS.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constant.h"

@interface EditProduct ()




@end

@implementation EditProduct

APIClientIOS *apiclient;

NSString *txtAddProductName;
NSString *txtAddProductPrice;
NSString *txtAddProductDescription;
NSString *txtAddImageName;
NSNumber *getselected;
NSNumber *txtAddCategory;

NSString *resultStringDate;
NSDateFormatter *dateFormatter;
NSDate *currentTime;
UIImage *imgProduct;
NSData *dataImage;
@synthesize tvProduct;
@synthesize proId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title= @"Edit Product";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    apiclient = [[APIClientIOS alloc] init];
    apiclient = [APIClientIOS sharedClient];
    
    //NSLog(@"ProId%@",self.proId);
    if (self.proId) {
        [apiclient GET:[NSString stringWithFormat:@"products/%@.json",proId] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Respone Object %@", responseObject);
            NSDictionary * productID = [[responseObject objectForKey:@"products"] objectForKey:@"Product"];
            self.txtProName.text = [productID valueForKey:@"name"];
            self.txtProPrice.text = [productID valueForKey:@"price"];
            self.txtProDes.text = [productID valueForKey:@"description"];
            if ([self.txtProDes.text isEqualToString:NULL]) {
                self.txtProDes.text = NULL;
            }
            NSLog(@"Product: %@",productID);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error Message: %@", error);
        }];
    }
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSelectCate:(id)sender {
    [self.view endEditing:YES];//for hid keyborad
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

- (IBAction)btnBrowsImg:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.allowsEditing=TRUE;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    imgProduct = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    self.imageView = photo;
    dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    tvProduct.image = [[UIImage alloc] initWithData:dataImage];
    //NSLog(@"Image Selected %@",[[UIImage alloc] initWithData:dataImage]);
    [picker dismissViewControllerAnimated:YES completion:nil];
    //NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    NSString *imageName = [imagePath lastPathComponent];//get image name
    NSLog(@"Image Name %@",imageName);
}

- (IBAction)btnSave:(id)sender {
    
    txtAddProductName = [self.txtProName.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    txtAddProductPrice = [self.txtProPrice.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    txtAddProductDescription = [self.txtProDes.text stringByTrimmingCharactersInSet:
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
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:ApiBaseURL]];
    
    [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
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
        AFHTTPRequestOperation *op = [manager POST:[NSString stringWithFormat:@"products/%@.json",proId] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //do not put image inside parameters dictionary as I did, but append it!
            [formData appendPartWithFileData:jpegData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@",  responseObject);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            ProductList* objAddNewProduct = [[ProductList alloc] initWithNibName:@"ProductList" bundle:nil];
            [self.navigationController pushViewController:objAddNewProduct animated:YES];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        }];
        [op start];
        //ProductList * objList = [[ProductList alloc] initWithNibName:@"ProductList" bundle:nil];
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    

}
@end
