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
    id valueToProcess = value;
    if (value == nil || ![value isKindOfClass:[NSArray class]]) {
        if ([value isKindOfClass:[NSDictionary class]] && // is the value a dictionary
            [[(NSDictionary *)value allKeys] count] == 1 && // does it contain one key value pair
            [[[(NSDictionary *)value allValues] objectAtIndex:0] isKindOfClass:[NSArray class]]) // is that key value pair an array
        {
            valueToProcess = [[(NSDictionary *)value allValues] objectAtIndex:0];
        } else {
            return;
        }
    }
    
    id resourceClass = [[self classOfAResource] alloc];
    if (![resourceClass respondsToSelector:@selector(initWithParentModel:)]) {
        return;
    }
    
    NSArray *array = (NSArray *)valueToProcess;
    NSMutableArray *newArrayOfResources = [NSMutableArray arrayWithCapacity:[array count]];
    
    for (id item in array) {
        MERESTAbstractModel *resouce = [[[self classOfAResource] alloc] initWithParentModel:self];
        [resouce setValue:item];
        [newArrayOfResources addObject:resouce];
    }
    [resourceClass release];
    [arrayOfResources release];
    arrayOfResources = [newArrayOfResources retain];    
}


@end
