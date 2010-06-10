//
//  MERESTClient.m
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import "MERESTClient.h"
#import "MERESTRequest.h"
#import "MERESTResponse.h"

#define kMERESTClientDefaultTimeoutInterval 10.0

@interface MERESTClient (Private)

- (void) resetClient;
- (void) performRequestOnNewThread;

@end


@implementation MERESTClient

@synthesize baseURL;
@synthesize delegate;
@synthesize restRequest;
@synthesize timeoutInterval;

- (id) init
{
    self = [super init];
    if (self != nil) {
        timeoutInterval = kMERESTClientDefaultTimeoutInterval;
    }
    return self;
}

- (id) initWithBaseURL:(NSURL *)aBaseURL
{
    self = [super init];
    if (self != nil) {
        self.baseURL = aBaseURL;
    }
    return self;
}

- (BOOL) performRequest:(MERESTRequest *) aRequest withDelegate:(id<MERESTClientProtocol>) aDelegate
{
    if (urlRequest != nil) {
        return NO;
    }
    
    self.delegate = aDelegate;
    self.restRequest = aRequest;
    
    [NSThread detachNewThreadSelector:@selector(performRequestOnNewThread) toTarget:self withObject:nil];
    
    return YES;
    
}

#pragma mark -
#pragma mark NSURLConnection methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    if ([NSThread isMainThread] == NO) {
        return [self performSelectorOnMainThread:@selector(connectionDidFinishLoading:) withObject:connection waitUntilDone:NO];
    }
    MERESTResponse *restResponse = [[MERESTResponse alloc] initWithRESTRequest:self.restRequest 
                                                                   URLResponse:urlResponse 
                                                                          data:dataRetrieved];
    self.restRequest.restResponse = restResponse;
    [restResponse release];
    
    [self resetClient];
    
    [delegate meRESTClient:self requestSuccessful:self.restRequest];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([NSThread isMainThread] == NO) {
        return [self performSelectorOnMainThread:@selector(resetClient) withObject:nil waitUntilDone:NO];
    }
    
    [self resetClient];
    
    [delegate meRESTClient:self requestFailed:self.restRequest withError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    urlResponse = [response retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataRetrieved appendData:data];
}
    

#pragma mark -
#pragma mark Private methods

- (void) resetClient
{
    [urlConnection release];
    [urlRequest release];
    [urlResponse release];
    [dataRetrieved release];
    
    urlConnection = nil;
    urlRequest = nil;
    urlResponse = nil;
    dataRetrieved = nil;
}

- (void) performRequestOnNewThread 
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    urlRequest = [[NSMutableURLRequest alloc] init];
    
    switch (self.restRequest.method) {
        case MERESTRequestMethodPost:
            [urlRequest setHTTPMethod:@"POST"];
        case MERESTRequestMethodPut:
            [urlRequest setHTTPMethod:@"PUT"];
            [urlRequest setHTTPBody:self.restRequest.data];
        case MERESTRequestMethodGet:
            [urlRequest setHTTPMethod:@"GET"];
        case MERESTRequestMethodDelete:
            [urlRequest setHTTPMethod:@"DELETE"];
            break;
    }
    
    NSURL *requestURL = nil;
    if (self.baseURL != nil) {
        requestURL = [NSURL URLWithString:[self.restRequest.URL absoluteString]  relativeToURL:self.baseURL];
    } else {
        requestURL = [[self.restRequest.URL copy] autorelease];
    }

    [urlRequest setURL:requestURL];
    [urlRequest setAllHTTPHeaderFields:self.restRequest.additionalHeaders];
    [urlRequest setTimeoutInterval:5.0];
    
    dataRetrieved = [[NSMutableData alloc] init];

    urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self startImmediately:YES];

    while(urlConnection != nil) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

    [pool release];
}

@end
