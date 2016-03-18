//
//  BackCardView.m
//  challenge-card
//
//  Created by Francisco Amado on 15/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "BackCardView.h"

@interface BackCardView ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UIImageView *centerImageView;
@property (strong, nonatomic) IBOutlet UILabel *centerLabel;

@end

@implementation BackCardView

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
    [[NSBundle mainBundle] loadNibNamed:@"BackCardView"
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

    UIImage *backgroundImage = [[UIImage imageNamed:@"pattern.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];

    [self.backgroundView setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];

    [self.leftImageView.layer setCornerRadius:5.0f];
}

- (void)setCenterLabelWithText:(NSString *)text
{
    [self.centerLabel setHighlighted:YES];
    [self.centerLabel setText:text];
}

@end