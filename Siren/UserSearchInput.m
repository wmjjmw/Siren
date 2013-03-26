//
//  UserSearchInput.m
//  Siren
//
//  Created by Meijie Wang on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserSearchInput.h"

@implementation UserSearchInput
static UserSearchInput *sharedAppStateInstance = nil;

@synthesize artistName = _artistName;
@synthesize concertVenue = _concertVenue;
@synthesize intervelFromTime = _intervelFromTime;
@synthesize intervelToTime = _intervelToTime;
@synthesize sportFilter = _sportFilter;
@synthesize favoriteVenue = _favoriteVenue;
@synthesize favoriteArtist = _favoriteArtist;

/* ensure that only it is initialized only once */
+ (UserSearchInput*) sharedAppStateInstance {
    if (sharedAppStateInstance == nil) {
        sharedAppStateInstance = [[UserSearchInput alloc] init];
        sharedAppStateInstance.sportFilter = false;
    }
    return sharedAppStateInstance;
}

- (NSString *)artistName {
    if (_artistName == nil) {
        _artistName = [[NSString alloc]init];
    }
    return _artistName;
}

- (NSString *)concertVenue {
    if (_concertVenue == nil) {
        _concertVenue = [[NSString alloc]init];
    }
    return _concertVenue;
}

- (NSString *)intervelFromTime {
    if (_intervelFromTime == nil) {
        _intervelFromTime = [[NSString alloc]init];
    }
    return _intervelFromTime;
}

- (NSString *)intervelToTime {
    if (_intervelToTime == nil) {
        _intervelToTime = [[NSString alloc]init];
    }
    return _intervelToTime;
}

- (NSMutableArray *)favoriteArtist {
    if (_favoriteArtist == nil) {
        _favoriteArtist = [[NSMutableArray alloc] initWithObjects:@"Justin Bieber",@"Lady Gaga", nil];
    }
    return _favoriteArtist;
}

- (NSMutableArray *)favoriteVenue {
    if (_favoriteVenue == nil) {
        _favoriteVenue = [[NSMutableArray alloc] initWithObjects:@"Los Angeles",@"Chicago", nil];
    }
    return _favoriteVenue;
}

/* initialize the index and playlist array */
-init {
    if(self == [super init]) {
    }
    return self;
}

@end
