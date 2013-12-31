//
//  AltimeterView.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/27/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "AltimeterView.h"
#import "LabelMaker.h"

#define RADIUS 60
#define ANGLE 36 //degrees

@implementation AltimeterView {
    CGContextRef ctx;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.altitude = 0;
    }
    return self;
}

-(void)drawCircleBacking {
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetRGBFillColor(ctx, 0.2, 0.2, 0.2, 1);
    
    CGPoint center = [self center];
    CGContextSaveGState(ctx);
    
    CGContextAddArc(ctx, center.x, center.y, RADIUS + 3, 0, M_PI*2, YES);
    CGContextFillPath(ctx);
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
    CGContextAddArc(ctx, center.x, center.y, 5, 0, M_PI*2, YES);
    CGContextFillPath(ctx);
    
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
    
    CGContextAddArc(ctx, center.x, center.y, RADIUS + 2, 0, M_PI*2, YES);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokePath(ctx);
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
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetStrokeColorWithColor(ctx,
                                     [UIColor whiteColor].CGColor);
    CGFloat dashArray[] = {3,32.75};
    CGContextSetLineDash(ctx, 19, dashArray, 2);
    CGContextAddArc(ctx, self.center.x, self.center.y, RADIUS-3, 0, M_PI*2, YES);
    CGContextStrokePath(ctx);
    
    CGContextSetLineWidth(ctx, 3.0);
    
    CGFloat dashArray2[] = {1,6.15};
    CGContextSetLineDash(ctx, -4, dashArray2, 2);
    CGContextAddArc(ctx, self.center.x, self.center.y, RADIUS-3, 0, M_PI*2, YES);
    CGContextStrokePath(ctx);
}

-(void)updateHundredHand:(float)hundreds {
    float angle = (360 * (hundreds/1000)) - 90;
    float radians = angle * (M_PI/180);
    float x = cosf(radians);
    float y = sinf(radians);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextSetLineWidth(ctx, 3.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(ctx, self.center.x, self.center.y);
    CGContextAddLineToPoint(ctx, self.center.x + x * RADIUS, self.center.y + y * RADIUS);
    CGContextStrokePath(ctx);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    ctx = UIGraphicsGetCurrentContext();
    //self.altitude = 24400;
    int thousands = (int)self.altitude/1000;
    float hundreds = self.altitude - (thousands * 1000);
    
    [self drawCircleBacking];
    [self drawTicks];
    self.altitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 25, self.center.y - 30, 50, 12)];
    [self.altitudeLabel setFont:[UIFont boldSystemFontOfSize:12]];
    self.altitudeLabel.textColor = [UIColor whiteColor];
    self.altitudeLabel.textAlignment = NSTextAlignmentCenter;
    //self.altitudeLabel.text = [NSString stringWithFormat:@"%.0f", self.altitude];
    [self addSubview:self.altitudeLabel];
    
    [self addLabels];
    
    [self updateHundredHand:hundreds];
}

@end
