//
//  GSAppDelegate.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/13/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

-(NSArray *)getAllGeeRecords;
-(NSUInteger)getGeesRecordCount;

@end
