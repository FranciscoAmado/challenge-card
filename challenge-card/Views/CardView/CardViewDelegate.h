//
//  CardViewDelegate.h
//  challenge-card
//
//  Created by Francisco Amado on 31/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardViewDelegate <NSObject>

- (void)labelTouchedInside:(UIView *)sender;

@end