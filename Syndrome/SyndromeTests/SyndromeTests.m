//
//  SyndromeTests.m
//  SyndromeTests
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ToddSyndromeDetector.h"
#import "Patient+CoreDataClass.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface SyndromeTests : XCTestCase
@property (strong, nonatomic) ToddSyndromeDetector *detector50;
@property (strong, nonatomic) ToddSyndromeDetector *detector100;
@property (strong, nonatomic) Patient *patient100;
@property (strong, nonatomic) Patient *patient50;
@end

@implementation SyndromeTests

#pragma mark - Setup

- (void)setUp {
    [super setUp];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // Patient 100
    Patient *patient100 = (Patient *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Patient class])
                                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    patient100.name = @"Patient Name A";
    patient100.surname = @"Patient Surname A";
    patient100.age = 14;
    patient100.gender = MALE_GENDER;
    patient100.drugsUse = YES;
    patient100.migraines = YES;
    
    // Patient 50
    Patient *patient50 = (Patient *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Patient class])
                                                                  inManagedObjectContext:appDelegate.managedObjectContext];
    patient50.name = @"Patient Name A";
    patient50.surname = @"Patient Surname A";
    patient50.age = 20;
    patient50.gender = MALE_GENDER;
    patient50.drugsUse = YES;
    patient50.migraines = NO;
    
    self.detector50 = [[ToddSyndromeDetector alloc] initWithPatient:patient50];
    self.detector100 = [[ToddSyndromeDetector alloc] initWithPatient:patient100];
}

- (void)tearDown {
    [super tearDown];
    
    self.patient100 = nil;
    self.patient50 = nil;
    self.detector50 = nil;
    self.detector100 = nil;
}

#pragma mark - Tests

- (void)testOneHundredPercentProbabilityAlgorithm {
    XCTAssertEqual([self.detector100 probability], 100.0);
}

- (void)testFiftyPercentProbabilityAlgorithm {
    XCTAssertEqual([self.detector50 probability], 50.0);
}

- (void)testFailureProbabilityAlgorithm {
    XCTAssertEqual([self.detector50 probability], 25.0);
}

@end
