//
//  MERESTResponse.m
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import "MERESTResponse.h"
#import "MERESTRequest.h"
#import "MERESTAbstractModel.h"
#import "JSON.h"

@interface MERESTResponse (Private)

- (void) setStatusCode:(NSInteger) statusCode;

@end


@implementation MERESTResponse

@synthesize restRequest;
@synthesize URL;
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
        statusCode = MERESTResponseHTTPStatusCodeInvalid;
        
        if (aUrlResponse != nil && [aUrlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
           [self setStatusCode:(NSInteger)[aUrlResponse performSelector:@selector(statusCode)]];
            headers = [[aUrlResponse performSelector:@selector(allHeaderFields)] retain];
            URL = [[aUrlResponse URL] retain];
        } else {
            headers = [[NSDictionary dictionary] retain];
        }
        
        if ([headers objectForKey:@"Content-Type"]) {
            contentType = MERESTResponseContentTypeInvalid;
            
            NSString *stringContentType = [(NSString *)[headers objectForKey:@"Content-Type"] lowercaseString];
            if ([stringContentType isEqualToString:@"application/json"]) {
                contentType = MERESTResponseContentTypeJSON;
            } else if ([stringContentType isEqualToString:@"text/xml"]) {
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
    id dataObject = [aClass alloc];
    id object = [self dataObjectUsingObject:dataObject];
    [dataObject release];
    return [object autorelease];
}

- (id) dataObjectUsingObject:(id) anObject
{
    if ([anObject isMemberOfClass:[MERESTAbstractModel class]]) {
        return nil;
    }
    NSString *stringData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]; 
    if (contentType == MERESTResponseContentTypeJSON) {
        
        NSError *errorParsing = nil;
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        id parsedJsonObject = [jsonParser objectWithString:stringData error:&errorParsing];
        
        [(MERESTAbstractModel *) anObject setURL:self.URL];
        
        if (errorParsing == noErr) {
            [(MERESTAbstractModel *)anObject setValue: parsedJsonObject];
            return anObject;
        }
    }
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
