//
//  GeesDetailViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/16/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeesDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *geesTime;
@property (weak, nonatomic) IBOutlet UILabel *geesGees;
@property (weak, nonatomic) IBOutlet UILabel *geesLongitude;
@property (weak, nonatomic) IBOutlet UILabel *geesLatitude;

@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSString* gees;
@property (strong, nonatomic) NSString* longitude;
@property (strong, nonatomic) NSString* latitude;


@end
