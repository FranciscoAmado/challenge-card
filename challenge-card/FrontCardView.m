//
//  FrontCardView.m
//  challenge-card
//
//  Created by franciscoamado on 14/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "FrontCardView.h"

@interface FrontCardView ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *centerLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightBottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftBottomLabel;

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

    [self.view.layer setCornerRadius:10.0f];
}

@end