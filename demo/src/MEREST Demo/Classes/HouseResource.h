//
//  HouseResource.h
//  MEREST Demo
//
//  Created by Marc Easen on 05/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MERESTResourceModel.h"

@interface HouseResource : MERESTResourceModel {
    NSNumber *_id;
    NSNumber *numberOfBedrooms;
    NSNumber *hasGarden;
    NSNumber *hasGarage;
}

@property (nonatomic, assign) NSNumber *id;
@property (nonatomic, assign) NSNumber *numberOfBedrooms;
@property (nonatomic, assign) NSNumber *hasGarden;
@property (nonatomic, assign) NSNumber *hasGarage;

@end
