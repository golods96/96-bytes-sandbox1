//
//  READAppDelegate.h
//  readResponse
//
//  Created by Lev on 3/15/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class READViewController;

@interface READAppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
    READViewController *readController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) READViewController *viewController;

@end
