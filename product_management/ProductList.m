//
//  ProductList.m
//  product_management
//
//  Created by SOEUNG Channy on 6/20/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "ProductList.h"
#import "APIClientIOS.h"

@interface ProductList (){
    //NSDictionary *productCategory;
    //NSArray *productSectionTitles;
    //NSMutableArray *pictureProduct;
    
    APIClientIOS *apiClient;
    NSMutableArray *productCates;
}

@end

@implementation ProductList

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
    
    apiClient = [APIClientIOS sharedClient];
    
    // load data from api
    [apiClient GET:@"categories.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Respone Object %@", responseObject);
        productCates = [[NSMutableArray alloc] initWithArray:[responseObject objectForKey:@"categories"]];
        [self.tblProduct reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error Message: %@", error);
    }];
}
//pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [productSectionTitles count];
    return [productCates count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *str = [NSString stringWithFormat:@"%@: (%i)", [[[productCates objectAtIndex:section] objectForKey:@"Category"] objectForKey:@"name"], [[[productCates objectAtIndex:section] objectForKey:@"Product"] count]];
    
    return str;
    
}

/*********************** set background on Section Title **************************/
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor blackColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[[productCates objectAtIndex:section] objectForKey:@"Product"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    NSDictionary *product = [[NSDictionary alloc] initWithDictionary:[[[productCates objectAtIndex:indexPath.section] objectForKey:@"Product"] objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [product objectForKey:@"name"];
    cell.detailTextLabel.text = [product objectForKey:@"price"];
    
    NSURL* aURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/productApi/product/%@", [product objectForKey:@"image"]]];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    cell.imageView.image = [UIImage imageWithData:data];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [productCates removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [tableView reloadData];
    
//    NSDictionary *params = @{@"Recipe[title]": @"AFNetworking Title 3",
//                             @"Recipe[body]": @"AFNetworking Title 2 is updated to AFNetworking Title 3"};
//    
//    // 2 is Recipe ID that need to delete
//  
//    APIClientIOS *client = [APIClientIOS sharedClient];
//    [client.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [client.requestSerializer setValue:@"123" forHTTPHeaderField:@"apikey"];//apikey for security that we put it in AppController of cakephp
//    [client DELETE:@"products/1.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"Error Message: %@", error);
//    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
