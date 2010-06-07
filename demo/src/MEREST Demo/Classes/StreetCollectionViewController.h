//
//  RootViewController.h
//  MEREST Demo
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright Marc Easen 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEREST.h"
#import "StreetCollection.h"

@interface StreetCollectionViewController : UITableViewController <MERESTClientProtocol>{
    MERESTClient *restClient;
    MERESTRequest *restRequestStreetCollection;
    
    NSMutableArray *arrayOfRestClientStreetResources;
    NSMutableArray *arrayOfRestRequestStreetResources;
    
    StreetCollection *model;
}

@end
