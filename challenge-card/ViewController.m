//
//  ViewController.m
//  challenge-card
//
//  Created by franciscoamado on 11/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "ViewController.h"

#define kCollectionViewCellIdentifier @"CollectionViewCell"
#define kCellTitleText @"kCellTitleText"
#define kCellPlaceholderText @"kCellPlaceholderText"
#define kCellInputType @"kCellInputType"
#define kCellCardFacingView @"kCellCardFacingView"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (weak, nonatomic) IBOutlet TopContainerView *topContainer;
@property (strong, nonatomic) CollectionViewCell *sizingCell;
@property (strong, nonatomic) CollectionViewCell *actualCell;
@property (strong, nonatomic) NSArray <CollectionViewCell *> *cellArray;

@property (strong, nonatomic) NSArray <NSDictionary *> *cellPropertiesArray;

//@property (strong, nonatomic) NSArray *titlesArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *collectionViewCellNib = [UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:collectionViewCellNib forCellWithReuseIdentifier:kCollectionViewCellIdentifier];

    self.sizingCell = [[collectionViewCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];

    NSDictionary *cellNumber = @{
        kCellTitleText: @"Card Number",
        kCellPlaceholderText:@"",
        kCellInputType: @(CollectionViewCellInputTypeNumber),
        kCellCardFacingView: @(CardFacingViewFront)
    };

    NSDictionary *cellExpiryDate = @{
        kCellTitleText:@"Expiry Date",
        kCellPlaceholderText:@"YY/MM",
        kCellInputType:@(CollectionViewCellInputTypeDate),
        kCellCardFacingView: @(CardFacingViewFront)
    };

    NSDictionary *cellCardCode = @{
        kCellTitleText:@"CVC",
        kCellPlaceholderText:@"",
        kCellInputType:@(CollectionViewCellInputTypeCode),
        kCellCardFacingView: @(CardFacingViewBack)
    };

    NSDictionary *cellCardholder = @{
        kCellTitleText:@"Card Holder's Name",
        kCellPlaceholderText:@"John Doe",
        kCellInputType:@(CollectionViewCellInputTypeCardHolder),
        kCellCardFacingView: @(CardFacingViewFront)
    };

    self.cellPropertiesArray = @[cellNumber, cellExpiryDate, cellCardCode, cellCardholder];
}

# pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellPropertiesArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellContent = [self.cellPropertiesArray objectAtIndex:indexPath.row];

    self.sizingCell = [self configureCell:self.sizingCell withContent:cellContent];

    CGSize constrainedSize = CGSizeMake(CGFLOAT_MAX, self.collectionView.frame.size.height);
    CGSize labelSize = [self.sizingCell sizeForConstrainedSize:constrainedSize];

    return CGSizeMake(labelSize.width, self.collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];

    NSDictionary *cellContent = [self.cellPropertiesArray objectAtIndex:indexPath.row];

    cell = [self configureCell:cell withContent:cellContent];

    if (indexPath.row == self.cellPropertiesArray.count - 1) {
        [cell setIsFinalItem:YES];
    }

    cell.tag = indexPath.row;

    return cell;
}

- (CollectionViewCell *)configureCell:(CollectionViewCell *)cell withContent:(NSDictionary *)cellContent
{
    cell.delegate = self;
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;

    [cell setPlaceholderText:[cellContent objectForKey:kCellPlaceholderText]];
    [cell setCaptionText:[cellContent objectForKey:kCellTitleText]];
    [cell setInputType:[[cellContent objectForKey:kCellInputType] unsignedIntegerValue]];
    [cell setCardFacingView:[[cellContent objectForKey:kCellCardFacingView] unsignedIntegerValue]];

    [cell setTag:[[cellContent objectForKey:kCellInputType] integerValue]];

    return cell;
}

#pragma MARK CollectionViewCellDelegate
- (void)didStartEditingCellWithTag:(NSUInteger)tag
{
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    CollectionViewCell *cell = (CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:cellIndexPath];

    if (self.actualCell == nil) {
        self.actualCell = cell;

        if (self.actualCell.cardFacingView == CardFacingViewBack) {
            [self.topContainer flipToFrontView:NO];
        }

        return;
    }

    if (self.actualCell.cardFacingView != cell.cardFacingView) {
        if (cell.cardFacingView == CardFacingViewFront) {
            [self.topContainer flipToFrontView:YES];
        }
        else {
            [self.topContainer flipToFrontView:NO];
        }
    }

    self.actualCell = cell;
}

- (void)didEndEditingCellWithTag:(NSUInteger)tag
{
    if (self.actualCell.cardFacingView == CardFacingViewBack) {
        [self.topContainer flipToFrontView:YES];
    }

    self.actualCell = nil;
}

- (void)didReturnEditingCellWithTag:(NSUInteger)tag
{
    [self.collectionView endEditing:YES];

    NSIndexPath *nextCellIndexPath = [NSIndexPath indexPathForRow:tag + 1 inSection:0];
    CollectionViewCell *nextCell = (CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:nextCellIndexPath];

    if (nextCell != nil) {
        [nextCell focusOn];
    }
}

- (void)didChangeCellWithTag:(NSUInteger)tag withText:(NSString *)string
{
    NSLog(@"didChangeCellWithString: %@", string);

    if (tag == CollectionViewCellInputTypeNumber) {
        if (string.length > 3) {
            [self.topContainer changeFrontCardBackgroundColor:[UIColor greenColor]];
        }

        [self.topContainer.frontView setCenterLabelWithText:string];
    }
    else if (tag == CollectionViewCellInputTypeDate) {
        [self.topContainer.frontView setRightBottomLabelWithText:string];
    }
    else if (tag == CollectionViewCellInputTypeCode) {
        [self.topContainer.backView setCenterLabelWithText:string];
    }
    else if (tag == CollectionViewCellInputTypeCardHolder) {
        [self.topContainer.frontView setLeftBottomLabelWithText:string];
    }
}

@end