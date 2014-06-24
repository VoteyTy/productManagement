//
//  MainClass.h
//  product_management
//
//  Created by Ty Votey on 6/24/14.
//  Copyright (c) 2014 Ty Votey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClientIOS.h"
@interface User : NSObject


- (NSDictionary *) readSession;  // read Session from login page
- (void) saveSession: (NSDictionary *) userSession; // save Session for
- (void) clearSession; // save ClearSession

@end
