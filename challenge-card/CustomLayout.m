//
//  CustomLayout.m
//  challenge-card
//
//  Created by franciscoamado on 11/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "CustomLayout.h"

#define WIDTH_DEFAULT 50.0f

@interface CustomLayout ()

@property (assign, nonatomic) NSArray <UICollectionViewLayoutAttributes *> *cacheAttributes;

@end

@implementation CustomLayout

- (void)prepareLayout
{
    if (self.cacheAttributes == nil || self.cacheAttributes.count == 0) {
    }
}

#pragma mark - CustomLayoutDelegate
- (CGFloat)widthForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return WIDTH_DEFAULT;
}

@end