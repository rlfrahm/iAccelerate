//
//  AltimeterDetailViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AltimeterDetailViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *altimeterLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage* image;

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;

-(void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray *)locations;

@end
