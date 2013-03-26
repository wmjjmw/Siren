//
//  SearchResultDetailViewController.h
//  Siren
//
//  Created by Meijie Wang on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Result.h"

@interface SearchResultDetailViewController : UIViewController

@property (strong, nonatomic) Result * detailItem;
@property (strong, nonatomic) IBOutlet UILabel *artistName;
@property (strong, nonatomic) IBOutlet UILabel *venueName;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@end
