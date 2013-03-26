//
//  Entity.h
//  Siren
//
//  Created by Meijie Wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject{
    @private
}

@property (nonatomic, retain) NSString * artistName;
@property (nonatomic, retain) NSString * eventVenue;

@end
