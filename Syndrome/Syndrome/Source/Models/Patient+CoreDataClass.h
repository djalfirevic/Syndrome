//
//  Patient+CoreDataClass.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Patient : NSManagedObject

/**
 Returns full name of patient

 @return Returns full name of patient
 */
- (NSString *)fullName;


/**
 Returns probability for syndrom

 @return Returns probability for syndrom
 */
- (NSString *)formattedProbability;
@end

NS_ASSUME_NONNULL_END

#import "Patient+CoreDataProperties.h"
