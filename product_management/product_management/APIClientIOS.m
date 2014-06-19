//
//  APIClientIOS.m
//  AFNetworkingIOS
//
//  Created by Ty Votey on 6/11/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import "APIClientIOS.h"

static NSString * const BaseUrl = @"http://localhost:8888/simple-project-api/";

@implementation APIClientIOS

+ (instancetype)sharedClient {
    static APIClientIOS *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClientIOS alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    });
    
    return _sharedClient;
}
@end
