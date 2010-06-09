//
//  HousesCollectionViewController.h
//  MEREST Demo
//
//  Created by Marc Easen on 09/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEREST.h"
#import "HousesCollection.h"

@interface HousesCollectionViewController : UITableViewController <MERESTClientProtocol>{    
    NSMutableArray *arrayOfRestClientHouseResources;
    NSMutableArray *arrayOfRestRequestHouseResources;
    
    HousesCollection *model;
}

@property (nonatomic, assign, setter=setModel:) HousesCollection *model;

- (void) setModel:(HousesCollection *)aValue;

@end
