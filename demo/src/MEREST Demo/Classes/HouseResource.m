//
//  HouseResource.m
//  MEREST Demo
//
//  Created by Marc Easen on 05/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HouseResource.h"


@implementation HouseResource

@synthesize id=_id;
@synthesize numberOfBedrooms;
@synthesize hasGarden;
@synthesize hasGarage;


- (void) dealloc
{
    [_id release];
    [numberOfBedrooms release];
    [hasGarden release];
    [hasGarage release];
    [super dealloc];
}


@end
