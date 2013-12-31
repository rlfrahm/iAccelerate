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

#import "AccelerationStaticGraphicsView.h"
#import "LabelMaker.h"

#define BUGGATTI_VEYRON_Gs 1.18
#define SPACE_SHUTTLE_Gs   3
#define FORMULA_ONE_CAR_Gs 5
#define APOLLO_16          7.19
#define HIGH_G_TURN_Gs     9
#define MULTIPLIER         15
#define RADIUS 100
#define ANGLE 36 //degrees

@implementation AccelerationStaticGraphicsView {
    CGContextRef context;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)updateGraphics:(CGRect)rect {
    [self drawRect:rect];
}

-(void)drawCircleBacking {
    CGContextSetLineWidth(context, 0.5);
    CGContextSetRGBFillColor(context, 0.2, 0.2, 0.2, 1);
    
    CGPoint center = [self center];
    CGContextSaveGState(context);
    
    CGContextAddArc(context, center.x, center.y, RADIUS + 3, 0, M_PI*2, YES);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextAddArc(context, center.x, center.y, 5, 0, M_PI*2, YES);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    
    CGContextAddArc(context, center.x, center.y, RADIUS + 2, 0, M_PI*2, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokePath(context);
}

-(void)addLabels {
    float r = RADIUS*0.8;
    LabelMaker* lb0 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"0" andAngle:90*(M_PI/180) withRadius:r];
    [self addSubview:lb0];
    LabelMaker* lb1 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"1" andAngle:(90-ANGLE)*(M_PI/180) withRadius:r];
    [self addSubview:lb1];
    LabelMaker* lb2 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"2" andAngle:(90-ANGLE*2)*(M_PI/180) withRadius:r];
    [self addSubview:lb2];
    LabelMaker* lb3 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"3" andAngle:(90-ANGLE*3)*(M_PI/180) withRadius:r];
    [self addSubview:lb3];
    LabelMaker* lb4 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"4" andAngle:(90-ANGLE*4)*(M_PI/180) withRadius:r];
    [self addSubview:lb4];
    LabelMaker* lb5 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"5" andAngle:(90-ANGLE*5)*(M_PI/180) withRadius:r];
    [self addSubview:lb5];
    LabelMaker* lb6 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"6" andAngle:(90-ANGLE*6)*(M_PI/180) withRadius:r];
    [self addSubview:lb6];
    LabelMaker* lb7 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"7" andAngle:(90-ANGLE*7)*(M_PI/180) withRadius:r];
    [self addSubview:lb7];
    LabelMaker* lb8 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"8" andAngle:(90-ANGLE*8)*(M_PI/180) withRadius:r];
    [self addSubview:lb8];
    LabelMaker* lb9 = [[LabelMaker alloc] initWithFrame:CGRectMake(self.center.x - 6, self.center.y - 6, 12, 12) andText:@"9" andAngle:(90-ANGLE*9)*(M_PI/180) withRadius:r];
    [self addSubview:lb9];
}

-(void)drawTicks {
    CGContextSetLineWidth(context, 5.0);
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor whiteColor].CGColor);
    CGFloat dashArray[] = {3,32.75};
    CGContextSetLineDash(context, 19, dashArray, 2);
    CGContextAddArc(context, self.center.x, self.center.y, RADIUS-3, 0, M_PI*2, YES);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 3.0);
    
    CGFloat dashArray2[] = {1,6.15};
    CGContextSetLineDash(context, -4, dashArray2, 2);
    CGContextAddArc(context, self.center.x, self.center.y, RADIUS-3, 0, M_PI*2, YES);
    CGContextStrokePath(context);
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
    NSLog(@"%f",self.center.y);
    return CGRectMake(self.center.x-((value*MULTIPLIER)/2), self.center.y-((value*MULTIPLIER)/2), value*MULTIPLIER, value*MULTIPLIER);
}

- (void)drawRect:(CGRect)rect
{
    context = UIGraphicsGetCurrentContext();
    //[self drawCommonGforceLines];
    [self drawCircleBacking];
    [self addLabels];
    [self drawTicks];
    
    /*CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(context, [self centeredSquareMaker:self.gees]);
    CGContextStrokePath(context);
     */
}

@end
