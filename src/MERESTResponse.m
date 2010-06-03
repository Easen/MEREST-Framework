//
//  MERESTResponse.m
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import "MERESTResponse.h"

static NSArray *ValidContentTypesJSON = [[NSArray alloc] initWithObjects:@"application/json", @"text/json"];
static NSArray *ValidContentTypesXML = [[NSArray alloc] initWithObjects:@"application/xml", @"text/xml"];

@interface MERESTResponse (Private)

- (void) setStatusCode:(NSInteger) statusCode;

@end


@implementation MERESTResponse

@synthesize restRequest;
@synthesize statusCode;
@synthesize headers;
@synthesize data;

- (id) init
{
    self = [super init];
    if (self != nil) {
    }
    return self;
}

- (id) initWithRESTRequest:(MERESTRequest *) aRestRequest 
               URLResponse:(NSURLResponse *) aUrlResponse 
                      data:(NSData *)aData
{
    self = [super init];
    if (self != nil) {
        restRequest = [aRestRequest retain];
        statusCode = MERESTRequestHTTPStatusCodeInvalid;
        
        if (aUrlResponse != nil && [aUrlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
           [self setStatusCode:(NSInteger)[aUrlResponse performSelector:@selector(statusCode)]];
            headers = [[aUrlResponse performSelector:@selector(allHeaderFields)] retain];
        } else {
            headers = [[NSDictionary dictionary] retain];
        }
        
        if ([headers objectForKey:@"Content-type"]) {
            contentType = MERESTResponseContentTypeInvalid;
            
            NSString *stringContentType = [(NSString *)[headers objectForKey:@"Content-type"] lowercaseString];
            if ([ValidContentTypesJSON indexOfObjectIdenticalTo:contentType] != NSNotFound) {
                contentType = MERESTResponseContentTypeJSON;
            } else if ([ValidContentTypesXML indexOfObjectIdenticalTo:contentType] != NSNotFound) {
                contentType = MERESTResponseContentTypeXML;
            }
        }

        if (aData != nil) {
            data = [aData retain];
        }
    }
    return self;
    
}

- (id) dataObjectUsingClass:(Class) aClass
{
    // @todo
    return nil;
}

#pragma mark -
#pragma mark Private methods

- (void) setStatusCode:(NSInteger) aStatusCode 
{
    // @todo Check to see if the statusCode is valid
    statusCode = aStatusCode;
}

@end
