//
//  SirenViewController.m
//  Siren
//
//  Created by Meijie Wang on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SirenViewController.h"
#import "UserSearchInput.h"

@interface SirenViewController ()

@end

@implementation SirenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"who2Tab"]||[segue.identifier isEqualToString:@"where2Tab"]||[segue.identifier isEqualToString:@"when2Tab"])
	{
        UITabBarController * tabBarController = segue.destinationViewController;
        
        // who tab
        UINavigationController * navigationController = [[tabBarController viewControllers] objectAtIndex:0];
		WhoViewController 
        *whoViewController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		whoViewController.delegate = self;
        
        // where tab
        navigationController = [[tabBarController viewControllers] objectAtIndex:1];
        WhereViewController 
        *whereViewController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		whereViewController.delegate = self;
        
        // when tab
        navigationController = [[tabBarController viewControllers] objectAtIndex:2];
        WhenViewController 
        *whenViewController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		whenViewController.delegate = self;
	}
}

- (void)whoViewControllerDidCancel:
(WhoViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)whereViewControllerDidCancel:
(WhereViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)whenViewControllerDidCancel:
(WhenViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sportValueChanged:(id)sender {
    // Get user input
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    sharedAppStateInstance.sportFilter = sportFilterButton.on;
}
@end
