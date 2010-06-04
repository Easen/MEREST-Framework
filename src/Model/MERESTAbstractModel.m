//
//  MERESTAbstractModel.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MERESTAbstractModel.h"


@implementation MERESTAbstractModel

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
            [aParentModel release];
            parentModel = aParentModel;
        }
    }
    [self populate];
    return self;
} 

- (void) populate {
    // Overload this method
}

@end
