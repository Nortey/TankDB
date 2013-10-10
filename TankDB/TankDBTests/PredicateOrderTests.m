//
//  TestPredicateOrder.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/2/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateOrderTests : XCTestCase

@end

@implementation PredicateOrderTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testOrderByStringAscending{
    [TankDB beginDatabaseCreation];

    TDTable *table = [TankDB createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* words = @[@"zzzzzz", @"aaaa", @"eeeeee", @"ttttttt", @"oooooo"];
    
    for(NSString* word in words){
        TDEntry* entry = [TDEntry new];
        [entry setString:word forColumn:@"word"];
        [TankDB insert:entry intoTable:@"Words"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate orderAscendingByColumn:@"word"];

    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    NSArray* orderedWords = @[@"aaaa", @"eeeeee", @"oooooo", @"ttttttt", @"zzzzzz"];
    
    XCTAssertEqual([entries count], [words count], @"Incorrect number of results returned from query");
    
    for(int i=0; i<[words count]; i++){
        TDEntry* thisEntry = [entries objectAtIndex:i];
        NSString* thisWord = [thisEntry stringForColumn:@"word"];
        XCTAssertEqualObjects(thisWord, [orderedWords objectAtIndex:i], @"Strings not correctly returned in ascending order");
    }
}

- (void)testOrderByStringDescending{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* words = @[@"zzzzzz", @"aaaa", @"eeeeee", @"ttttttt", @"oooooo"];
    
    for(NSString* word in words){
        TDEntry* entry = [TDEntry new];
        [entry setString:word forColumn:@"word"];
        [TankDB insert:entry intoTable:@"Words"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate orderDescendingByColumn:@"word"];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    NSArray* orderedWords = @[@"zzzzzz", @"ttttttt", @"oooooo", @"eeeeee", @"aaaa"];
    
    XCTAssertEqual([entries count], [words count], @"Incorrect number of results returned from query");
    
    for(int i=0; i<[words count]; i++){
        TDEntry* thisEntry = [entries objectAtIndex:i];
        NSString* thisWord = [thisEntry stringForColumn:@"word"];
        XCTAssertEqualObjects(thisWord, [orderedWords objectAtIndex:i], @"Strings not correctly returned in ascending order");
    }
}

@end
