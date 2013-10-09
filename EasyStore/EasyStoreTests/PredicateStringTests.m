//
//  PredicateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateStringTests : XCTestCase

@end

@implementation PredicateStringTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testWherePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [EasyStore insert:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [EasyStore insert:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [EasyStore insert:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"name"], @"Blake", @"Incorrect entry returned from query");
}

- (void)testOrPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [EasyStore insert:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [EasyStore insert:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [EasyStore insert:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    [predicate orColumn:@"name" equalsString:@"Dan"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    BOOL correct = [@"Blake" isEqualToString:[firstEntry stringForColumn:@"name"]] || [@"Dan" isEqualToString:[firstEntry stringForColumn:@"name"]];
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    EasyEntry* secondEntry = [entries objectAtIndex:0];
    correct = [@"Blake" isEqualToString:[secondEntry stringForColumn:@"name"]] || [@"Dan" isEqualToString:[secondEntry stringForColumn:@"name"]];
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

- (void)testAndPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"state" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Kyle" forColumn:@"name"];
    [entry setString:@"Texas" forColumn:@"state"];
    [EasyStore insert:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Kyle" forColumn:@"name"];
    [entry2 setString:@"Alabama" forColumn:@"state"];
    [EasyStore insert:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Kyle" forColumn:@"name"];
    [entry3 setString:@"Denver" forColumn:@"state"];
    [EasyStore insert:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Kyle"];
    [predicate andColumn:@"state" equalsString:@"Texas"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
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
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"abcdefghijlkmno" forColumn:@"word"];
    [EasyStore insert:entry intoTable:@"Words"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"aaaaaaaaaaaaaaa" forColumn:@"word"];
    [EasyStore insert:entry2 intoTable:@"Words"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"123456789" forColumn:@"word"];
    [EasyStore insert:entry3 intoTable:@"Words"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate whereColumn:@"word" containsString:@"fgh"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"word"], @"abcdefghijlkmno", @"Incorrect entry returned from query");
}

- (void)testAndContainsString{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"abcdefghijlkmno" forColumn:@"word"];
    [EasyStore insert:entry intoTable:@"Words"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"aaaaaaaaaaaaaaa" forColumn:@"word"];
    [EasyStore insert:entry2 intoTable:@"Words"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"123456789" forColumn:@"word"];
    [EasyStore insert:entry3 intoTable:@"Words"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate whereColumn:@"word" containsString:@"234"];
    [predicate andColumn:@"word" containsString:@"678"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry stringForColumn:@"word"], @"123456789", @"Incorrect entry returned from query");
}

- (void)testOrContainsString{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"abcdefghijlkmno" forColumn:@"word"];
    [EasyStore insert:entry intoTable:@"Words"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"aaaaaaaaaaaaaaa" forColumn:@"word"];
    [EasyStore insert:entry2 intoTable:@"Words"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"123456789" forColumn:@"word"];
    [EasyStore insert:entry3 intoTable:@"Words"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate whereColumn:@"word" containsString:@"234"];
    [predicate orColumn:@"word" containsString:@"aaa"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}



@end
