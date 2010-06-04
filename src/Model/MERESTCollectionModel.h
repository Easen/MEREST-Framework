//
//  MERESTCollectionModel.h
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MERESTAbstractModel.h"


@interface MERESTCollectionModel : MERESTAbstractModel {
    NSArray *arrayOfResources;
}

@property (nonatomic, readonly) NSArray *arrayOfResources;

- (Class) classOfAResource;

@end
