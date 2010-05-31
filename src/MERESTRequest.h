//
//  MERESTRequest.h
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MERESTResponse;

typedef enum {
    MERESTRequestMethodGet,
    MERESTRequestMethodPost,
    MERESTRequestMethodPut,
    MERESTRequestMethodDelete,
}MERESTRequestMethod;

@interface MERESTRequest : NSObject {
    NSURL *url;
    MERESTRequestMethod method;
    NSDictionary *query;
    NSData *data;
    NSDictionary *additionalHeaders;
    
    MERESTResponse *restResponse;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) MERESTRequestMethod method;
@property (nonatomic, retain) NSDictionary *query;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSDictionary *additionalHeaders;
@property (nonatomic, retain) MERESTResponse *restResponse;

- (id) initWithURL:(NSURL *)aURL method:(MERESTRequestMethod)aMethod;
- (id) initWithURL:(NSURL *)aURL method:(MERESTRequestMethod)aMethod query:(NSDictionary *)aQuery;
- (id) initWithURL:(NSURL *)aURL method:(MERESTRequestMethod)aMethod query:(NSDictionary *)aQuery data:(NSData *)aData;

@end
