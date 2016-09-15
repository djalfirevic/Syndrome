//
//  Patient+CoreDataClass.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Patient+CoreDataClass.h"

@implementation Patient

#pragma mark - Public API

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (NSString *)formattedProbability {
    return [NSString stringWithFormat:@"%.0lf%%", self.probability];
}

@end
