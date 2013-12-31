//
//  AccelerationRealtimePlotView.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/30/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "AccelerationRealtimeGraphicsView.h"

#define POINT_RADIUS 4
#define RADIUS 100

@implementation AccelerationRealtimeGraphicsView {
    NSMutableArray* plotPoints;
    CGContextRef ctx;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        plotPoints = [[NSMutableArray alloc] initWithCapacity:20];
        UILabel* onegeelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.center.y - 10, 24, 12)];
        [self addSubview:onegeelabel];
        self.backgroundColor = [UIColor clearColor];
        self.geesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 25, self.center.y - 50, 50, 24)];
        [self.geesLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]];
        self.geesLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.geesLabel];
    }
    return self;
}

-(void)drawHand {
    float angle = (360 * (self.gees/10)) - 90;
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
    
    [self drawHand];
    //self.geesLabel.text = [NSString stringWithFormat:@"%.2f", self.gees];
    
    if(plotPoints.count >= 20) {
        [plotPoints removeLastObject];
    }
    [plotPoints insertObject:[NSNumber numberWithDouble:self.gees] atIndex:0];
    
    //CGContextSetLineWidth(ctx, 1.0);
    //CGContextSetRGBStrokeColor(ctx, 0, 0.608, 0.584, 0.4);
    
    for(int i=0; i<[plotPoints count]; i++) {
        /*if(i<9) {
            CGContextMoveToPoint(ctx, 10, self.center.y - ((i+1)*10));
            CGContextAddLineToPoint(ctx, 100, self.center.y - ((i+1)*10));
            CGContextStrokePath(ctx);
        }//*/
        if(!i==0) {
            CGContextSetRGBFillColor(ctx, 1, 0.584, 0.251, 0.4);
        } else {
            CGContextSetRGBFillColor(ctx, 1, 0.584, 0.251, 1.0);
        }
        CGContextAddArc(ctx, self.center.x - (i*7), 120 - ([[plotPoints objectAtIndex:i] doubleValue] * 15), POINT_RADIUS, 0, M_PI*2, YES);
        CGContextFillPath(ctx);
    }
}

@end
