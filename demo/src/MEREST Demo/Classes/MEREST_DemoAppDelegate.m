//
//  MEREST_DemoAppDelegate.m
//  MEREST Demo
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright Marc Easen 2010. All rights reserved.
//

#import "MEREST_DemoAppDelegate.h"
#import "RootViewController.h"
#import "StreetCollection.h"


@implementation MEREST_DemoAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
    
    MERESTRequest *request = [[MERESTRequest alloc] initWithURL:[NSURL URLWithString:@"/street"]
                                                         method:MERESTRequestMethodGet];
    MERESTClient *client = [[MERESTClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://rest-demo.local"]];
    [client performRequest:request withDelegate:self];
    
	
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


#pragma mark MERESTClientProtocol methods
- (void) meRESTClient:(MERESTClient *)client requestSuccessful:(MERESTRequest *)request
{
    NSLog(@"response = %@", request.restResponse.data);
    StreetCollection *collection = [request.restResponse dataObjectUsingClass:[StreetCollection class]];
    NSLog(@"Street collection = %@", collection);
}

- (void) meRESTClient:(MERESTClient *)client requestFailed:(MERESTRequest *)request withError:(NSError *)error
{
    NSLog(@"failed request %@, error =  %@", request, error);
}

@end

