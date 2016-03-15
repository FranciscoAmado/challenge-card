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

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (weak, nonatomic) IBOutlet TopContainerView *topContainer;
@property (strong, nonatomic) CollectionViewCell *sizingCell;

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
        kCellInputType: @(CollectionViewCellInputTypeNumber)
    };

    NSDictionary *cellExpiryDate = @{
        kCellTitleText:@"Expiry Date",
        kCellPlaceholderText:@"YY/MM",
        kCellInputType:@(CollectionViewCellInputTypeDate)
    };

    NSDictionary *cellCardCode = @{
        kCellTitleText:@"CVC",
        kCellPlaceholderText:@"",
        kCellInputType:@(CollectionViewCellInputTypeNumber)
    };

    NSDictionary *cellCardholder = @{
        kCellTitleText:@"Card Holder's Name",
        kCellPlaceholderText:@"John Doe",
        kCellInputType:@(CollectionViewCellInputTypeText)
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

    NSLog(@"captionText:%@", [cellContent objectForKey:kCellTitleText]);

    [cell setPlaceholderText:[cellContent objectForKey:kCellPlaceholderText]];
    [cell setCaptionText:[cellContent objectForKey:kCellTitleText]];
    [cell setInputType:[[cellContent objectForKey:kCellInputType] integerValue]];

    return cell;
}

#pragma MARK CollectionViewCellDelegate
- (void)didStartEditingCellWithTag:(NSInteger)tag
{
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    [self.topContainer flipToFrontView:NO];
}

- (void)didEndEditingCellWithTag:(NSInteger)tag
{
    [self.collectionView endEditing:YES];
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:tag + 1 inSection:0];

    CollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:cellIndexPath];

    if (cell != nil) {
        [cell focusOn];
    }
}

@end