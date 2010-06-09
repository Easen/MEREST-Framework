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
        if ([stringKey length] > 0) {
            SEL setterMethod = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [[stringKey substringToIndex:1] uppercaseString], [stringKey substringFromIndex:1]]);
            if ([self respondsToSelector:setterMethod]) {
                [self performSelector:setterMethod withObject:[dictionaryValue objectForKey:stringKey]];
            }
        }
        
    }
}

@end
