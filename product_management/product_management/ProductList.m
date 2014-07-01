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
    
    APIClientIOS *apiClient;
    NSMutableArray *productCates;
    NSMutableArray *cateProducts;
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
    
    //cell.textLabel.text = [product objectForKey:@"name"];
    cell.textLabel.text=[NSString stringWithFormat: @"Name: %@", [product objectForKey:@"name"]];
    //cell.detailTextLabel.text = [product objectForKey:@"price"];
    cell.detailTextLabel.text=[NSString stringWithFormat: @"Price: %@ USD", [product objectForKey:@"price"]];
    
    NSURL* aURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/productApi/product/%@", [product objectForKey:@"image"]]];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    cell.imageView.image = [UIImage imageWithData:data];
    return cell;
}
/*********** Confirm Message before Delete Record ***********/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            self.indexPathToBeDeleted = indexPath;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:@"Are you sure?"
                                                           delegate:self
                                                  cancelButtonTitle:@"NO"
                                                  otherButtonTitles:@"YES", nil];
            [alert show];
            
        }
    
}
/************* For check is user NO or YES **************/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // This method is invoked in response to the user's action. The altert view is about to disappear (or has been disappeard already - I am not sure)
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"NO"])
    {
        NSLog(@"Nothing to do here");
    }
    /************** If user click on YES, it delete record ***************/
    else if([title isEqualToString:@"YES"])
    {
        NSDictionary *parameters = [[NSDictionary alloc] initWithDictionary:[[[productCates objectAtIndex:self.indexPathToBeDeleted.section] objectForKey:@"Product"] objectAtIndex:self.indexPathToBeDeleted.row]];
        NSLog(@"Id of product %@",[parameters objectForKey:@"id"]);
        NSString *ids = [parameters objectForKey:@"id"];
        NSLog(@"ID of Product %@", [NSString stringWithFormat:@"%@products/%@",ids,@"%@.json"]);
        APIClientIOS *client = [APIClientIOS sharedClient];
        [client.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [client DELETE:[NSString stringWithFormat:@"products/%@.json", ids] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"products/%@.json", ids);
            //[self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error Message: %@", error);
        }];
        cateProducts = [[NSMutableArray alloc] initWithArray:[[productCates objectAtIndex:self.indexPathToBeDeleted.section] objectForKey:@"Product"]];
        NSLog(@"before %@", cateProducts);
        [cateProducts removeObjectAtIndex:self.indexPathToBeDeleted.row];
        [self.reloadProduct reloadData];
        NSLog(@"Delete the cell");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
