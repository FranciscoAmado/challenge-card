//
//  TopContainerView.h
//  challenge-card
//
//  Created by franciscoamado on 14/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FrontCardView.h"
#import "BackCardView.h"

@interface TopContainerView : UIView <CardViewDelegate>

@property (strong, nonatomic) FrontCardView *frontView;
@property (strong, nonatomic) BackCardView *backView;

- (void)flipToFrontView:(BOOL)flipToFront;
- (void)changeFrontCardBackgroundColor:(UIColor *)newColor;
- (void)setSelectedWithTag:(NSUInteger)tag;

@end