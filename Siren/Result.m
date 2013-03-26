//
//  Result.m
//  Siren
//
//  Created by Meijie Wang on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Result.h"

@implementation Result

@synthesize name = _name;
@synthesize place = _place;
@synthesize time = _time;

-(void)setName:(NSString *)name Place: (NSString *)place Time: (NSString *)time {
    _name = name;
    _place = place;
    _time = time;
}

@end
