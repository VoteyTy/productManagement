//
//  EditProduct.h
//  product_management
//
//  Created by Ty Votey on 6/20/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductList.h"

@interface EditProduct : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (strong,nonatomic) NSString * proId;
@property (strong, nonatomic) IBOutlet UITextField *txtProName;
@property (strong, nonatomic) IBOutlet UITextField *txtProPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtProDes;
@property (strong, nonatomic) IBOutlet UIImageView *tvProduct;
- (IBAction)btnSelectCate:(id)sender;

- (IBAction)btnBrowsImg:(id)sender;
- (IBAction)btnSave:(id)sender;
@end
