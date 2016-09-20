//
//  SyndromeDetector.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "SyndromeDetector.h"

@implementation SyndromeDetector

#pragma mark - Designated Initializer

- (instancetype)initWithPatient:(Patient *)patient {
    if (self = [super init]) {
        self.patient = patient;
    }
    
    return self;
}

#pragma mark - Public API

- (double)probability {
    [NSException raise:@"Unknown Syndrome detector"
                format:@"This is a generic class, please provide your own sublcass"];
    
    return kZeroValue;
}

@end
