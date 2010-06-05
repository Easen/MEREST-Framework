//
//  StreetResource.h
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MERESTResourceModel.h"

@class HousesCollection;

@interface StreetResource : MERESTResourceModel {
    NSNumber *id;
    NSString *name;
    NSString *town;
    HousesCollection *houses;
}

@property (nonatomic, assign) NSNumber *id;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *town;
@property (nonatomic, assign) HousesCollection *houses;

@end
