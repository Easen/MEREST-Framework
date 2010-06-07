//
//  StreetResource.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StreetResource.h"
#import "HousesCollection.h"


@implementation StreetResource

@synthesize id=_id;
@synthesize name;
@synthesize town;
@synthesize houses;

- (void) loadOptions {
    isValueARESTURL = YES;
}

- (void) setHouses:(id)aValue {
    if (aValue == nil) {
        houses = nil;
    } else if ([aValue isKindOfClass:[HousesCollection class]]) {
        houses = [aValue retain];
    } else if ([aValue isKindOfClass:[NSArray class]]) {
        houses = [[HousesCollection alloc] initWithParentModel:self];
        [houses setValue:aValue];
    }
}

- (void) dealloc
{
    [_id release];
    [name release];
    [town release];
    [houses release];
    [super dealloc];
}


@end
