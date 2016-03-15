//
//  CustomLayout.h
//  challenge-card
//
//  Created by franciscoamado on 11/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomLayoutDelegate <NSObject>

@optional
- (CGFloat)widthForItemAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface CustomLayout : UICollectionViewLayout

@property (assign, nonatomic) id <CustomLayoutDelegate> delegate;
@property (assign, nonatomic) NSNumber *numberOfItems;
@property (assign, nonatomic) CGFloat cellPadding;

@end
