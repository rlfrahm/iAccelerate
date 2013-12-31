//
//  AltimeterDetailViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "AltimeterDetailViewController.h"
#import "AltimeterView.h"

#define METERS_TO_FEET 3.28084

@interface AltimeterDetailViewController () {
    NSString* unitOfMeasure;
    SettingsHelper* settingsHelper;
    AltimeterView* altimeter;
    NSUserDefaults* defaults;
}

@end

@implementation AltimeterDetailViewController

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
    
    settingsHelper = [[SettingsHelper alloc] init];
    unitOfMeasure = @"meters";
    
    self.image = [UIImage imageNamed:@"background.jpg"];
    self.imageView.image = [self.image applyLightEffect];
    [self.view sendSubviewToBack:self.imageView];
    
    altimeter = [[AltimeterView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:altimeter];
    [altimeter drawRect:self.view.frame];
    
    [self setupLocationUpdates];
}

- (void) viewWillAppear:(BOOL)animated {
    [self startStandardUpdates];
    
    if([unitOfMeasure isEqualToString:@"feet"]) {
        unitOfMeasure = @"meters";
        double alt = [self.altimeterLabel.text doubleValue] / METERS_TO_FEET;
        self.altimeterLabel.text = [NSString stringWithFormat:@"%f %@", alt, unitOfMeasure];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    [self stopStandardUpdates];
}

#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    double alt = [self.altimeterLabel.text doubleValue];
    if([unitOfMeasure isEqualToString:@"meters"]) {
        alt = alt * METERS_TO_FEET;
        unitOfMeasure = @"feet";
    } else {
        alt = alt / METERS_TO_FEET;
        unitOfMeasure = @"meters";
    }
    self.altimeterLabel.text = [NSString stringWithFormat:@"%f %@", alt, unitOfMeasure];
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
    if([unitOfMeasure isEqualToString:@"feet"]) {
        double alt = [self.altimeterLabel.text doubleValue] * METERS_TO_FEET;
        self.altimeterLabel.text = [NSString stringWithFormat:@"%f %@", alt, unitOfMeasure];
    } else {
        self.altimeterLabel.text = [NSString stringWithFormat:@"%f %@", self.location.altitude, unitOfMeasure];
    }
    altimeter.altitudeLabel.text = [NSString stringWithFormat:@"%.f", (self.location.altitude * METERS_TO_FEET)];
    altimeter.altitude = self.location.altitude * METERS_TO_FEET;
    [altimeter setNeedsDisplay];
}

-(void)setLocationAccuracy {
    int la = [defaults integerForKey:@"location_accuracy"];
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
    NSLog(@"%i", la);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
