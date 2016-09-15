//
//  Patient+CoreDataProperties.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Patient+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Patient (CoreDataProperties)

+ (NSFetchRequest<Patient *> *)fetchRequest;

@property (nonatomic) BOOL migraines;
@property (nonatomic) BOOL drugsUse;
@property (nonatomic) int16_t age;
@property (nonatomic) int16_t gender;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *surname;
@property (nonatomic) double probability;
@end

NS_ASSUME_NONNULL_END
