//
//  UIView+CardsAnimation.m
//  challenge-card
//
//  Created by franciscoamado on 15/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "UIView+CardsAnimation.h"

@implementation UIView (CardsAnimation)

+ (void)flipFromView:(UIView *)frontView toView:(UIView *)backView
{
    // Front Layer Transform Calculation
    CALayer *layerFront = frontView.layer;
    layerFront.transform = CATransform3DIdentity;

    // Back Layer Transform Calculation
    CALayer *layerBack = backView.layer;
    layerBack.transform = [UIView calculateRotationFromLeft:NO];

    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        layerFront.transform = [UIView calculateRotationFromLeft:YES];
    }
                     completion:^(BOOL finished) {
//        [frontView setHidden:YES];
        [UIView animateWithDuration:0.4
                              delay:0.0
             usingSpringWithDamping:0.3
              initialSpringVelocity:0.0
                            options:0
                         animations:^{
            layerBack.transform = CATransform3DIdentity;
        }
                         completion:nil];
    }];
}

+ (CATransform3D)calculateRotationFromLeft:(BOOL)left
{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1 / -1000;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform,
                                                          M_PI / 2,
                                                          0.0f,
                                                          left ? 1.0f : -1.0f,
                                                          0.0f);

    return rotationAndPerspectiveTransform;
}

@end