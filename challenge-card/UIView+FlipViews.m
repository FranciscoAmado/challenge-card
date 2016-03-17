//
//  UIView+CardsAnimation.m
//  challenge-card
//
//  Created by franciscoamado on 15/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "UIView+FlipViews.h"

@implementation UIView (FlipViews)

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
                            options:UIViewAnimationOptionCurveEaseOut
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
    // Rotate 180ª in y axis
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform,  //transform
                                                          M_PI / 2,                         //angle
                                                          0.0f,                             //x
                                                          left ? 1.0f : -1.0f,              //y
                                                          0.0f);                            //z

    return rotationAndPerspectiveTransform;
}

@end