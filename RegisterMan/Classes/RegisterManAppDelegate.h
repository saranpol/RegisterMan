//
//  RegisterManAppDelegate.h
//  RegisterMan
//
//  Created by saranpol on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEFAULT_SUBMIT_URL @"http://203.150.224.154/~estee/eventlive/index.php/register/create"

@class RegisterManViewController;

@interface RegisterManAppDelegate : NSObject <UIApplicationDelegate> {
@public
    UIWindow *window;
    RegisterManViewController *viewController;
}
+ (RegisterManAppDelegate *)core;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RegisterManViewController *viewController;

@end

