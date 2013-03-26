//
//  WhereViewController.m
//  Siren
//
//  Created by Meijie Wang on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WhereViewController.h"
#import "UserSearchInput.h"

@interface WhereViewController ()

@end

@implementation WhereViewController

@synthesize delegate;

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    // save input venue name
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    [sharedAppStateInstance setConcertVenue:[textField text]];
    NSLog(@"venue: %@",[textField text]);
    return YES;
}

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

- (void)confirmViewControllerDidCancel:
(ResultViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"StartSearchWhere"])
	{
		UINavigationController *navigationController = 
        segue.destinationViewController;
		ResultViewController 
        *confirmViewController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		confirmViewController.delegate = self;
	}
}

- (IBAction)cancel:(id)sender
{
	[self.delegate whereViewControllerDidCancel:self];
}

// Clear spot input box when user start editing
- (IBAction)venueStartEditing:(id)sender {
    spotInputBox.text = @"";
}

- (IBAction)touchBackgroundWhereView:(id)sender {
    [spotInputBox resignFirstResponder];
    // save input venue name
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    [sharedAppStateInstance setConcertVenue:[spotInputBox text]];
    NSLog(@"venue: %@",[spotInputBox text]);
}

@end
