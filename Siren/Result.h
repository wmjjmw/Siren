//
//  Result.h
//  Siren
//
//  Created by Meijie Wang on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *time;
-(void)setName:(NSString *)name Place: (NSString *)place Time: (NSString *)time;

@end
