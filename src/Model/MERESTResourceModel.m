//
//  MERESTResourceModel.m
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MERESTResourceModel.h"


@implementation MERESTResourceModel

- (void) populate
{
    if (value == nil || ![value isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSDictionary *dictionaryValue = (NSDictionary *)value;
    
    for (NSString *stringKey in [dictionaryValue keyEnumerator]) {
        SEL setterMethod = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [stringKey capitalizedString]]);
        if ([self respondsToSelector:setterMethod]) {
            [self performSelector:setterMethod withObject:[dictionaryValue objectForKey:stringKey]];
        }
    }
}

@end
