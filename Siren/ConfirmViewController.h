//
//  ConfirmViewController.h
//  Siren
//
//  Created by Meijie Wang on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfirmViewController;
@protocol InputViewControllerDelegate <NSObject>
- (void)InputViewControllerDidCancel: (ConfirmViewController *)controller;
@end

@interface ConfirmViewController : UIViewController {
    IBOutlet UILabel *artistName;
    IBOutlet UILabel *venueAddress;
    IBOutlet UILabel *timeIntervel;
}

@property (nonatomic, strong) id <InputViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

@end
