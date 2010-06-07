//
//  StreetModel.h
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MERESTCollectionModel.h"


@interface StreetCollection : MERESTCollectionModel {
}

- (Class) classOfAResource;

+ (StreetCollection *)sharedInstance;

@end
