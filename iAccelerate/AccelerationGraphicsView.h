//
//  AccelerationGraphicsView.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/16/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AccelerationGraphicsView : UIView

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat depth;

@property (nonatomic) CGFloat gees;

@property (nonatomic) BOOL firstTime;

-(void)updateGraphics:(CGRect)rect;

@end
