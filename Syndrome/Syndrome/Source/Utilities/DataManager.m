//
//  DataManager.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "ToddSyndromeDetector.h"

@interface DataManager()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation DataManager

#pragma mark - Properties

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    
    return _managedObjectContext;
}

#pragma mark - Public API

+ (instancetype)sharedInstance {
    static DataManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName
                                                         inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    // Sorting
    if (sortKey != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
        NSArray *sortDescriptors = @[sortDescriptor];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    // Filtering
    if (filter != nil) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultsArray = [NSMutableArray arrayWithArray:array];
    
    if (resultsArray == nil) NSLog(@"Error fetching %@(s).", entityName);
    
    return resultsArray;
}

- (void)updatePatient:(Patient *)patient {
    ToddSyndromeDetector *detector = [[ToddSyndromeDetector alloc] initWithPatient:patient];
    patient.probability = [detector probability];
    
    NSError *error = nil;
    if ([patient.managedObjectContext hasChanges] && ![patient.managedObjectContext save:&error]) {
        NSLog(@"Error updating object in database: %@, %@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

- (Patient *)savePatientWithName:(NSString *)name
                         surname:(NSString *)surname
                          gender:(NSInteger)gender
                             age:(NSInteger)age
                       migraines:(BOOL)migraines
                        drugsUse:(NSInteger)drugsUse {
    Patient *patient = (Patient *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Patient class])
                                                                inManagedObjectContext:self.managedObjectContext];
    patient.name = name;
    patient.surname = surname;
    patient.gender = gender;
    patient.age = age;
    patient.migraines = migraines;
    patient.drugsUse = drugsUse;
    
    ToddSyndromeDetector *detector = [[ToddSyndromeDetector alloc] initWithPatient:patient];
    patient.probability = [detector probability];
    
    [self save];
    
    return patient;
}

#pragma mark - Private API

- (void)save {
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        NSLog(@"Error saving to database: %@, %@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

@end
