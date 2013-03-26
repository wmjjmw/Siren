//
//  CoolButton.m
//  Siren
//
//  Created by Meijie Wang on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoolButton.h"

@implementation CoolButton

// Under @implementation
@synthesize hue = _hue;
@synthesize saturation = _saturation;
@synthesize brightness = _brightness;

// Delete initWithFrame and add the following:
-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 1.0;
        _saturation = 1.0;
        _brightness = 1.0;
    }
    return self;
}

// Uncomment drawRect and replace the contents with:


// Add to the bottom of the file
- (void)setHue:(CGFloat)hue {
    _hue = hue;
    [self setNeedsDisplay];
}

- (void)setSaturation:(CGFloat)saturation {
    _saturation = saturation;
    [self setNeedsDisplay];
}

- (void)setBrightness:(CGFloat)brightness {
    _brightness = brightness;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 CGContextRef context = UIGraphicsGetCurrentContext();
 
 CGColorRef color = [UIColor colorWithHue:_hue saturation:_saturation 
 brightness:_brightness alpha:1.0].CGColor;
 
 CGContextSetFillColorWithColor(context, color);
 CGContextFillRect(context, self.bounds);
}


@end
