//
//  CollectionViewCell.h
//  challenge-card
//
//  Created by franciscoamado on 11/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    CollectionViewCellInputTypeNumber,
    CollectionViewCellInputTypeText,
    CollectionViewCellInputTypeDate
} CollectionViewCellInputType;

typedef enum : NSUInteger
{
    CardFacingViewFront,
    CardFacingViewBack
} CardFacingView;

@protocol CollectionViewCellDelegate <NSObject>

- (void)didStartEditingCellWithTag:(NSInteger)tag;
- (void)didEndEditingCellWithTag:(NSInteger)tag;
- (void)didReturnEditingCellWithTag:(NSInteger)tag;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <CollectionViewCellDelegate> delegate;
@property (strong, nonatomic) NSString *captionText;
@property (strong, nonatomic) NSString *placeholderText;
@property (assign, nonatomic) BOOL isFinalItem;
@property (assign, nonatomic) CollectionViewCellInputType inputType;
@property (assign, nonatomic) CardFacingView cardFacingView;

- (void)focusOn;
- (CGSize)sizeForConstrainedSize:(CGSize)size;
@end