//
//  MERESTAbstractModel.h
//  MEREST Demo
//
//  Created by Marc Easen on 03/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MERESTAbstractModel : NSObject {
    id value;
    MERESTAbstractModel *parentModel; 
    
}

@property (nonatomic, readonly) id value;
@property (nonatomic, readonly) MERESTAbstractModel *parentModel;

- (id) init;
- (id) initWithValue:(id)aValue;
- (id) initWithValue:(id)aValue ParentModel:(MERESTAbstractModel *) aParentModel;
- (void) populate;

@end
