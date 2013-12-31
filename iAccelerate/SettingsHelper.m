//
//  SettingsHelper.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/25/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "SettingsHelper.h"

@interface SettingsHelper ()
@property (strong, nonatomic) NSDictionary* settingsDict;
@end

@implementation SettingsHelper

@synthesize settingsDict;

-(id) init {
    self = [super init];
    if (self) {
        NSString* plistSettingsPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        NSDictionary* rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistSettingsPath];
        settingsDict = [rootDictionary objectForKey:@"Settings"];
        //double locationAccuracy = [[settingsDict objectForKey:@"Location Accuracy"] doubleValue];
        //BOOL dataSmoothing = [[settingsDict objectForKey:@"Data Smoothing"] boolValue];
    }
    return self;
}

-(id)getObjectForKey:(NSString*)key {
    return [settingsDict objectForKey:key];
}

-(void)setObjectForKey {
    
}

@end
