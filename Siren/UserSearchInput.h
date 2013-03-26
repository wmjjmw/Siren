//
//  UserSearchInput.h
//  Siren
//
//  Created by Meijie Wang on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSearchInput : NSObject {
    NSString * artistName;
    NSString * concertVenue;
    NSString * intervelFromTime;
    NSString * intervelToTime;
    NSMutableArray * favoriteArtist;
    NSMutableArray * favoriteVenue;
}
@property (nonatomic, retain) NSString * artistName;
@property (nonatomic, retain) NSString * concertVenue;
@property (nonatomic, retain) NSString * intervelFromTime;
@property (nonatomic, retain) NSString * intervelToTime;
@property (nonatomic, strong) NSMutableArray * favoriteArtist;
@property (nonatomic, strong) NSMutableArray * favoriteVenue;
@property (nonatomic) BOOL sportFilter;

+ (UserSearchInput*) sharedAppStateInstance;
@end
