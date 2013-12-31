//
//  LabelMaker.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/27/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "LabelMaker.h"

@implementation LabelMaker

-(id)initWithFrame:(CGRect)frame andText:(NSString*)text andAngle:(float)angle withRadius:(float)radius {
    [self setPositionWithAngle:angle andRadius:radius];
    frame = CGRectMake(frame.origin.x + self.x, frame.origin.y - self.y, frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFont:[UIFont boldSystemFontOfSize:12]];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.text = text;
        [self setPositionWithAngle:angle andRadius:radius];
    }
    return self;
}

-(void)setPositionWithAngle:(float)angle andRadius:(float)radius{
    self.x = cosf(angle) * radius;
    self.y = sinf(angle) * radius;
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
