//
//  SettingsDetailViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "SettingsDetailViewController.h"

@interface SettingsDetailViewController ()

@end

@implementation SettingsDetailViewController {
    NSArray* _cellContents;
    NSArray* _inputType;
    UISegmentedControl *locationTrackingSegmentedControl;
    UISlider *locationAccuracySlider;
    UISwitch *dataSmoothingSwitch;
    UIStepper *accelUpdateIntervalStepper;
    UILabel* stepperVal;
    BOOL _locationTracking;
    BOOL _dataSmoothing;
    int _locationAccuracy;
    SettingsHelper* settingsHelper;
    NSUserDefaults* defaults;
}

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
    self.imageView = [[UIImageView alloc] initWithImage:[self.image applyLightEffect]];
    self.imageView.frame = self.view.bounds;
    //[self.view addSubview:self.imageView];
    
    [self.tableView setBackgroundView:self.imageView];
    [self.view sendSubviewToBack:self.tableView];
    
    //settingsHelper = [[SettingsHelper alloc] init];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    _cellContents = [NSArray arrayWithObjects:@"Location Tracking",@"Location Accuracy",@"Data Smoothing",@"Update Interval", nil];
    
    NSArray* items = [[NSArray alloc] initWithObjects:@"On",@"Off", nil];
    locationTrackingSegmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    [locationTrackingSegmentedControl addTarget:self action:@selector(changeLocationTracking) forControlEvents:UIControlEventValueChanged];
    
    //_locationAccuracy = [[settingsHelper getObjectForKey:@"Location Accuracy"] integerValue];
    //_locationTracking = [[settingsHelper getObjectForKey:@"Location Tracking"] boolValue];
    _locationAccuracy = [defaults integerForKey:@"location_accuracy"];
    _locationTracking = [defaults boolForKey:@"location_tracking"];
    
    if(_locationTracking) {
        locationTrackingSegmentedControl.selectedSegmentIndex = 0;
    } else {
        locationTrackingSegmentedControl.selectedSegmentIndex = 1;
    }
    
    self.tableView.sectionHeaderHeight = 45;
    self.tableView.sectionFooterHeight = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) return 2;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"%i", indexPath.row);
    if([indexPath section] == 0) {
        if(indexPath.row == 0) {
            [locationTrackingSegmentedControl setFrame:CGRectMake(cell.bounds.size.width - 80, cell.bounds.size.height/4, 50, 24)];
            [locationTrackingSegmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [[cell contentView] addSubview:locationTrackingSegmentedControl];
            cell.textLabel.text = @"Location Tracking";
            [locationTrackingSegmentedControl setEnabled:NO];
        } else if(indexPath.row == 1) {
            locationAccuracySlider = [[UISlider alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 130, cell.bounds.size.height/4, 100, 24)];
            [locationAccuracySlider setMaximumValue:5];
            [locationAccuracySlider setMinimumValue:0];
            locationAccuracySlider.value = _locationAccuracy;
            [locationAccuracySlider addTarget:self action:@selector(changeLocationAccuracy) forControlEvents:UIControlEventValueChanged];
            [locationAccuracySlider setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [[cell contentView] addSubview:locationAccuracySlider];
            cell.textLabel.text = @"Location Accuracy";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", _locationAccuracy];
            
        }
    } else if([indexPath section] == 1) {
        if(indexPath.row == 0) {
            dataSmoothingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 80, cell.bounds.size.height/4, 50, 24)];
            [dataSmoothingSwitch addTarget:self action:@selector(changeDataSmoothing) forControlEvents:UIControlEventValueChanged];
            [dataSmoothingSwitch setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            _dataSmoothing = [[settingsHelper getObjectForKey:@"Data Smoothing"] boolValue];
            if(!dataSmoothingSwitch.on && _dataSmoothing) {
                dataSmoothingSwitch.on = YES;
            }
            [[cell contentView] addSubview:dataSmoothingSwitch];
            cell.textLabel.text = @"Data Smoothing";
        }
    } else if([indexPath section] == 2) {
        if(indexPath.row == 0) {
            accelUpdateIntervalStepper = [[UIStepper alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 120, cell.bounds.size.height/4, 50, 24)];
            [accelUpdateIntervalStepper addTarget:self action:@selector(changeAccelerometerUpdateInterval) forControlEvents:UIControlEventValueChanged];
            [accelUpdateIntervalStepper setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            accelUpdateIntervalStepper.minimumValue = 0.1;
            accelUpdateIntervalStepper.maximumValue = 5.0;
            accelUpdateIntervalStepper.stepValue = 0.1;
            accelUpdateIntervalStepper.value = [defaults doubleForKey:@"accel_update_interval"];
            [[cell contentView] addSubview:accelUpdateIntervalStepper];
            stepperVal = [[UILabel alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 160, cell.bounds.size.height/4, 24, 15)];
            stepperVal.text = [NSString stringWithFormat:@"%.1f", [defaults doubleForKey:@"accel_update_interval"]];
            [[cell contentView] addSubview:stepperVal];
            cell.textLabel.text = @"Update Interval";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:155.0/255.0 blue:149.0/255.0 alpha:1.0];//[UIColor colorWithRed:1.0 green:149.0/225.0 blue:64.0/255.0 alpha:1.0];
    cell.textLabel.shadowColor = [UIColor whiteColor];//[UIColor colorWithRed:1.0 green:113.0/225.0 blue:0.0 alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
    cell.textLabel.shadowOffset = CGSizeMake(0, 1);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, tableView.bounds.size.width - 10, 50)];
    UILabel* headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, headerView.bounds.size.height/3, 150, 24)];
    if(section == 0) headerTitle.text = @"Location";
    else if(section == 1) headerTitle.text = @"Data";
    else if(section == 2) headerTitle.text = @"Accelerometer";
    headerTitle.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0];;
    headerTitle.shadowOffset = CGSizeMake(0, 1);
    headerTitle.shadowColor = [UIColor whiteColor];
    [headerView addSubview:headerTitle];
    [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    [footerView setBackgroundColor:[UIColor blackColor]];
    return footerView;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) return @"Location";
    else return @"Data";
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

