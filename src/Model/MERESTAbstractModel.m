//
//  MERESTAbstractModel.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MERESTAbstractModel.h"

@interface MERESTAbstractModel (Private)

- (void) populateModel;
- (void) processOptions;

@end

@interface MERESTAbstractModel (Option_isValueARESTURL)

- (void) processOptionIsValueARESTURL;

@end

@implementation MERESTAbstractModel

@synthesize URL;
@synthesize value;
@synthesize parentModel;

- (id) init
{
    return [self initWithValue:nil ParentModel:nil];
}

- (id) initWithValue:(id)aValue 
{
    return [self initWithValue:aValue ParentModel:nil];
}

- (id) initWithValue:(id)aValue ParentModel:(MERESTAbstractModel *) aParentModel
{
    self = [super init];
    if (self != nil) {
        if (aValue != nil) {
            [value release];
            value = [aValue retain];
        }
        if (aParentModel != nil) {
            [parentModel release];
            parentModel = aParentModel;
        }
    }
    [self populateModel];
    return self;
}

- (void) loadOptions {
    // Overload this method
}

- (void) populate {
    // Overload this method
}

#pragma mark -
#pragma mark Private method

- (void) populateModel {
    [self loadOptions];
    [self processOptions];
    [self populate];
}

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
