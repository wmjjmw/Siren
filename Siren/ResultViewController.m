//
//  ResultViewController.m
//  Siren
//
//  Created by Meijie Wang on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "Result.h"
#import "JSON.h"
#import "UserSearchInput.h"
#import "SearchResultDetailViewController.h"

@interface ResultViewController ()

@property (nonatomic, strong) NSMutableArray *results;

@end

@implementation ResultViewController

@synthesize results = _results;
@synthesize responseData;
@synthesize delegate;

- (NSMutableArray *) results {
    if (_results == nil) {
        _results = [[NSMutableArray alloc] initWithObjects:nil];
    }
    return _results;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    // Get search result from stubhub.com
    self.responseData = [NSMutableData data];
    // Get user input
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    
    // Array to store user input
    NSMutableArray *userInputs =  [[NSMutableArray alloc] init];
    
    // Format user input
    // If there is artist name
    if ([[sharedAppStateInstance artistName] isEqualToString:@""] == NO) {
        NSString *formatedArtistName = [sharedAppStateInstance.artistName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        formatedArtistName = [@"act_primary:%22" stringByAppendingString:formatedArtistName];
        formatedArtistName = [formatedArtistName stringByAppendingString:@"%22"];
        [userInputs addObject:formatedArtistName];
    }
    // If there is concertVenue
    if ([[sharedAppStateInstance concertVenue] isEqualToString:@""] == NO) {
        NSString *formatedConcertVenue = [sharedAppStateInstance.concertVenue stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        formatedConcertVenue = [@"city:" stringByAppendingString:formatedConcertVenue];
        [userInputs addObject:formatedConcertVenue];
    }
    // Concert time
    NSString *formatedIntervelFromDate = [sharedAppStateInstance intervelFromTime];
    NSString *formatedIntervelToDate = [sharedAppStateInstance intervelToTime];
    if ([formatedIntervelFromDate isEqualToString:@""]&& [formatedIntervelToDate isEqualToString:@""]){}
    else if ([formatedIntervelFromDate isEqualToString:@""]) {
        formatedIntervelFromDate = @"NOW";
        formatedIntervelToDate = [formatedIntervelToDate stringByAppendingString:@"T24:59:59.999Z"];
    }
    else if ([formatedIntervelToDate isEqualToString:@""]) {
        formatedIntervelFromDate = [formatedIntervelFromDate stringByAppendingString:@"T00:00:00.001Z"];
        formatedIntervelToDate = @"*";
    }
    else {
        formatedIntervelFromDate = [formatedIntervelFromDate stringByAppendingString:@"T00:00:00.001Z"];
        formatedIntervelToDate = [formatedIntervelToDate stringByAppendingString:@"T24:59:59.999Z"];
    }
    // If there is concert time
    if (![[sharedAppStateInstance intervelFromTime] isEqualToString:@""]||![[sharedAppStateInstance intervelToTime] isEqualToString:@""]) {
        NSString *formatedIntervel = @"event_date:%5B";
        formatedIntervel = [formatedIntervel stringByAppendingString:formatedIntervelFromDate];
        formatedIntervel = [formatedIntervel stringByAppendingString:@"%20TO%20"];
        formatedIntervel = [formatedIntervel stringByAppendingString:formatedIntervelToDate];
        formatedIntervel = [formatedIntervel stringByAppendingString:@"%5D"];
        [userInputs addObject:formatedIntervel];
    }
    
    // Number of user input
    NSInteger userInputNum = [userInputs count];
    
    // Construct url string based on user's input
    NSString *urlString = [[NSString alloc] initWithString:@"http://publicfeed.stubhub.com/listingCatalog/select/?q=%252BstubhubDocumentType%253Aticket%250D%250A%252B%2Bleaf%253A%2Btrue%250D%250A%252B"];
    if (userInputNum >= 1) {
        urlString = [urlString stringByAppendingString:@"+"];
        urlString = [urlString stringByAppendingString:[userInputs objectAtIndex:0]];
    }
    if (userInputNum >= 2) {
        urlString = [urlString stringByAppendingString:@"&fq="];
        urlString = [urlString stringByAppendingString:[userInputs objectAtIndex:1]];
    }
    if (userInputNum >=3) {
        urlString = [urlString stringByAppendingString:@"&fq="];
        urlString = [urlString stringByAppendingString:[userInputs objectAtIndex:2]];
    }
    
    // If user add sport filter
    if (sharedAppStateInstance.sportFilter == NO) {
        urlString = [urlString stringByAppendingString:@"&fq=channel:%22Concert%20tickets%22"];
    }
    
    urlString = [urlString stringByAppendingString:@"&version=2.2&start=0&rows=50&indent=on&wt=json&fl=description+event_date+event_date_local+event_time_local+venue_name+city+state+genreUrlPath+urlpath+leaf+act_primary+channel"];
    
    // Make url request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([self.results count] <= 50) {
        return [self.results count];
    }
    else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:@"ResultCell"];
	Result *result = [self.results objectAtIndex:indexPath.row];
	UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
	nameLabel.text = result.name;
	UILabel *placeLabel = (UILabel *)[cell viewWithTag:101];
	placeLabel.text = result.place;
	UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
    timeLabel.text = result.time;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.results removeAllObjects];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	self.responseData = nil;
    
    NSDictionary * response = [(NSDictionary*)[responseString JSONValue] objectForKey:@"response"];
    
    // Number of search result
    NSNumber* numFound = [response objectForKey:@"numFound"];
    int numFoundInt = [numFound intValue];
    // Truncate result num into range of 50
    if (numFoundInt > 50) {
        numFoundInt = 50;
    }
    NSArray *searchresults = [response objectForKey:@"docs"];
    
    // If there is no result fit for the requirments
    if (numFoundInt == 0) {
        Result *firstR = [[Result alloc] init];
        [firstR setName: [[NSString alloc] initWithString:@"No concert found!"]];
        [self.results addObject:firstR];

    }
    
    // Loop over all the results found on stubhub.com
    NSDictionary *firstResult;
    for (int i = 0; i < numFoundInt; i++) {        
        firstResult = [searchresults objectAtIndex:i];
        // If the result item is empty
        if ([firstResult valueForKey:@"act_primary"] == nil) {
            continue;
        }
        
        // else
        Result *firstR = [[Result alloc] init];
        [firstR setPlace: [[NSString alloc] initWithFormat:@"%@, %@",[firstResult valueForKey:@"venue_name"], [firstResult valueForKey:@"city"]]];
        [firstR setName: [firstResult valueForKey:@"act_primary"]];
        [firstR setTime: [firstResult valueForKey:@"event_date_local"]];
        [self.results addObject:firstR];
    }
    
    // Redisplay the result screen
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"SearchParameter"])
	{
		UINavigationController *navigationController = 
        segue.destinationViewController;
		ConfirmViewController 
        *confirmViewController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		confirmViewController.delegate = self;
	}
    else {
        SearchResultDetailViewController *detailController =segue.destinationViewController;
        Result *searchResult = [self.results objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        detailController.detailItem = searchResult;
    }
}

- (void)InputViewControllerDidCancel:
(ConfirmViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender
{
	[self.delegate confirmViewControllerDidCancel:self];
}

@end