#pragma mark Actions

- (void) changeLocationTracking {
    if(locationTrackingSegmentedControl.selectedSegmentIndex == 0) {
        [defaults setBool:YES forKey:@"location_tracking"];
    } else {
        [defaults setBool:NO forKey:@"location_tracking"];
    }
    [defaults synchronize];
}

- (void) changeDataSmoothing {
    if(dataSmoothingSwitch.on) {
        [defaults setBool:YES forKey:@"data_smoothing"];
    } else {
        [defaults setBool:NO forKey:@"data_smoothing"];
    }
    [defaults synchronize];
}

- (void) changeLocationAccuracy {
    
    if(locationAccuracySlider.value >= 0 && locationAccuracySlider.value < 0.5) {
        locationAccuracySlider.value = 0;
        [defaults setInteger:0 forKey:@"location_accuracy"];
        [defaults synchronize];
    } else if(locationAccuracySlider.value >= 0.5 && locationAccuracySlider.value < 1.5) {
        locationAccuracySlider.value = 1;
        [defaults setInteger:1 forKey:@"location_accuracy"];
        [defaults synchronize];
    } else if(locationAccuracySlider.value >= 1.5 && locationAccuracySlider.value < 2.5) {
        locationAccuracySlider.value = 2;
        [defaults setInteger:2 forKey:@"location_accuracy"];
        [defaults synchronize];
    } else if(locationAccuracySlider.value >= 2.5 && locationAccuracySlider.value < 3.5) {
        locationAccuracySlider.value = 3;
        [defaults setInteger:3 forKey:@"location_accuracy"];
        [defaults synchronize];
    } else if(locationAccuracySlider.value >= 3.5 && locationAccuracySlider.value < 4.5) {
        locationAccuracySlider.value = 4;
        [defaults setInteger:4 forKey:@"location_accuracy"];
        [defaults synchronize];
    } else if(locationAccuracySlider.value >= 4.5 && locationAccuracySlider.value <= 5) {
        locationAccuracySlider.value = 5;
        [defaults setInteger:5 forKey:@"location_accuracy"];
        [defaults synchronize];
    }
    NSLog(@"%i", [defaults integerForKey:@"location_accuracy"]);
}

- (void) changeAccelerometerUpdateInterval {
    NSLog(@"%f",accelUpdateIntervalStepper.value);
    [defaults setDouble:accelUpdateIntervalStepper.value forKey:@"accel_update_interval"];
    [defaults synchronize];
    stepperVal.text = [NSString stringWithFormat:@"%.1f", [defaults doubleForKey:@"accel_update_interval"]];
}

@end
