//
//  MainClass.m
//  product_management
//
//  Created by Ty Votey on 6/24/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "User.h"
#import "APIClientIOS.h"


@implementation User

APIClientIOS * apiclient;

- (id) init
{
    apiclient = [APIClientIOS sharedClient];
    return self;
}

- (NSDictionary *) readSession
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userSession = [defaults objectForKey:@"UserLoginIdSession"];
    return userSession;
}

- (void) saveSession: (NSDictionary *) userSession
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userSession forKey:@"UserLoginIdSession"];
    [defaults synchronize];
}

- (void) clearSession
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"UserLoginIdSession"];
    [defaults synchronize];
}
@end
