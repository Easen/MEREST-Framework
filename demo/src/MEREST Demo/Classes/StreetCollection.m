//
//  StreetModel.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StreetCollection.h"
#import "StreetResource.h"

static StreetCollection *sharedStreetCollection = nil;


@implementation StreetCollection

- (Class) classOfAResource
{
    return [StreetResource class];
}

#pragma mark -
#pragma mark Singleton Methods

+ (StreetCollection *)sharedInstance
{
    if (sharedStreetCollection == nil) {
        sharedStreetCollection = [[super allocWithZone:NULL] init];
    }
    return sharedStreetCollection;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


@end
