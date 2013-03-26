//
//  ConfirmViewController.m
//  Siren
//
//  Created by Meijie Wang on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConfirmViewController.h"
#import "UserSearchInput.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // display user input
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];  
    
    // no input, artist name
    if ([[sharedAppStateInstance artistName] isEqualToString:@""]) {
        artistName.text = @"No input";
        artistName.textColor = [UIColor redColor];
    }
    else {
        artistName.text = [sharedAppStateInstance artistName];
    }
    // venue address
    if ([[sharedAppStateInstance concertVenue] isEqualToString:@""]) {
        venueAddress.text = @"No input";
        venueAddress.textColor = [UIColor redColor];

    }
    else {
        venueAddress.text = [sharedAppStateInstance concertVenue];
    }
    // time intervel
    if ([[sharedAppStateInstance intervelFromTime] isEqualToString:@""] && [[sharedAppStateInstance intervelToTime] isEqualToString:@""]) {
        timeIntervel.text = @"No input";
        timeIntervel.textColor = [UIColor redColor];
    }
    else if ([[sharedAppStateInstance intervelFromTime] isEqualToString:@""]) {
        timeIntervel.text = [[NSString alloc] initWithFormat:@"Before %@", sharedAppStateInstance.intervelToTime];
    }
    else if ([[sharedAppStateInstance intervelToTime] isEqualToString:@""]) {
        timeIntervel.text = [[NSString alloc] initWithFormat:@"From %@", sharedAppStateInstance.intervelFromTime];
    }
    else {
        timeIntervel.text = [[NSString alloc] initWithFormat:@"From %@ To %@", sharedAppStateInstance.intervelFromTime, sharedAppStateInstance.intervelToTime];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender
{
	[self.delegate InputViewControllerDidCancel:self];
}

@end
