//
//  AddNewProduct.h
//  product_management
//
//  Created by Apple on 6/19/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClientIOS.h"

@interface AddNewProduct : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtProductName;
@property (strong, nonatomic) IBOutlet UITextField *txtProductPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtProductionDescription;
- (IBAction)btnBrowseImage:(id)sender;
- (IBAction)btnSelectCategories:(id)sender;
- (IBAction)btnSaveProduct:(id)sender;
@end
