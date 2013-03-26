//
//  CoolButton.h
//  Siren
//
//  Created by Meijie Wang on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolButton : UIButton {
    CGFloat _hue;
    CGFloat _saturation;
    CGFloat _brightness;
}

@property (nonatomic) CGFloat hue;
@property (nonatomic) CGFloat saturation;
@property (nonatomic) CGFloat brightness;

@end
