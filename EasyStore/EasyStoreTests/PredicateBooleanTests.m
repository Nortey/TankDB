//
//  PredicateBooleanTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateBooleanTests : XCTestCase

@end

@implementation PredicateBooleanTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

-(void)testSelectWherePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* names = @[@"Blake", @"Drew", @"Mike", @"Tom"];
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"isValid"];

    entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}


-(void)testAndTruePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"number"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [EasyStore completeDatabaseCreation];
    
    int numbers[] = {1, 2, 3, 4};
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<4; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:numbers[i] forColumn:@"number"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"number" isGreaterThanInteger:2];
    [predicate andColumnIsTrue:@"isValid"];
    
    NSArray *entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
}

-(void)testOrTruePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"number"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [EasyStore completeDatabaseCreation];
    
    int numbers[] = {1, 2, 3, 4};
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<4; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:numbers[i] forColumn:@"number"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"number" isGreaterThanInteger:2];
    [predicate orColumnIsTrue:@"isValid"];
    
    NSArray *entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
}

-(void)testOrFalsePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"number"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [EasyStore completeDatabaseCreation];
    
    int numbers[] = {1, 2, 3, 4};
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<4; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:numbers[i] forColumn:@"number"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"number" equalsInteger:4];
    [predicate orColumnIsFalse:@"isValid"];
    
    NSArray *entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}




/*- (void)testUpdateSingleEntry{
 
    
    NSArray* names = @[@"Bill", @"John", @"Kyle", @"Jake",@"Mike"];
    NSArray* states = @[@"Texas", @"Alabama", @"Delaware", @"California",@"Florida"];
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumnName:@"name"];
        [entry setString:[states objectAtIndex:i] forColumnName:@"state"];
        [EasyStore store:entry intoTable:@"Users"];
    }
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"Users"];
    [predicate setColumn:@"name" toString:@"Paul"];
    [predicate whereColumn:@"state" equalsString:@"Alabama"];
    
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* updatedNames = @[@"Bill", @"Paul", @"Kyle", @"Jake",@"Mike"];
    NSArray* updatedEntries = [EasyStore getAllEntriesForTable:@"Users"];
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* thisEntry = [updatedEntries objectAtIndex:i];
        NSString* thisWord = [thisEntry getStringForColumnName:@"name"];
        XCTAssertEqualObjects(thisWord, [updatedNames objectAtIndex:i], @"Returned strings not correctly updated");
    }
}*/

@end
