//
//  Gees.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/27/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Gees : NSManagedObject

@property (nonatomic, retain) NSNumber * gees;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * mean;

@end
