//
//  MERESTRequest.m
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import "MERESTRequest.h"


@implementation MERESTRequest

@synthesize URL;
@synthesize method;
@synthesize query;
@synthesize data;
@synthesize additionalHeaders;
@synthesize restResponse;

- (id) initWithURL:(NSURL *)aURL method:(MERESTRequestMethod)aMethod
{
    return [self initWithURL:aURL method:aMethod query:nil data:nil];
}

- (id) initWithURL:(NSURL *)aURL method:(MERESTRequestMethod)aMethod query:(NSDictionary *)aQuery
{
    return [self initWithURL:aURL method:aMethod query:aQuery data:nil];
}

- (id) initWithURL:(NSURL *)aURL method:(MERESTRequestMethod)aMethod query:(NSDictionary *)aQuery data:(NSData *)aData
{
    self = [super init];
    if (self != nil) {
        self.URL = aURL;
        self.method = aMethod;
        self.query = aQuery;
        self.data = aData;
    }
    return self;
}


@end
