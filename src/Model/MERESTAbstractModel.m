//
//  MERESTAbstractModel.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MERESTAbstractModel.h"

@interface MERESTAbstractModel (Private)

- (void) processOptions;

@end

@interface MERESTAbstractModel (Option_isValueARESTURL)

- (void) processOptionIsValueARESTURL;

@end

@implementation MERESTAbstractModel

@synthesize URL;
@synthesize value;
@synthesize parentModel;

- (id) init {
    return [self initWithParentModel:nil];
}

- (id) initWithParentModel:(MERESTAbstractModel *) aParentModel {
    self = [super init];
    if (self != nil) {
        if (aParentModel != nil) {
            [parentModel release];
            parentModel = aParentModel;
        }
    }
    [self loadOptions];
    return self;
}

- (void) setValue:(id)aValue {
    value = [aValue retain];
    [self processOptions];
    [self populate];
}
    
- (void) loadOptions {
    // Overload this method
}

- (void) populate {
    // Overload this method
}

#pragma mark -
#pragma mark Private method

- (void) processOptions {
    if (isValueARESTURL == YES) {
        [self processOptionIsValueARESTURL];
    }
}

#pragma mark -
#pragma mark Option_isValueARESTURL

- (void) processOptionIsValueARESTURL {
    if (value == nil) {
        return;
    }
    if ([value isKindOfClass:[NSString class]]) {
        URL = [[NSURL URLWithString:(NSString *)value relativeToURL:self.parentModel.URL] retain];
    }
}

@end
