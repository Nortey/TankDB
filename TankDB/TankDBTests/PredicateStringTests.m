//
//  PredicateTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateStringTests : XCTestCase

@end

@implementation PredicateStringTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testWherePredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"name"], @"Blake", @"Incorrect entry returned from query");
}

- (void)testOrPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    [predicate orColumn:@"name" equalsString:@"Dan"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    TDEntry* firstEntry = [entries objectAtIndex:0];
    BOOL correct = [@"Blake" isEqualToString:[firstEntry stringForColumn:@"name"]] || [@"Dan" isEqualToString:[firstEntry stringForColumn:@"name"]];
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    TDEntry* secondEntry = [entries objectAtIndex:0];
    correct = [@"Blake" isEqualToString:[secondEntry stringForColumn:@"name"]] || [@"Dan" isEqualToString:[secondEntry stringForColumn:@"name"]];
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

- (void)testAndPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"state" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"Kyle" forColumn:@"name"];
    [entry setString:@"Texas" forColumn:@"state"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Kyle" forColumn:@"name"];
    [entry2 setString:@"Alabama" forColumn:@"state"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Kyle" forColumn:@"name"];
    [entry3 setString:@"Denver" forColumn:@"state"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Kyle"];
    [predicate andColumn:@"state" equalsString:@"Texas"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"name"], @"Kyle", @"Incorrect entry returned from query");
    XCTAssertEqualObjects([singleEntry stringForColumn:@"state"], @"Texas", @"Incorrect entry returned from query");
}

- (void)testContainsStringPrefix{
    // TODO TEST
}

- (void)testContainsStringSuffix{
    // TODO TEST
}

- (void)testContainsString{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"abcdefghijlkmno" forColumn:@"word"];
    [TankDB insert:entry intoTable:@"Words"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"aaaaaaaaaaaaaaa" forColumn:@"word"];
    [TankDB insert:entry2 intoTable:@"Words"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"123456789" forColumn:@"word"];
    [TankDB insert:entry3 intoTable:@"Words"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate whereColumn:@"word" containsString:@"fgh"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"word"], @"abcdefghijlkmno", @"Incorrect entry returned from query");
}

- (void)testAndContainsString{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"abcdefghijlkmno" forColumn:@"word"];
    [TankDB insert:entry intoTable:@"Words"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"aaaaaaaaaaaaaaa" forColumn:@"word"];
    [TankDB insert:entry2 intoTable:@"Words"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"123456789" forColumn:@"word"];
    [TankDB insert:entry3 intoTable:@"Words"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate whereColumn:@"word" containsString:@"234"];
    [predicate andColumn:@"word" containsString:@"678"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"word"], @"123456789", @"Incorrect entry returned from query");
}

- (void)testOrContainsString{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"abcdefghijlkmno" forColumn:@"word"];
    [TankDB insert:entry intoTable:@"Words"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"aaaaaaaaaaaaaaa" forColumn:@"word"];
    [TankDB insert:entry2 intoTable:@"Words"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"123456789" forColumn:@"word"];
    [TankDB insert:entry3 intoTable:@"Words"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate whereColumn:@"word" containsString:@"234"];
    [predicate orColumn:@"word" containsString:@"aaa"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}



@end
