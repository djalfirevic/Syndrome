//
//  TransitionManager.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kTransitionAnimationDuration 0.75f

@interface TransitionManager : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) CGRect frame;
@property (nonatomic) UINavigationControllerOperation navigationControllerOperation;
@end
