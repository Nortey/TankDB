//
//  SubPredicateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/5/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface SubPredicateTests : XCTestCase

@end

@implementation SubPredicateTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}


- (void)testAndSubPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"grade"];
    [table createBooleanColumnWithName:@"passed"];
    [table createBooleanColumnWithName:@"registered"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* names = @[@"Kyle", @"Stan", @"Eric", @"Kenny", @"Butters"];
    int grades[] = {3, 45, 55, 100, 234,};
    bool passed[] = {true, true, false, false, false};
    bool registered[] = {true, false, true, false, true};
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setInteger:grades[i] forColumn:@"grade"];
        [entry setBoolean:passed[i] forColumn:@"passed"];
        [entry setBoolean:registered[i] forColumn:@"registered"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"registered"];
    
    EasyPredicate* andPredicate = [EasyPredicate new];
    [andPredicate whereColumn:@"grade" isGreaterThanInteger:60];
    [andPredicate orColumn:@"grade" isLessThanInteger:40];
    [predicate And:andPredicate];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];

    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    for(EasyEntry *entry in entries){
        bool isRegistered = [entry booleanForColumn:@"registered"];
        int grade = [entry integerForColumn:@"grade"];
        XCTAssertTrue( (isRegistered == true && (grade > 60 || grade < 40)), @"Incorrect data returned from query");
    }
}

- (void)testOrSubPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"grade"];
    [table createBooleanColumnWithName:@"passed"];
    [table createBooleanColumnWithName:@"registered"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* names = @[@"Kyle", @"Stan", @"Eric", @"Kenny", @"Butters"];
    int grades[] =      {3,      45,    55,   100,  234,};
    bool passed[] =     {true, true, false, false, false};
    bool registered[] = {true, false, true, false, true};
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setInteger:grades[i] forColumn:@"grade"];
        [entry setBoolean:passed[i] forColumn:@"passed"];
        [entry setBoolean:registered[i] forColumn:@"registered"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"registered"];
    
    EasyPredicate* orPredicate = [EasyPredicate new];
    [orPredicate whereColumn:@"grade" isGreaterThanInteger:60];
    [orPredicate andColumnIsFalse:@"passed"];
    
    [predicate Or:orPredicate];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    
    XCTAssertEqual((int)[entries count], 4, @"Incorrect number of results returned from query");
    
    for(EasyEntry *entry in entries){
        bool isRegistered = [entry booleanForColumn:@"registered"];
        int grade = [entry integerForColumn:@"grade"];
        bool passed = [entry integerForColumn:@"passed"];
        XCTAssertTrue( (isRegistered == true || (grade > 60 && passed == false)), @"Incorrect data returned from query");
    }
}

@end
