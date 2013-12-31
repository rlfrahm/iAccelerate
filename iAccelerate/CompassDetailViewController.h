//
//  CompassDetailViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface CompassDetailViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage* image;
@property (nonatomic) BOOL returnToMainView;

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;

@property (weak, nonatomic) IBOutlet UILabel *magneticHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueHeadingLabel;
@end
