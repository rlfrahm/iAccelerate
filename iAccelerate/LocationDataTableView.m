//
//  LocationDataTableView.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/26/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "LocationDataTableView.h"

@implementation LocationDataTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(NSInteger)numberOfSections {
    return 1;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MoreCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
