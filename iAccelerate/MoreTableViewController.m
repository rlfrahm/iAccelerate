//
//  MoreTableViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/24/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "MoreTableViewController.h"
#import "SettingsDetailViewController.h"
#import "AltimeterDetailViewController.h"
#import "CompassDetailViewController.h"
#import "LeaderboardDetailViewController.h"
#import "AboutDetailViewController.h"

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

@synthesize cellInformation;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cellInformation = [NSArray arrayWithObjects:@"Altimeter",@"Compass",@"Settings",@"Leaderboards",@"About", nil];
    
    self.image = [UIImage imageNamed:@"background.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:[self.image applyLightEffect]];
    self.imageView.frame = self.view.bounds;
    //[self.view addSubview:self.imageView];
    
    [self.tableView setBackgroundView:self.imageView];
    [self.view sendSubviewToBack:self.tableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cellInformation count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [cellInformation objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellName = [cellInformation objectAtIndex:indexPath.row];
    if([cellName isEqualToString:@"Settings"]) {
        SettingsDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsdetail"];
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([cellName isEqualToString:@"Altimeter"]) {
        AltimeterDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"altimeterdetail"];
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([cellName isEqualToString:@"Compass"]) {
        CompassDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"compassdetail"];
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([cellName isEqualToString:@"Leaderboards"]) {
        LeaderboardDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"leaderboarddetail"];
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([cellName isEqualToString:@"About"]) {
        AboutDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutdetail"];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:155.0/255.0 blue:149.0/255.0 alpha:1.0];//[UIColor colorWithRed:1.0 green:149.0/225.0 blue:64.0/255.0 alpha:1.0];
    cell.textLabel.shadowColor = [UIColor whiteColor];//[UIColor colorWithRed:1.0 green:113.0/225.0 blue:0.0 alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0];
    cell.textLabel.shadowOffset = CGSizeMake(0, 1);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
