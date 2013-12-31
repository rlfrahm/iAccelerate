//
//  ScatterPlotViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/15/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "ScatterPlotViewController.h"
#import "GSAppDelegate.h"
#import "Gees.h"

@interface ScatterPlotViewController ()

@end

@implementation ScatterPlotViewController

@synthesize hostView = _hostView;

#pragma mark - UIViewController lifecycle methods
- (void) viewDidAppear:(BOOL)animated {
    GSAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.geeRecords = [NSArray arrayWithArray:[appDelegate getAllGeeRecords]];
    [super viewDidAppear:animated];
    [self initPlot];
}

#pragma mark - Chart behavior
- (void) initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    //[self configureAxes];
}

- (void) configureHost {
    self.hostView = [(CPTGraphHostingView*) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    self.hostView.allowPinchScaling = YES;
    [self.view addSubview:self.hostView];
}

- (void) configureGraph {
    CPTGraph* graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTSlateTheme]];
    self.hostView.hostedGraph = graph;
    
    NSString* title = @"G Forces Over Time";
    graph.title = title;
    
    CPTMutableTextStyle* titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 0.0f);
    
    [graph.plotAreaFrame setPaddingLeft:30.0f];
    [graph.plotAreaFrame setPaddingBottom:30.0f];
    
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
}

- (void) configurePlots {
    CPTGraph* graph = self.hostView.hostedGraph;
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*) graph.defaultPlotSpace;
    
    CPTScatterPlot* geePlot = [[CPTScatterPlot alloc] init];
    geePlot.dataSource = self;
    geePlot.identifier = @"Gee's";
    CPTColor* geeColor = [CPTColor redColor];
    [graph addPlot:geePlot toPlotSpace:plotSpace];
    
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:geePlot, nil]];
    CPTMutablePlotRange* xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange* yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    
    CPTMutableLineStyle* geeLineStyle = [geePlot.dataLineStyle mutableCopy];
    geeLineStyle.lineWidth = 2.5;
    geeLineStyle.lineColor = geeColor;
    geePlot.dataLineStyle = geeLineStyle;
    CPTMutableLineStyle* geeSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    geeSymbolLineStyle.lineColor = geeColor;
    CPTPlotSymbol* geeSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    geeSymbol.fill = [CPTFill fillWithColor:geeColor];
    geeSymbol.lineStyle = geeSymbolLineStyle;
    geeSymbol.size = CGSizeMake(6.0f, 6.0f);
    geePlot.plotSymbol = geeSymbol;
}

- (void) configureAxes {
    CPTMutableTextStyle* axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle* axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    CPTMutableTextStyle* axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    CPTMutableLineStyle* tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle* gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    
    CPTXYAxisSet* axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    CPTAxis* x = axisSet.xAxis;
    x.title = @"Time";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    // Incomplete
    // http://www.raywenderlich.com/13271/how-to-draw-graphs-with-core-plot-part-2
}

#pragma mark - CPTPlotDataSource methods
- (NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot {
    GSAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate getGeesRecordCount];
}

- (NSNumber *) numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
    GSAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    NSInteger valueCount = [appDelegate getGeesRecordCount];
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if(idx < valueCount) {
                return [NSNumber numberWithUnsignedInteger:idx];
            }
            break;
        case CPTScatterPlotFieldY:
            if([plot.identifier isEqual:@"Gee's"] == YES) {
                Gees* gees = [self.geeRecords objectAtIndex:idx];
                return gees.gees;
            }
            break;
    }
    return [NSDecimalNumber zero];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
