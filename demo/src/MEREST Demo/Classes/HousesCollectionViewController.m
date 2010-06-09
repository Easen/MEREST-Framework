//
//  HousesCollectionViewController.m
//  MEREST Demo
//
//  Created by Marc Easen on 09/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HousesCollectionViewController.h"
#import "HouseResource.h"


@implementation HousesCollectionViewController

@synthesize model;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Houses";
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [model.arrayOfResources count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    HouseResource *item = [model.arrayOfResources objectAtIndex:indexPath.row];
    if (item.id == nil) {
        cell.textLabel.text = @"Loading...";
    } else {
        cell.textLabel.text = [item.id stringValue];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

#pragma mark -
#pragma mark Public methods

- (void) setModel:(HousesCollection *)aValue {
    [model release];
    if (aValue != nil) {
        model = [aValue retain];
        
        [arrayOfRestClientHouseResources release];
        [arrayOfRestRequestHouseResources release];
        
        arrayOfRestClientHouseResources = [[NSMutableArray alloc] initWithCapacity:[model.arrayOfResources count]];
        arrayOfRestRequestHouseResources = [[NSMutableArray alloc] initWithCapacity:[model.arrayOfResources count]];
        
        for (HouseResource *item in model.arrayOfResources) {
            MERESTClient *restClient = [[MERESTClient alloc] initWithBaseURL:model.parentModel.URL];
            MERESTRequest *restRequest = [[MERESTRequest alloc] initWithURL:item.URL
                                                                     method:MERESTRequestMethodGet];
            [restClient performRequest:restRequest withDelegate:self];
            
            [arrayOfRestClientHouseResources addObject:restClient];
            [arrayOfRestRequestHouseResources addObject:restRequest];
        }
    }
}

#pragma mark -
#pragma mark MERESTClientProtocol methods
- (void) meRESTClient:(MERESTClient *)client requestSuccessful:(MERESTRequest *)request
{
    NSInteger count = 0;
    for (HouseResource *item in model.arrayOfResources) {
        if ([item.URL isEqual:request.URL]) {
            [request.restResponse dataObjectUsingObject:item];
            break;
        }
        count++;
    }
    
    [arrayOfRestRequestHouseResources removeObject:request];
    [request release];
    [arrayOfRestClientHouseResources removeObject:client];
    [client release];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:count inSection:0]]
                                 withRowAnimation:UITableViewRowAnimationFade];
}

- (void) meRESTClient:(MERESTClient *)client requestFailed:(MERESTRequest *)request withError:(NSError *)error
{
    NSLog(@"failed request %@, error =  %@", request, error);
    
    [arrayOfRestRequestHouseResources removeObject:request];
    [request release];
    [arrayOfRestClientHouseResources removeObject:client];
    [client release];
}


@end

