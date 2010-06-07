//
//  MEREST_DemoAppDelegate.m
//  MEREST Demo
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright Marc Easen 2010. All rights reserved.
//

#import "MEREST_DemoAppDelegate.h"
#import "StreetCollectionViewController.h"
#import "StreetCollection.h"


@implementation MEREST_DemoAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch   
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end

