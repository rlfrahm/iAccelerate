//
//  GeesTableViewController.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/15/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeesDetailViewController.h"

@interface GeesTableViewController : UITableViewController

@property (nonatomic, strong) NSArray* fetchedGeesArray;

@property (strong, nonatomic) GeesDetailViewController *detailViewController;

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UIImage* image;

@end
