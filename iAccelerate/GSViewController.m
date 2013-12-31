//
//  GSViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/13/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "GSViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "GSAppDelegate.h"
#import "Gees.h"
#import "CompassDetailViewController.h"

@interface GSViewController ()
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property SettingsHelper* settingsHelper;
@end

@implementation GSViewController {
    NSMutableArray* _geesMutableArray;
    CLLocationManager* _locationManager;
    UIView* compassView;
    NSUInteger* viewIndex;
    CGPoint oldTranslation;
    CGFloat magnitude;
    CGFloat pos;
    double mean, oldGees;
    NSDate* start, *stop;
    NSUserDefaults* defaults;
    BOOL isVisible;
}

@synthesize settingsHelper, location, accelGraphics, accelPlot;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isVisible = YES;
    
    defaults = [NSUserDefaults standardUserDefaults];
    //accelGraphics = [[AccelerationGraphicsView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height/2)];
    //[self.view addSubview:accelGraphics];
    
    self.image = [UIImage imageNamed:@"background.jpg"];
    self.imageView.image = [self.image applyLightEffect];
    [self.view sendSubviewToBack:self.imageView];
    
    UIButton* compassButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 90, self.view.bounds.size.height - 80, 80, 24)];
    [compassButton setTitle:@"Compass" forState:UIControlStateNormal];
    [compassButton addTarget:self action:@selector(compassButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:compassButton];
    
    [self setupLocationUpdates];
    
    _geesMutableArray = [[NSMutableArray alloc] init];
    self.motionManager = [[CMMotionManager alloc] init];
    if([self.motionManager isAccelerometerAvailable]) {
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _geesMutableArray[0] = [NSNumber numberWithDouble:accelerometerData.acceleration.x];
                _geesMutableArray[1] = [NSNumber numberWithDouble:accelerometerData.acceleration.y];
                _geesMutableArray[2] = [NSNumber numberWithDouble:accelerometerData.acceleration.z];
                if(isVisible) {
                    //self.xAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.x];
                    //self.yAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.y];
                    //self.zAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.z];
                    [self drawLinesWithData:_geesMutableArray];
                }
                
                [self addEntry:_geesMutableArray];
            });
        }];
    } else {
        NSLog(@"Not active");
    }
    
    compassView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    [compassView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:compassView];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    GSAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    accelGraphics.backgroundColor = [UIColor clearColor];
    accelPlot.backgroundColor = [UIColor clearColor];
    [accelPlot startUp];
}

- (void) viewWillAppear:(BOOL)animated {
    isVisible = YES;
    self.motionManager.accelerometerUpdateInterval = [defaults doubleForKey:@"accel_update_interval"];
    [self startStandardUpdates];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self stopStandardUpdates];
}

- (void) viewDidDisappear:(BOOL)animated {
    isVisible = NO;
}

- (void) addEntry:(NSMutableArray*)entry {
    double x = [entry[0] doubleValue];
    double y = [entry[1] doubleValue];
    double z = [entry[2] doubleValue];
    double g = sqrt(x*x + y*y + z*z);
    double duration = 0;
    
    accelPlot.point = g;
    
    if(!mean) {
        mean = g;
        start = [NSDate date];
    } else if(g > mean * 0.95 && g < mean * 1.05) {
        
    } else {
        Gees* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Gees" inManagedObjectContext:self.managedObjectContext];
        stop = [NSDate date];
        duration = (double)[stop timeIntervalSinceDate:start];
        mean = g;
        
        newEntry.gees = [NSNumber numberWithDouble:oldGees];
        newEntry.time = [NSDate date];
        newEntry.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        newEntry.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
        newEntry.duration = [NSNumber numberWithDouble:duration];
        start = [NSDate date];
    }
    
    accelGraphics.gees = g;
    self.geesLabel.text = [NSString stringWithFormat:@"%.3f G's", g];
    oldGees = mean;
}

- (void) drawLinesWithData:(NSMutableArray*)mutableArray {
    CGFloat width = fabs([[mutableArray objectAtIndex:0] floatValue]);
    CGFloat height = fabs([[mutableArray objectAtIndex:1] floatValue]);
    //CGRect rect = CGRectMake((winSize.width/2) - (width/2), (winSize.height/2) - (height/2), width, height);
    //NSLog(@"%f", [[mutableArray objectAtIndex:0] floatValue]);
    
    accelGraphics.width = width * 10000;
    accelGraphics.height = height * 10000;
    [accelGraphics updateGraphics:CGRectMake(0, 0, 100, 100)];
    [accelPlot drawRect:self.view.frame];
    [accelPlot setNeedsDisplay];
    [accelGraphics setNeedsDisplay];
}

