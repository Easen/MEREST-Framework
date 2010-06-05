//
//  StreetResource.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StreetResource.h"


@implementation StreetResource

@synthesize id;
@synthesize name;
@synthesize town;
@synthesize houses;

- (void) loadOptions {
    isValueARESTURL = YES;
}

@end
