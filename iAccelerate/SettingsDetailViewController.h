//
//  SettingsDetailViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsDetailViewController : UITableViewController

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIImage* image;

@property (strong, nonatomic) NSDictionary* settingsArray;

@end
