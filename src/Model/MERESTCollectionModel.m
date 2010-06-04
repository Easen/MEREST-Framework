//
//  MERESTCollectionModel.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MERESTCollectionModel.h"


@implementation MERESTCollectionModel

@synthesize arrayOfResources;

- (id) init
{
    self = [super init];
    if (self != nil) {
        arrayOfResources = [[NSArray alloc] init];
    }
    return self;
}

- (Class) classOfAResource {
    return [NSObject class];
}

- (void) populate
{
    if (value == nil || ![value isKindOfClass:[NSArray class]]) {
        return;
    }
    
    id resourceClass = [[self classOfAResource] alloc];
    if (![resourceClass respondsToSelector:@selector(initWithValue:ParentModel:)]) {
        return;
    }
    
    NSArray *array = (NSArray *)value;
    NSMutableArray *newArrayOfResources = [NSMutableArray arrayWithCapacity:[array count]];
    
    for (id item in array) {
        id resouce = [resourceClass initWithValue:item ParentModel:self];
        [newArrayOfResources addObject:resouce];
    }
    [resourceClass release];
    [arrayOfResources release];
    arrayOfResources = newArrayOfResources;    
}


@end
