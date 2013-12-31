//
//  Graphics.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/31/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "Graphics.h"

@implementation Graphics {
    AccelerationStaticGraphicsView* accelStaticGraphicsView;
    AccelerationRealtimeGraphicsView* accelRealtimeGraphicsView;
}

-(void)initMainDisplayGraphics:(UIView *)view {
    accelStaticGraphicsView = [[AccelerationStaticGraphicsView alloc] initWithFrame:view.frame];
    [view addSubview:accelStaticGraphicsView];
    //[accelStaticGraphicsView drawRect:view.frame];
    
    accelRealtimeGraphicsView = [[AccelerationRealtimeGraphicsView alloc] initWithFrame:view.frame];
    [view addSubview:accelRealtimeGraphicsView];
}

-(void)updateMainDisplayGraphics:(UIView *)view {
    accelRealtimeGraphicsView.gees = self.accelGraphicsGees;
    accelRealtimeGraphicsView.geesLabel.text = [NSString stringWithFormat:@"%.2f", self.accelGraphicsGees];
    [accelRealtimeGraphicsView drawRect:view.frame];
    [accelRealtimeGraphicsView setNeedsDisplay];
}

@end
