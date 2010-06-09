//
//  RootViewController.m
//  MEREST Demo
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright Marc Easen 2010. All rights reserved.
//

#import "StreetCollectionViewController.h"
#import "MEREST.h"
#import "StreetResource.h"
#import "HousesCollectionViewController.h"

@implementation StreetCollectionViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    model = [StreetCollection sharedInstance];
    
    restClient = [[MERESTClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://rest-demo.local"]];
    
    
    restRequestStreetCollection = [[MERESTRequest alloc] initWithURL:[NSURL URLWithString:@"/street"]
                                                              method:MERESTRequestMethodGet];
    
    [restClient performRequest:restRequestStreetCollection withDelegate:self];
    
    self.title = @"Streets";
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (([model.arrayOfResources count] > 0) ? [model.arrayOfResources count] : 1);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
    if ([model.arrayOfResources count] == 0) {
        cell.textLabel.text = @"Loading...";
    } else {
        StreetResource *item = [model.arrayOfResources objectAtIndex:indexPath.row];
        if (item.name == nil) {
            cell.textLabel.text = @"Loading...";
        } else {
            cell.textLabel.text = item.name;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }        
    }

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([model.arrayOfResources count] < indexPath.row) {
        return;
    }
    
    StreetResource *item = [model.arrayOfResources objectAtIndex:indexPath.row];
    HousesCollectionViewController *housesCollectionViewCollection = [[HousesCollectionViewController alloc] initWithNibName:@"HousesCollectionViewController" bundle:nil];
    housesCollectionViewCollection.model = item.houses;
    [self.navigationController pushViewController:housesCollectionViewCollection animated:YES];
    [housesCollectionViewCollection release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark MERESTClientProtocol methods
- (void) meRESTClient:(MERESTClient *)client requestSuccessful:(MERESTRequest *)request
{
    if (request == restRequestStreetCollection) {
        [request.restResponse dataObjectUsingClass:[StreetCollection class]];
        
        // Create storage arrays
        arrayOfRestClientStreetResources = [[NSMutableArray arrayWithCapacity:[model.arrayOfResources count]] retain];
        arrayOfRestRequestStreetResources = [[NSMutableArray arrayWithCapacity:[model.arrayOfResources count]] retain];
        
        for (StreetResource *item in model.arrayOfResources) {
            MERESTRequest *restRequestStreetResource = [[[MERESTRequest alloc] initWithURL:item.URL method:MERESTRequestMethodGet] autorelease];
            MERESTClient *restClientStreetResource = [[[MERESTClient alloc] initWithBaseURL:item.parentModel.URL] autorelease];
            
            [restClientStreetResource performRequest:restRequestStreetResource withDelegate:self];
            
            [arrayOfRestClientStreetResources addObject:restClientStreetResource]; 
            [arrayOfRestRequestStreetResources addObject:restRequestStreetResource];
        }
        [self.tableView reloadData];
    } else if(arrayOfRestRequestStreetResources != nil && [arrayOfRestRequestStreetResources containsObject:request]) {
        NSUInteger index = [arrayOfRestRequestStreetResources indexOfObject:request];
        [request.restResponse dataObjectUsingObject:[model.arrayOfResources objectAtIndex:index]];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) meRESTClient:(MERESTClient *)client requestFailed:(MERESTRequest *)request withError:(NSError *)error
{
    NSLog(@"failed request %@, error =  %@", request, error);
}


@end

