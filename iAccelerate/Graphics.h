//
//  Graphics.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/31/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccelerationStaticGraphicsView.h"
#import "AccelerationRealtimeGraphicsView.h"
#import "AltimeterView.h"
#import "CompassView.h"

@interface Graphics : NSObject

@property (nonatomic) double accelGraphicsGees;

-(void)initMainDisplayGraphics:(UIView*)view;
-(void)updateMainDisplayGraphics:(UIView*)view;

@end
