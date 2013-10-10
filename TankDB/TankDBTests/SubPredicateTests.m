//
//  SubPredicateTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/5/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface SubPredicateTests : XCTestCase

@end

@implementation SubPredicateTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}


- (void)testAndSubPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"grade"];
    [table createBooleanColumnWithName:@"passed"];
    [table createBooleanColumnWithName:@"registered"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* names = @[@"Kyle", @"Stan", @"Eric", @"Kenny", @"Butters"];
    int grades[] = {3, 45, 55, 100, 234,};
    bool passed[] = {true, true, false, false, false};
    bool registered[] = {true, false, true, false, true};
    
    for(int i=0; i<[names count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setInteger:grades[i] forColumn:@"grade"];
        [entry setBoolean:passed[i] forColumn:@"passed"];
        [entry setBoolean:registered[i] forColumn:@"registered"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"registered"];
    
    TDPredicate* andPredicate = [TDPredicate new];
    [andPredicate whereColumn:@"grade" isGreaterThanInteger:60];
    [andPredicate orColumn:@"grade" isLessThanInteger:40];
    [predicate And:andPredicate];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];

    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    for(TDEntry *entry in entries){
        bool isRegistered = [entry booleanForColumn:@"registered"];
        int grade = [entry integerForColumn:@"grade"];
        XCTAssertTrue( (isRegistered == true && (grade > 60 || grade < 40)), @"Incorrect data returned from query");
    }
}

- (void)testOrSubPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"grade"];
    [table createBooleanColumnWithName:@"passed"];
    [table createBooleanColumnWithName:@"registered"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* names = @[@"Kyle", @"Stan", @"Eric", @"Kenny", @"Butters"];
    int grades[] =      {3,      45,    55,   100,  234,};
    bool passed[] =     {true, true, false, false, false};
    bool registered[] = {true, false, true, false, true};
    
    for(int i=0; i<[names count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setInteger:grades[i] forColumn:@"grade"];
        [entry setBoolean:passed[i] forColumn:@"passed"];
        [entry setBoolean:registered[i] forColumn:@"registered"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"registered"];
    
    TDPredicate* orPredicate = [TDPredicate new];
    [orPredicate whereColumn:@"grade" isGreaterThanInteger:60];
    [orPredicate andColumnIsFalse:@"passed"];
    
    [predicate Or:orPredicate];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    
    XCTAssertEqual((int)[entries count], 4, @"Incorrect number of results returned from query");
    
    for(TDEntry *entry in entries){
        bool isRegistered = [entry booleanForColumn:@"registered"];
        int grade = [entry integerForColumn:@"grade"];
        bool passed = [entry integerForColumn:@"passed"];
        XCTAssertTrue( (isRegistered == true || (grade > 60 && passed == false)), @"Incorrect data returned from query");
    }
}

@end
