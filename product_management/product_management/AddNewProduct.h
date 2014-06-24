//
//  AddNewProduct.h
//  product_management
//
//  Created by SOEUNG Channy on 6/19/14.


#import <UIKit/UIKit.h>
#import "APIClientIOS.h"
#import "AFHTTPRequestOperationManager.h"
@interface AddNewProduct : UIViewController<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtProductName;
@property (strong, nonatomic) IBOutlet UITextField *txtProductPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtProductionDescription;
@property (strong, nonatomic) IBOutlet UIImageView *ivProduct;

- (IBAction)btnBrowseImage:(id)sender;
- (IBAction)btnSelectCategories:(id)sender;
- (IBAction)btnSaveProduct:(id)sender;

//@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end
