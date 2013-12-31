//
//  CompassDetailViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "CompassDetailViewController.h"
#import "GSViewController.h"

@interface CompassDetailViewController ()

@end

@implementation CompassDetailViewController {
    NSUserDefaults* defaults;
}

@synthesize location, locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if(self.returnToMainView) [self addReturnToMainViewButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.image = [UIImage imageNamed:@"background.jpg"];
    self.imageView.image = [self.image applyLightEffect];
    [self.view sendSubviewToBack:self.imageView];
    
    locationManager = [[CLLocationManager alloc] init];
    [self setLocationAccuracy];
    locationManager.delegate = self;
    [locationManager startUpdatingHeading];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    self.magneticHeadingLabel.text = [NSString stringWithFormat:@"%f", newHeading.magneticHeading];
    self.trueHeadingLabel.text = [NSString stringWithFormat:@"%f", newHeading.trueHeading];
}

-(void)addReturnToMainViewButton {
    UIButton* returnButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 90, self.view.bounds.size.height - 100, 50, 24)];
    [returnButton setTitle:@"Return" forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
}

-(void)returnButtonTouched {
    GSViewController* mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
    [self.navigationController pushViewController:mainView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
