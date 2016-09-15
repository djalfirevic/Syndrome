//
//  TransitionManager.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//
#import "TransitionManager.h"

@interface TransitionManager() <CAAnimationDelegate>
@property (strong, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation TransitionManager

#pragma mark - Private API

- (void)snapshotAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    // Get rects that represent the top and bottom halves of the screen
    CGSize viewSize = fromController.view.bounds.size;
    CGRect topFrame = CGRectMake(0, 0, viewSize.width, viewSize.height/2);
    CGRect bottomFrame = CGRectMake(0, viewSize.height/2, viewSize.width, viewSize.height/2);
    
    if (self.navigationControllerOperation == UINavigationControllerOperationPush) {
        // Create snapshots
        UIView* snapshotTop = [fromController.view resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        UIView* snapshotBottom = [fromController.view resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        snapshotTop.frame = topFrame;
        snapshotBottom.frame = bottomFrame;
        
        // Remove the original view from the container
        [fromController.view removeFromSuperview];
        
        // Add our destination view
        [container addSubview:toController.view];
        
        // Add our snapshots on top
        [container addSubview:snapshotTop];
        [container addSubview:snapshotBottom];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            // Adjust the new frames
            CGRect newTopFrame = topFrame;
            CGRect newBottomFrame = bottomFrame;
            newTopFrame.origin.y -= topFrame.size.height;
            newBottomFrame.origin.y += bottomFrame.size.height;
            
            // Set the frames to animate them
            snapshotTop.frame = newTopFrame;
            snapshotBottom.frame = newBottomFrame;
            
        } completion:^(BOOL finished){
            // Clean up
            [snapshotTop removeFromSuperview];
            [snapshotBottom removeFromSuperview];
            
            [transitionContext completeTransition:finished];
        }];
    } else {
        // Create snapshots
        UIView* snapshot = [toController.view snapshotViewAfterScreenUpdates:YES];
        UIView* snapshotTop = [snapshot resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        UIView* snapshotBottom = [snapshot resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        // Start the frames with an offset
        CGRect offsetTopFrame = topFrame;
        CGRect offsetBottomFrame = bottomFrame;
        offsetTopFrame.origin.y -= topFrame.size.height;
        offsetBottomFrame.origin.y += bottomFrame.size.height;
        snapshotTop.frame = offsetTopFrame;
        snapshotBottom.frame = offsetBottomFrame;
        
        // Add our snapshots on top
        [container addSubview:snapshotTop];
        [container addSubview:snapshotBottom];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            // Set the frames to animate them back into place
            snapshotTop.frame = topFrame;
            snapshotBottom.frame = bottomFrame;
        } completion:^(BOOL finished){
            // Clean up
            [snapshotTop removeFromSuperview];
            [snapshotBottom removeFromSuperview];
            [fromController.view removeFromSuperview];
            [container addSubview:toController.view];
            
            [transitionContext completeTransition:finished];
        }];
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self snapshotAnimationWithContext:transitionContext];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75f;
}

#pragma mark - CABasicAnimation

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}

@end
