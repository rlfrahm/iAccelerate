//
//  GSAppDelegate.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/13/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "GSAppDelegate.h"

@implementation GSAppDelegate

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UITabBarController* tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar* tabBar = tabBarController.tabBar;
    UITabBarItem* tabBarItem1 = [tabBar.items objectAtIndex:0];
    tabBarItem1.title = @"Record";
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"carbon_fibre.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0 green:155.0/255.0 blue:149.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults integerForKey:@"location_accuracy"]) {
        [defaults setInteger:3 forKey:@"location_accuracy"];
    }
    if(![defaults boolForKey:@"location_tracking"]) {
        [defaults setBool:YES forKey:@"location_tracking"];
    }
    if(![defaults boolForKey:@"data_smoothing"]) {
        [defaults setBool:YES forKey:@"data_smoothing"];
    }
    if(![defaults doubleForKey:@"accel_update_interval"]) {
        [defaults setDouble:1.0 forKey:@"accel_update_interval"];
    }
    [defaults synchronize];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"In the background still running..");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSManagedObjectContext *) managedObjectContext {
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *) managedObjectModel {
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL* storeUrl = [NSURL fileURLWithPath:[[self applicationDocumentsDirector] stringByAppendingPathComponent:@"Gees.sqlite"]];
    NSError* error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        /* Error for store creation should be handled in here */
    }
    return _persistentStoreCoordinator;
}

- (NSString *) applicationDocumentsDirector {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSArray *) getAllGeeRecords {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Gees" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray* fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSUInteger) getGeesRecordCount {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Gees" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    return [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

@end
