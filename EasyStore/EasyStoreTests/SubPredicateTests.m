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
        [entry setString:[names objectAtIndex:i] forColumnName:@"name"];
        [entry setInteger:grades[i] forColumnName:@"grade"];
        [entry setBoolean:passed[i] forColumnName:@"passed"];
        [entry setBoolean:registered[i] forColumnName:@"registered"];
        [EasyStore store:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"registered"];
    
    EasyPredicate* andPredicate = [EasyPredicate new];
    [andPredicate whereColumn:@"grade" isGreaterThanInteger:60];
    [andPredicate orColumn:@"grade" isLessThanInteger:40];
    [predicate And:andPredicate];
    
    [EasyStore selectEntriesWithPredicate:predicate];
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];

    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    for(EasyEntry *entry in entries){
        bool isRegistered = [entry getBooleanForColumnName:@"registered"];
        int grade = [entry getIntegerForColumnName:@"grade"];
        XCTAssertTrue( (isRegistered == true && (grade > 60 || grade < 40)), @"Incorrect data returned from query");
    }
}

@end
