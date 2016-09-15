//
//  ToddSyndromeDetector.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ToddSyndromeDetector.h"
#import "Patient+CoreDataProperties.h"

@implementation ToddSyndromeDetector

#pragma mark - Public API

- (double)probability {
    double result = 0.0;
    
    result += self.patient.migraines ? 25.0 : 0.0;
    result += self.patient.drugsUse ? 25.0 : 0.0;
    result += self.patient.gender == MALE_GENDER ? 25.0 : 0.0;
    result += self.patient.age > 15 ? 25.0 : 0.0;
    
    return result;
}

@end
