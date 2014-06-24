//
//  APIClientIOS.h
//  AFNetworkingIOS
//
//  Created by Ty Votey on 6/11/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
//@interface APIClientIOS : NSObject

@interface APIClientIOS : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
