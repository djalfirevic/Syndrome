//
//  UIViewController+Utilities.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utilities)
- (void)presentErrorWithTitle:(NSString *)title andError:(NSString *)error;
@end
