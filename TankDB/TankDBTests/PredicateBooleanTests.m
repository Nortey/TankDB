//
//  PredicateBooleanTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateBooleanTests : XCTestCase

@end

@implementation PredicateBooleanTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

-(void)testSelectWherePredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* names = @[@"Blake", @"Drew", @"Mike", @"Tom"];
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<[names count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumnIsTrue:@"isValid"];

    entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}


-(void)testAndTruePredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"number"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [TankDB completeDatabaseCreation];
    
    int numbers[] = {1, 2, 3, 4};
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<4; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:numbers[i] forColumn:@"number"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"number" isGreaterThanInteger:2];
    [predicate andColumnIsTrue:@"isValid"];
    
    NSArray *entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
}

-(void)testOrTruePredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"number"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [TankDB completeDatabaseCreation];
    
    int numbers[] = {1, 2, 3, 4};
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<4; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:numbers[i] forColumn:@"number"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"number" isGreaterThanInteger:2];
    [predicate orColumnIsTrue:@"isValid"];
    
    NSArray *entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
}

-(void)testOrFalsePredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"number"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [TankDB completeDatabaseCreation];
    
    int numbers[] = {1, 2, 3, 4};
    bool isValid[] = {true, false, true, false};
    
    for(int i=0; i<4; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:numbers[i] forColumn:@"number"];
        [entry setBoolean:isValid[i] forColumn:@"isValid"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"number" equalsInteger:4];
    [predicate orColumnIsFalse:@"isValid"];
    
    NSArray *entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}




/*- (void)testUpdateSingleEntry{
 
    
   
}*/

@end
