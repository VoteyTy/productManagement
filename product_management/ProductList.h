//
//  ProductList.h
//  product_management
//
//  Created by Apple on 6/20/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "EditProduct.h"
#import "UserProfile.h"

@interface ProductList : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblProduct;
@property (weak, nonatomic) IBOutlet UITableView *reloadProduct;
@property (strong, nonatomic) NSIndexPath *indexPathToBeDeleted;
@end
