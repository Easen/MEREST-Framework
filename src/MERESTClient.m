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
    
    urlRequest = [[NSMutableURLRequest alloc] init];
    
    switch (aRequest.method) {
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
        requestURL = [NSURL URLWithString:[aRequest.url absoluteString]  relativeToURL:self.baseURL];
    } else {
        requestURL = [[self.restRequest.url copy] autorelease];
    }

    [urlRequest setURL:requestURL];
    [urlRequest setAllHTTPHeaderFields:self.restRequest.additionalHeaders];
    
    dataRetrieved = [[NSMutableData alloc] init];
    
    urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self startImmediately:YES];
    return YES;
    
}

#pragma mark -
#pragma mark NSURLConnection methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
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

@end