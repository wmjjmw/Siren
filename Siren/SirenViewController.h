//
//  SirenViewController.h
//  Siren
//
//  Created by Meijie Wang on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhoViewController.h"
#import "WhereViewController.h"
#import "WhenViewController.h"

@interface SirenViewController : UIViewController<WhoViewControllerDelegate,WhereViewControllerDelegate, WhenViewControllerDelegate> {
    IBOutlet UISwitch * sportFilterButton;
}

- (IBAction)sportValueChanged:(id)sender;

@end