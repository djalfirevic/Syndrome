//
//  NavigationControllerDelegate.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "TransitionManager.h"

@implementation NavigationControllerDelegate

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    TransitionManager *transitionManager = [[TransitionManager alloc] init];
    transitionManager.frame = CGRectMake(kTransitionX, kStatusBarHeight, kNavigationBarHeight, kNavigationBarHeight);
    transitionManager.navigationControllerOperation = operation;
    
    return transitionManager;
}

@end
