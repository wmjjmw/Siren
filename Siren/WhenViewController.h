//
//  WhenViewController.h
//  Siren
//
//  Created by Meijie Wang on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"

@class WhenViewController;

@protocol WhenViewControllerDelegate <NSObject>
- (void)whenViewControllerDidCancel:
(WhenViewController *)controller;

@end

@interface WhenViewController : UIViewController<ConfirmViewControllerDelegate> { 
    IBOutlet UIDatePicker *fromDatePicker;
    IBOutlet UIDatePicker *toDatePicker;
}

@property (nonatomic, weak) id <WhenViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;

@end
