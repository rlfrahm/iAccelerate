//
//  GSViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/13/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "AccelerationGraphicsView.h"
#import "GenerateRadial.h"
#import <CoreLocation/CoreLocation.h>
#import "AccelerationRealtimePlotView.h"

@interface GSViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet AccelerationRealtimePlotView *accelPlot;
@property (strong, nonatomic) CMMotionManager* motionManager;
//@property (weak, nonatomic) IBOutlet UILabel *yAxis;
//@property (weak, nonatomic) IBOutlet UILabel *xAxis;
//@property (weak, nonatomic) IBOutlet UILabel *zAxis;
@property (weak, nonatomic) IBOutlet UILabel *geesLabel;
@property (weak, nonatomic) IBOutlet AccelerationGraphicsView *accelGraphics;
@property GenerateRadial* gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage* image;
/*@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *altLabel;
@property (weak, nonatomic) IBOutlet UILabel *haccLabel;
@property (weak, nonatomic) IBOutlet UILabel *vaccLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
 */
//@property (weak, nonatomic) IBOutlet UIButton *compassButton;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;

-(void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray *)locations;

@end
