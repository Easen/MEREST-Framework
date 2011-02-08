//
//  MERESTAbstractModel.h
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MERESTAbstractModel : NSObject {
    NSURL *URL;
    id value;
    MERESTAbstractModel *parentModel; 
@protected
    BOOL isValueARESTURL;
}

@property (nonatomic, retain) NSURL *URL;
@property (nonatomic, assign, setter=setValue:) id value;
@property (nonatomic, readonly) MERESTAbstractModel *parentModel;

- (id) init;
- (id) initWithParentModel:(MERESTAbstractModel *) aParentModel;

- (void) setValue:(id)aValue;

- (void) loadOptions;
- (void) populate;


@end
