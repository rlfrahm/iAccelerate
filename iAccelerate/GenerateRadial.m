//
//  GenerateRadial.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/18/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "GenerateRadial.h"

@implementation GenerateRadial

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.contents = (__bridge id)([[self generateRadial]CGImage]);
        self.opaque = NO;
    }
    return self;
}

-(UIImage*)generateRadial {
    // Define the gradient
    CGGradientRef gradient;
    CGColorSpaceRef colorSpace;
    size_t locations_num = 5;
    CGFloat locations[5] = {0.0,0.4,0.5,0.6,1.0};
    CGFloat components[20] = { 1.0, 0.0, 0.0, 0.2,
                               1.0, 0.0, 0.0, 1,
                               1.0, 0.0, 0.0, 0.8,
                               1.0, 0.0, 0.0, 0.4,
                               1.0, 0.0, 0.0, 0.0
    };
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locations_num);
    
    // Define gradient positions
    CGPoint startPoint, endPoint;
    startPoint.x = self.frame.size.width/2;
    startPoint.y = self.frame.size.height/2;
    endPoint.x = self.frame.size.width/2;
    endPoint.y = self.frame.size.height/2;
    
    // Generate the image
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(imageContext, gradient, startPoint, 0, endPoint, self.frame.size.width/2, 0);
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
