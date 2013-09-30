//
//  PredicateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateTests : XCTestCase

@end

@implementation PredicateTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testWherePredicate{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    
    NSArray* entries = [EasyStore selectEntriesFromTable:@"Users" withPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    NSMutableDictionary* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry valueForKey:@"name"], @"Blake", @"Incorrect entry returned from query");
}

- (void)testOrPredicate{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    [predicate orColumnName:@"name" equalsString:@"Dan"];
    
    NSArray* entries = [EasyStore selectEntriesFromTable:@"Users" withPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    NSMutableDictionary* firstEntry = [entries objectAtIndex:0];
    BOOL correct = [@"Blake" isEqualToString:[firstEntry valueForKey:@"name"]] || [@"Dan" isEqualToString:[firstEntry valueForKey:@"name"]];
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    NSMutableDictionary* secondEntry = [entries objectAtIndex:0];
    correct = [@"Blake" isEqualToString:[secondEntry valueForKey:@"name"]] || [@"Dan" isEqualToString:[secondEntry valueForKey:@"name"]];
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

- (void)testAndPredicate{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"state" withType:EasyString];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Kyle" forColumnName:@"name"];
    [entry setString:@"Texas" forColumnName:@"state"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Kyle" forColumnName:@"name"];
    [entry setString:@"Alabama" forColumnName:@"state"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Kyle" forColumnName:@"name"];
    [entry setString:@"Denver" forColumnName:@"state"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate whereColumn:@"name" equalsString:@"Kyle"];
    [predicate andColumnName:@"state" equalsString:@"Texas"];
    
    NSArray* entries = [EasyStore selectEntriesFromTable:@"Users" withPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    NSMutableDictionary* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqualObjects([singleEntry valueForKey:@"name"], @"Kyle", @"Incorrect entry returned from query");
    XCTAssertEqualObjects([singleEntry valueForKey:@"state"], @"Texas", @"Incorrect entry returned from query");
}

@end