#pragma mark Location Stuff

- (void) setupLocationUpdates {
    // Create the location manager if this object does not already have one
    if(_locationManager == Nil) self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    
    [self setLocationAccuracy];
    
    // Set movement threshold for new events
    self.locationManager.distanceFilter = 500; // meters
}

- (void) startStandardUpdates {
    [self.locationManager startUpdatingLocation];
}

- (void) stopStandardUpdates {
    [self.locationManager stopUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    //self.latLabel.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    //self.longLabel.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    //self.altLabel.text = [NSString stringWithFormat:@"%f", self.location.altitude];
    //self.haccLabel.text = [NSString stringWithFormat:@"%f", self.location.horizontalAccuracy];
    //self.vaccLabel.text = [NSString stringWithFormat:@"%f", self.location.verticalAccuracy];
    //self.speedLabel.text = [NSString stringWithFormat:@"%f", self.location.speed];
    //self.courseLabel.text = [NSString stringWithFormat:@"%f", self.location.course];
}

-(void)setLocationAccuracy {
    int la = (int)[defaults integerForKey:@"location_accuracy"];
    switch (la) {
        case 0:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            break;
        case 1:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            break;
        case 2:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            break;
        case 3:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            break;
        case 4:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            break;
        case 5:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            break;
        default:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            break;
    }
}
                                           
#pragma mark UI Actions

-(void)compassButtonTouched {
    CompassDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"compassdetail"];
    detail.returnToMainView = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
                                           
-(void)handlePanGesture:(UIPanGestureRecognizer*)recognizer {
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        pos = compassView.frame.origin.x;
    }
    if(recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint velocity = [recognizer velocityInView:self.view];
        magnitude = sqrtf((velocity.x*velocity.x)+(velocity.y*velocity.y));
        CGFloat diff = translation.x - oldTranslation.x;
        //NSLog(@"%f", compassView.frame.origin.x);
        //NSLog(@"%f", diff);
        [compassView setFrame:CGRectMake(compassView.frame.origin.x + diff, compassView.frame.origin.y, compassView.frame.size.width, compassView.frame.size.height)];
        
        if(oldTranslation.x - translation.x > 0) {
            // Panning left
            viewIndex = 0;
            //[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateViewToTheLeft:) userInfo:Nil repeats:YES];
        } else if(oldTranslation.x - translation.x < 0){
            // Panning right
            //[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateViewToTheRight:) userInfo:Nil repeats:YES];
        }
        oldTranslation = translation;
    } else if(recognizer.state == UIGestureRecognizerStateEnded) {
        if(compassView.frame.origin.x < self.view.frame.size.width/2) {
            // Snap open
            CGPoint velocity = [recognizer velocityInView:self.view];
            magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
            
            float slideFactor = 0.1 * slideMult; // Increase for more of a slide
            CGPoint finalPoint = CGPointMake(self.view.center.x,
                                             compassView.center.y);
            finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
            finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
            [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                compassView.center = finalPoint;
            } completion:nil];
        } else {
            // Snap closed
            CGPoint velocity = [recognizer velocityInView:self.view];
            magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
            
            float slideFactor = 0.1 * slideMult; // Increase for more of a slide
            CGPoint finalPoint = CGPointMake(self.view.frame.size.width + (compassView.bounds.size.width/2),
                                             compassView.center.y);
            //finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
            //finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
            [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                compassView.center = finalPoint;
            } completion:nil];
        }
    }
}

-(void)updateViewToTheLeft:(NSTimer*)timer {
    if(viewIndex == 0) {
        // If the active view is the compassView
        if(compassView.frame.origin.x > 0) {
            [compassView setFrame:CGRectMake(compassView.frame.origin.x - 10, compassView.frame.origin.y, compassView.frame.size.width, compassView.frame.size.height)];
        } else {
            [timer invalidate];
        }
    } else {
        // If the active view is the altimeter
    }
}
                                           
-(void)updateViewToTheRight:(NSTimer*)timer {
    if(viewIndex == 0) {
        if(compassView.frame.origin.x < self.view.bounds.size.width) {
            [compassView setFrame:CGRectMake(compassView.frame.origin.x + 10, compassView.frame.origin.y, compassView.frame.size.width, compassView.frame.size.height)];
        } else {
            [timer invalidate];
        }
    } else {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
