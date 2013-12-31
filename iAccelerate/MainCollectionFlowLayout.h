//
//  MainCollectionFlowLayout.h
//  iAccelerate
//
//  Created by Ryan Frahm on 12/28/13.
//  Copyright (c) 2013 Ryan Frahm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@end
