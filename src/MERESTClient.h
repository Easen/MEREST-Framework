//
//  MERESTClient.h
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MERESTClient;
@class MERESTRequest;
@class MERESTResponse;


@protocol MERESTClientProtocol
@required
- (void) meRESTClient:(MERESTClient *)client requestSuccessful:(MERESTRequest *)request;
- (void) meRESTClient:(MERESTClient *)client requestFailed:(MERESTRequest *)request withError:(NSError *)error;
@end

@interface MERESTClient : NSObject {
    NSURL *baseURL;
    id<MERESTClientProtocol> delegate;
    MERESTRequest *restRequest;
    NSTimeInterval timeoutInterval;
@protected
    NSMutableURLRequest *urlRequest;
    NSURLConnection *urlConnection;
    NSMutableData *dataRetrieved;
    NSURLResponse *urlResponse;
}

@property (nonatomic, retain) NSURL *baseURL;
@property (nonatomic, retain) id<MERESTClientProtocol> delegate;
@property (nonatomic, retain) MERESTRequest *restRequest;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

- (id) initWithBaseURL:(NSURL *)aBaseURL;
- (BOOL) performRequest:(MERESTRequest *)request withDelegate:(id<MERESTClientProtocol>) delegate;

@end
