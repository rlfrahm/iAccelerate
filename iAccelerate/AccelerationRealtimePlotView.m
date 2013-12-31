//
//  AccelerationRealtimePlotView.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/30/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "AccelerationRealtimePlotView.h"

#define POINT_RADIUS 4

@implementation AccelerationRealtimePlotView {
    NSMutableArray* plotPoints;
    CGContextRef ctx;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) startUp {
    plotPoints = [[NSMutableArray alloc] initWithCapacity:20];
    UILabel* onegeelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.center.y - 10, 24, 12)];
    [self addSubview:onegeelabel];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(plotPoints.count >= 20) {
        [plotPoints removeLastObject];
    }
    [plotPoints insertObject:[NSNumber numberWithDouble:self.point] atIndex:0];
    ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetRGBStrokeColor(ctx, 0, 0.608, 0.584, 0.4);
    
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
        CGContextAddArc(ctx, self.center.x - (i*7), self.center.y - ([[plotPoints objectAtIndex:i] doubleValue] * 10), POINT_RADIUS, 0, M_PI*2, YES);
        CGContextFillPath(ctx);
    }
}

@end
