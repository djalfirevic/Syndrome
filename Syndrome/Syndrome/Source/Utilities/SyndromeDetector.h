//
//  SyndromeDetector.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Patient;

@interface SyndromeDetector : NSObject
@property (strong, nonatomic) Patient *patient;

/**
 Designated Initializer

 @param patient Patient for detector will measure some specific syndrome probability.

 @return Instance
 */
- (instancetype)initWithPatient:(Patient *)patient;


/**
 Probability for Syndrome

 @return Percentage value
 */
- (double)probability;
@end
