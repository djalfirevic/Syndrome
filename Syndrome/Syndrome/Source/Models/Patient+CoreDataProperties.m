//
//  Patient+CoreDataProperties.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Patient+CoreDataProperties.h"

@implementation Patient (CoreDataProperties)

+ (NSFetchRequest<Patient *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Patient"];
}

@dynamic migraines;
@dynamic drugsUse;
@dynamic age;
@dynamic gender;
@dynamic name;
@dynamic surname;
@dynamic probability;

@end
