//
//  FrontCardView.m
//  challenge-card
//
//  Created by franciscoamado on 14/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "FrontCardView.h"

@interface FrontCardView () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *backgroundBorderView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *centerLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightBottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftBottomLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewWidthConstraint;

@end

@implementation FrontCardView

- (instancetype)init
{
    self = [super init];

    if (self) {
        [self setupConstraints];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self setupConstraints];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupConstraints];
    }

    return self;
}

- (void)setupConstraints
{
    [[NSBundle mainBundle] loadNibNamed:@"FrontCardView"
                                  owner:self
                                options:nil];

    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.view];

    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self.view
                                            attribute:NSLayoutAttributeLeading
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeLeading
                                           multiplier:1.0f
                                             constant:0.0f];

    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:self.view
                                             attribute:NSLayoutAttributeTrailing
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                             attribute:NSLayoutAttributeTrailing
                                            multiplier:1.0f
                                              constant:0.0f];

    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:self.view
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                        attribute:NSLayoutAttributeTop
                                       multiplier:1.0f
                                         constant:0.f];

    NSLayoutConstraint *bottom = [NSLayoutConstraint
                                  constraintWithItem:self.view
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:0
                                              toItem:self
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1.0
                                            constant:0];
    [self addConstraints:@[leading, trailing, top, bottom]];
    [self overallSetup];
}

- (void)overallSetup
{
    [self.view.layer setCornerRadius:10.0f];

    [self.leftImageView.layer setCornerRadius:5.0f];

    self.backgroundViewWidthConstraint.constant = 0;
    [self.backgroundView setNeedsUpdateConstraints];
    [self.backgroundView.layer setCornerRadius:10.0f];
    [self.backgroundView setClipsToBounds:YES];

    UIImage *backgroundImage = [[UIImage imageNamed:@"pattern.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [self.backgroundBorderView setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    [self.backgroundView setClipsToBounds:YES];
    [self.backgroundBorderView.layer setCornerRadius:10.0f];
    [self.backgroundBorderView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.backgroundBorderView.layer setBorderWidth:1.0];
}

- (void)changeBackgroundColorFor:(UIColor *)newColor
{
//    [self.view setBackgroundColor:newColor];
    self.backgroundViewWidthConstraint.constant = self.view.frame.size.width;
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        [self.backgroundView layoutIfNeeded];
    }
                     completion:nil];
}

- (void)setCenterLabelWithText:(NSString *)text
{
    [self.centerLabel setHighlighted:YES];
    [self.centerLabel setText:text];
}

- (void)setLeftBottomLabelWithText:(NSString *)text
{
    [self.leftBottomLabel setHighlighted:YES];
    [self.leftBottomLabel setText:text];
}

- (void)setRightBottomLabelWithText:(NSString *)text
{
    [self.rightBottomLabel setHighlighted:YES];
    [self.rightBottomLabel setText:text];
}

#pragma mark Label Actions
- (IBAction)centerLabelTouched:(UITapGestureRecognizer *)sender
{
    id <CardViewDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(labelTouchedInside:)]) {
        NSLog(@"centerLabelTouched");
        [strongDelegate labelTouchedInside:sender.view];
    }
}

- (IBAction)leftBottomLabelTouched:(UITapGestureRecognizer *)sender
{
    id <CardViewDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(labelTouchedInside:)]) {
        NSLog(@"leftBottomLabelTouched");
        [strongDelegate labelTouchedInside:sender.view];
    }
}

- (IBAction)rightBottomLabelTouched:(UITapGestureRecognizer *)sender
{
    id <CardViewDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(labelTouchedInside:)]) {
        NSLog(@"rightBottomLabelTouched");
        [strongDelegate labelTouchedInside:sender.view];
    }
}

@end