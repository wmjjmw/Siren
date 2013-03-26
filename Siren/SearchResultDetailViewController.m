//
//  SearchResultDetailViewController.m
//  Siren
//
//  Created by Meijie Wang on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchResultDetailViewController.h"

@interface SearchResultDetailViewController ()
- (void)configureView;
@end

@implementation SearchResultDetailViewController
@synthesize detailItem = _detailItem;
@synthesize artistName = _artistName;
@synthesize venueName = _venueName;
@synthesize startTime = _startTime;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        self.artistName.text = self.detailItem.name;
        self.venueName.text = self.detailItem.place;    
        self.startTime.text = self.detailItem.time;
    }
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
    [self configureView];
}

- (void)viewDidUnload
{
    [self setArtistName:nil];
    [self setVenueName:nil];
    [self setStartTime:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
