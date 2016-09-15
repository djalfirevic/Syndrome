//
//  DataManager.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Patient+CoreDataClass.h"

@interface DataManager : NSObject
+ (instancetype)sharedInstance;

/**
 Fetching data from the data source.

 @param entityName    Entity name from database
 @param filter        WHERE clause basically
 @param sortAscending Ascending/descending ordering
 @param sortKey       Sorting per key

 @return array of objects
 */
- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey;

/**
 Update patient in database.

 @param patient Patient which should be updated
 */
- (void)updatePatient:(Patient *)patient;


/**
 Save patient to be persistent.

 @param name      First name
 @param surname   Last name
 @param gender    Gender
 @param age       Age
 @param migraines Does patient have any migraines?
 @param drugsUse  Did patient use some hallucinogenic drugs?

 @return Created patient
 */
- (Patient *)savePatientWithName:(NSString *)name
                         surname:(NSString *)surname
                          gender:(NSInteger)gender
                             age:(NSInteger)age
                       migraines:(BOOL)migraines
                        drugsUse:(NSInteger)drugsUse;
@end
