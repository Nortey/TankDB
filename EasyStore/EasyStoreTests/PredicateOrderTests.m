//
//  TestPredicateOrder.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/2/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateOrderTests : XCTestCase

@end

@implementation PredicateOrderTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testOrderByStringAscending{
    [EasyStore beginDatabaseCreation];

    EasyTable *table = [EasyStore createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* words = @[@"zzzzzz", @"aaaa", @"eeeeee", @"ttttttt", @"oooooo"];
    
    for(NSString* word in words){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:word forColumnName:@"word"];
        [EasyStore store:entry intoTable:@"Words"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate orderAscendingByColumn:@"word"];

    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    NSArray* orderedWords = @[@"aaaa", @"eeeeee", @"oooooo", @"ttttttt", @"zzzzzz"];
    
    XCTAssertEqual([entries count], [words count], @"Incorrect number of results returned from query");
    
    for(int i=0; i<[words count]; i++){
        EasyEntry* thisEntry = [entries objectAtIndex:i];
        NSString* thisWord = [thisEntry getStringForColumnName:@"word"];
        XCTAssertEqualObjects(thisWord, [orderedWords objectAtIndex:i], @"Strings not correctly returned in ascending order");
    }
}

- (void)testOrderByStringDescending{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Words"];
    [table createColumnWithName:@"word" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* words = @[@"zzzzzz", @"aaaa", @"eeeeee", @"ttttttt", @"oooooo"];
    
    for(NSString* word in words){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:word forColumnName:@"word"];
        [EasyStore store:entry intoTable:@"Words"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate orderDescendingByColumn:@"word"];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    NSArray* orderedWords = @[@"zzzzzz", @"ttttttt", @"oooooo", @"eeeeee", @"aaaa"];
    
    XCTAssertEqual([entries count], [words count], @"Incorrect number of results returned from query");
    
    for(int i=0; i<[words count]; i++){
        EasyEntry* thisEntry = [entries objectAtIndex:i];
        NSString* thisWord = [thisEntry getStringForColumnName:@"word"];
        XCTAssertEqualObjects(thisWord, [orderedWords objectAtIndex:i], @"Strings not correctly returned in ascending order");
    }
}

@end
