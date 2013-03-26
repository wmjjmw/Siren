//
//  WhenViewController.m
//  Siren
//
//  Created by Meijie Wang on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WhenViewController.h"
#import "UserSearchInput.h"

@interface WhenViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *ibscollView;

@end

@implementation WhenViewController
@synthesize ibscollView;
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
    // tell the scoll view how large its content is to be
    self.ibscollView.contentSize = CGSizeMake(320,552);
    
    // user can only choose date after current time
    fromDatePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    toDatePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    // add change action
    [fromDatePicker addTarget:self action:@selector(fromDateChanged:) forControlEvents:UIControlEventValueChanged];
    [toDatePicker addTarget:self action:@selector(toDateChanged:) forControlEvents:UIControlEventValueChanged];
}

/* handle date changes */
- (void) fromDateChanged:(id)sender{
    // set date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // format output from date and to date
    NSString *formattedFromDate = [dateFormatter stringFromDate:fromDatePicker.date];
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    [sharedAppStateInstance setIntervelFromTime:formattedFromDate];
}

- (void) toDateChanged:(id)sender{
    // set date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // format output from date and to date
    NSString *formattedToDate = [dateFormatter stringFromDate:toDatePicker.date];
    UserSearchInput* sharedAppStateInstance = [UserSearchInput sharedAppStateInstance];
    [sharedAppStateInstance setIntervelToTime:formattedToDate];
}

- (void)viewDidUnload
{
    [self setIbscollView:nil];
    fromDatePicker = nil;
    toDatePicker = nil;
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
	if ([segue.identifier isEqualToString:@"StartSearchWhen"])
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
	[self.delegate whenViewControllerDidCancel:self];
}

@end
