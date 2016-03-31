//
//  FrontCardView.h
//  challenge-card
//
//  Created by franciscoamado on 14/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewDelegate.h"

@interface FrontCardView : UIView

@property (nonatomic, weak) id <CardViewDelegate> delegate;

- (void)setCenterLabelWithText:(NSString *)text;
- (void)setLeftBottomLabelWithText:(NSString *)text;
- (void)setRightBottomLabelWithText:(NSString *)text;
- (void)changeBackgroundColorFor:(UIColor *)newColor;

@end