//
//  MEREST_DemoAppDelegate.h
//  MEREST Demo
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright Marc Easen 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEREST_DemoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

