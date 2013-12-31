//
//  GeesDetailViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/16/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "GeesDetailViewController.h"

@implementation GeesDetailViewController

@synthesize geesTime, geesGees, geesLatitude, geesLongitude, time, gees, latitude, longitude;

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
    geesTime.text = time;
    geesGees.text = gees;
    geesLongitude.text = longitude;
    geesLatitude.text = latitude;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
