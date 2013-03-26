//
//  WhoViewController.h
//  Siren
//
//  Created by Meijie Wang on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"

@class WhoViewController;

@protocol WhoViewControllerDelegate <NSObject>
- (void)whoViewControllerDidCancel:
(WhoViewController *)controller;

@end

@interface WhoViewController : UIViewController <UITextFieldDelegate, ConfirmViewControllerDelegate> {        
    IBOutlet UITextField * artistInputBox;
}
@property (nonatomic, weak) id <WhoViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)startEditingArtist:(id)sender;
- (IBAction)touchUpInsideArtist:(id)sender;

@end
