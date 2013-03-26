//
//  WhoViewController.m
//  Siren
//
//  Created by Meijie Wang on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WhoViewController.h"
#import "UserSearchInput.h"
#import "ResultViewController.h"

@interface WhoViewController ()

@end

@implementation WhoViewController

@synthesize delegate;

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    // save input artist name
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    [sharedAppStateInstance setArtistName:[textField text]];
    NSLog(@"Artist: %@",[textField text]);
    
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
   // [artistInputBox clearButtonMode:UITextFieldViewModeWhileEditing];
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
	if ([segue.identifier isEqualToString:@"StartSearch"])
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
	[self.delegate whoViewControllerDidCancel:self];
}

// Clear artist input box when user start editing
- (IBAction)startEditingArtist:(id)sender {
    artistInputBox.text = @"";
}

// dismiss keyboard when touch out of input box
- (IBAction)touchUpInsideArtist:(id)sender {
    [artistInputBox resignFirstResponder];
    // save input artist name
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    [sharedAppStateInstance setArtistName:[artistInputBox text]];
    NSLog(@"Artist: %@",[artistInputBox text]);
}

@end
