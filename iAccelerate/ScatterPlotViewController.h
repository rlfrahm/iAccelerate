//
//  ScatterPlotViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/15/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScatterPlotViewController : UIViewController <CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView* hostView;
@property (nonatomic, strong) NSArray* geeRecords;

@end
