//
//  LeaderboardDetailViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "LeaderboardDetailViewController.h"

@interface LeaderboardDetailViewController ()

@end

@implementation LeaderboardDetailViewController

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
    
    self.image = [UIImage imageNamed:@"background.jpg"];
    self.imageView.image = [self.image applyLightEffect];
    [self.view sendSubviewToBack:self.imageView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
