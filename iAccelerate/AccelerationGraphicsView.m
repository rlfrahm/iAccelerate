//
//  AccelerationGraphicsView.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/16/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//
//  Bugatti Veyron from 0 to 100 km/h in 2.4 s, has g force = 1.18 g
//  Space Shuttle, maximum during launch and reentry, g force =3 g
//  Formula One car, maximum under heavy braking, g forces = 5 g
//  Apollo 16 on reentry, g forces = 7.19 g
//  Max. turn in an aerobatic plane or fighter jet, g forces ranging from 9–12 g
//  http://www.gforces.net/a-discussion-on-typical-examples.html

#import "AccelerationGraphicsView.h"

#define BUGGATTI_VEYRON_Gs 1.18
#define SPACE_SHUTTLE_Gs   3
#define FORMULA_ONE_CAR_Gs 5
#define APOLLO_16          7.19
#define HIGH_G_TURN_Gs     9
#define MULTIPLIER         15

@implementation AccelerationGraphicsView {
    CGContextRef context;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)updateGraphics:(CGRect)rect {
    [self drawRect:rect];
}

-(void)drawCommonGforceLines {
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:BUGGATTI_VEYRON_Gs]);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:SPACE_SHUTTLE_Gs]);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:FORMULA_ONE_CAR_Gs]);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:APOLLO_16]);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:HIGH_G_TURN_Gs]);
    CGContextStrokePath(context);
}

-(CGRect)centeredSquareMaker:(float)value {
    return CGRectMake(self.center.x-((value*MULTIPLIER)/2), self.center.y-((value*MULTIPLIER)/2), value*MULTIPLIER, value*MULTIPLIER);
}

- (void)drawRect:(CGRect)rect
{
    context = UIGraphicsGetCurrentContext();
    [self drawCommonGforceLines];
    
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:self.gees]);
    CGContextStrokePath(context);
}

@end
