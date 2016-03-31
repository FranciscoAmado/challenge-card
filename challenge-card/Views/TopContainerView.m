//
//  TopContainerView.m
//  challenge-card
//
//  Created by franciscoamado on 14/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "TopContainerView.h"
#import "UIView+FlipViews.h"

typedef enum : NSUInteger
{
    CardFacingViewFront,
    CardFacingViewBack
} CardFacingView;

@interface TopContainerView () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *templateView;
@property (assign, nonatomic) CardFacingView cardFacingView;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;

@end

@implementation TopContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.frontView = [[FrontCardView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.templateView.frame.size.width, self.templateView.frame.size.height)];
    [self.frontView setDelegate:self];

    self.backView = [[BackCardView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.templateView.frame.size.width, self.templateView.frame.size.height)];
    //    [self.backView setDelegate:self];

    [self.templateView.layer setCornerRadius:10.0f];
    [self.templateView addSubview:self.backView];
    [self.templateView addSubview:self.frontView];

    self.cardFacingView = CardFacingViewFront;
}

- (void)flipToFrontView:(BOOL)flipToFront
{
    if (flipToFront) {
        if (self.cardFacingView != CardFacingViewFront) {
            [UIView transitionFromView:self.backView toView:self.frontView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut completion:NULL];
            self.cardFacingView = CardFacingViewFront;
        }
    }
    else {
        if (self.cardFacingView != CardFacingViewBack) {
            [UIView transitionFromView:self.frontView toView:self.backView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveEaseInOut completion:NULL];
            self.cardFacingView = CardFacingViewBack;
        }
    }
}

- (void)changeFrontCardBackgroundColor:(UIColor *)newColor
{
    [self.frontView changeBackgroundColorFor:newColor];
}

- (void)setSelectedWithTag:(NSUInteger)tag
{
}

#pragma Mark CardViewDelegate
- (void)labelTouchedInside:(UIView *)sender
{
    if ([sender isDescendantOfView:self.frontView]) {
        NSLog(@"frontview");
        [self flipToFrontView:YES];
    }
    else if ([sender isDescendantOfView:self.backView]) {
        NSLog(@"backview");
        [self flipToFrontView:NO];
    }
}

- (IBAction)swipeFromRight:(id)sender
{
    [self flipToFrontView:NO];
}

- (IBAction)swipeFromLeft:(id)sender
{
    [self flipToFrontView:YES];
}

@end