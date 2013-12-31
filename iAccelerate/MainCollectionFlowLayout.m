//
//  MainCollectionFlowLayout.m
//  iAccelerate
//
//  Created by Ryan Frahm on 12/28/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import "MainCollectionFlowLayout.h"

#define kNumberOfItemsPerPage 7

static NSString* const LayoutCellKind = @"MainCell";

@interface MainCollectionFlowLayout()

@property (nonatomic, strong) NSDictionary* layoutInfo;

@end

@implementation MainCollectionFlowLayout

#pragma mark Lifecycle

-(id)init {
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

#pragma mark Layout

/*-(void)prepareLayout {
    NSMutableDictionary* newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary* cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for(NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for(NSInteger item = 0; item < itemCount; item++) {
            UICollectionViewLayoutAttributes* itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForCellAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    newLayoutInfo[LayoutCellKind] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

#pragma mark Private

-(CGRect)frameForCellAtIndexPath:(NSIndexPath*)indexPath {
    
}//*/

@end
