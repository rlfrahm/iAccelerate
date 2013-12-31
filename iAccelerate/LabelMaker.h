//
//  LabelMaker.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/27/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelMaker : UILabel

@property (nonatomic) float x, y;

-(id)initWithFrame:(CGRect)frame andText:(NSString*)text andAngle:(float)angle withRadius:(float)radius;

@end
