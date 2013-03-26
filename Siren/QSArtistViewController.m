//
//  QSArtistViewController.m
//  Siren
//
//  Created by Meijie Wang on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QSArtistViewController.h"
#import "UserSearchInput.h"
#import "Result.h"
#import "JSON.h"
#import "SearchResultDetailViewController.h"

@interface QSArtistViewController () {
    NSMutableArray * listOfItems;
}

@end

@implementation QSArtistViewController

@synthesize responseData;

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
    
    //Initialize the array.
    listOfItems = [[NSMutableArray alloc] init];
    Result *firstR = [[Result alloc] init];
    [firstR setPlace: @""];
    [firstR setName: @"Loading..."];
    [firstR setTime: @""];
    NSArray *countriesToLiveInArray = [[NSArray alloc] initWithObjects:firstR, nil];
    
    NSArray *countriesLivedInArray = [[NSArray alloc] initWithObjects:firstR, nil];
    
    [listOfItems addObject:countriesToLiveInArray];
    [listOfItems addObject:countriesLivedInArray];
}


- (void)viewWillAppear:(BOOL)animated {
    // Get search result from stubhub.com
    self.responseData = [NSMutableData data];
    // Get user input
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    // Array to store user favorite artists
    NSMutableArray *userFavoriteArtists =  [sharedAppStateInstance favoriteArtist];
    
    // Construct url string based on user's input
    NSString *urlString = [[NSString alloc] initWithString:@"http://publicfeed.stubhub.com/listingCatalog/select/?q=%252BstubhubDocumentType%253Aticket%250D%250A%252B%2Bleaf%253A%2Btrue%250D%250A%252B"];
    urlString = [urlString stringByAppendingString:@"+channel:%22Concert%20tickets%22"];        
    
    for (int i = 0; i < [userFavoriteArtists count]; i++) {
        NSString * currentArtist = [userFavoriteArtists objectAtIndex:i];
        NSString *formatedArtistName = [currentArtist stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        formatedArtistName = [@"act_primary:%22" stringByAppendingString:formatedArtistName];
        formatedArtistName = [formatedArtistName stringByAppendingString:@"%22"];
        urlString = [urlString stringByAppendingString:@"+"];
        urlString = [urlString stringByAppendingString:formatedArtistName];

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
    return [listOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *array = [listOfItems objectAtIndex:section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:@"resultCellQSAritist"];    
    // Set up the cell...    
    NSArray *array = [listOfItems objectAtIndex:indexPath.section];
    Result *searchResult = [array objectAtIndex:indexPath.row];

    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    nameLabel.text = searchResult.name;
    
    UILabel *placeLabel = (UILabel *)[cell viewWithTag:101];
    placeLabel.text = searchResult.place;
    
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
    timeLabel.text = searchResult.time;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"My favorite artists";
    else
        return @"All artists";
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
    NSMutableArray *myArtistResult = [[NSMutableArray alloc] init];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
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
        [myArtistResult addObject:firstR];
        
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
        [myArtistResult addObject:firstR];
    }

    [listOfItems replaceObjectAtIndex:0 withObject:myArtistResult];
    
    // Redisplay the result screen
    [self.tableView reloadData];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchResultDetailViewController *detailController =segue.destinationViewController;
    NSArray *array = [listOfItems objectAtIndex:self.tableView.indexPathForSelectedRow.section];
    Result *searchResult = [array objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailController.detailItem = searchResult;
}

@end
