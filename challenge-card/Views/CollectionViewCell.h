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
    CollectionViewCellInputTypeNumber = 0,
    CollectionViewCellInputTypeCardHolder,
    CollectionViewCellInputTypeDate,
    CollectionViewCellInputTypeCode
} CollectionViewCellInputType;

@protocol CollectionViewCellDelegate <NSObject>

- (void)didStartEditingCellWithTag:(NSUInteger)tag;
- (void)didEndEditingCellWithTag:(NSUInteger)tag;
- (void)didReturnEditingCellWithTag:(NSUInteger)tag;
- (void)didChangeCellWithTag:(NSUInteger)tag withText:(NSString *)string;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <CollectionViewCellDelegate> delegate;
@property (strong, nonatomic) NSString *captionText;
@property (strong, nonatomic) NSString *placeholderText;
@property (assign, nonatomic) BOOL isFinalItem;
@property (assign, nonatomic) CollectionViewCellInputType inputType;
@property (assign, nonatomic) BOOL belongsToFrontCard;

- (void)focusOn;
- (CGSize)sizeForConstrainedSize:(CGSize)size;
@end