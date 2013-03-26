//
//  WhereViewController.h
//  Siren
//
//  Created by Meijie Wang on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"

@class WhereViewController;

@protocol WhereViewControllerDelegate <NSObject>
- (void)whereViewControllerDidCancel:
(WhereViewController *)controller;

@end

@interface WhereViewController : UIViewController <UITextFieldDelegate, ConfirmViewControllerDelegate> {
    IBOutlet UITextField * spotInputBox;
}

@property (nonatomic, weak) id <WhereViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)venueStartEditing:(id)sender;
- (IBAction)touchBackgroundWhereView:(id)sender;

@end
