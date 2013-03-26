//
//  ResultViewController.h
//  Siren
//
//  Created by Meijie Wang on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmViewController.h"

@class ResultViewController;
@protocol ConfirmViewControllerDelegate <NSObject>
- (void)confirmViewControllerDidCancel: (ResultViewController *)controller;
@end

@interface ResultViewController : UITableViewController <InputViewControllerDelegate> 

@property (retain, nonatomic) NSMutableData* responseData;

@property (nonatomic, strong) id <ConfirmViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

@end
