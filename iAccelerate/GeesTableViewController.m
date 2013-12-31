//
//  GeesTableViewController.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/15/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "GeesTableViewController.h"
#import "GSAppDelegate.h"
#import "Gees.h"

@interface GeesTableViewController ()

@end

@implementation GeesTableViewController

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

    self.image = [UIImage imageNamed:@"background.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:[self.image applyLightEffect]];
    self.imageView.frame = self.view.bounds;
    //[self.view addSubview:self.imageView];
    
    [self.tableView setBackgroundView:self.imageView];
    [self.view sendSubviewToBack:self.tableView];
}

- (void) viewWillAppear:(BOOL)animated {
    GSAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    self.fetchedGeesArray = [appDelegate getAllGeeRecords];
    [self.tableView reloadData];
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
    return [self.fetchedGeesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"GeesCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    Gees* gees = [self.fetchedGeesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%.3f G's", [gees.gees doubleValue]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.3f s", [gees.duration doubleValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeesDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"geesdetail"];
    
    Gees* gees = [self.fetchedGeesArray objectAtIndex:indexPath.row];
    detail.gees = [NSString stringWithFormat:@"%.3f",[gees.gees doubleValue]];
    detail.time = [NSString stringWithFormat:@"%@", gees.time];
    detail.latitude = [NSString stringWithFormat:@"%.3f", [gees.latitude doubleValue]];
    detail.longitude = [NSString stringWithFormat:@"%.3f", [gees.longitude doubleValue]];
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:155.0/255.0 blue:149.0/255.0 alpha:1.0];//[UIColor colorWithRed:1.0 green:149.0/225.0 blue:64.0/255.0 alpha:1.0];
    cell.textLabel.shadowColor = [UIColor whiteColor];//[UIColor colorWithRed:1.0 green:113.0/225.0 blue:0.0 alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
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

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        [segue destinationViewController];
    }
    // Get the new view controller using [segue destinationViewController].
    
    // Pass the selected object to the new view controller.
    NSLog(@"Reload");
}

@end
