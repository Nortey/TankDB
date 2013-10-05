//
//  UpdateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface UpdateTests : XCTestCase

@end

@implementation UpdateTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testUpdateSingleEntry{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createStringColumnWithName:@"state"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* names = @[@"Bill", @"John", @"Kyle", @"Jake",@"Mike"];
    NSArray* states = @[@"Texas", @"Alabama", @"Delaware", @"California",@"Florida"];
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumnName:@"name"];
        [entry setString:[states objectAtIndex:i] forColumnName:@"state"];
        [EasyStore store:entry intoTable:@"Users"];
    }
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"Users"];
    [predicate setColumn:@"name" toString:@"Paul"];
    [predicate whereColumn:@"state" equalsString:@"Alabama"];
    
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* updatedNames = @[@"Bill", @"Paul", @"Kyle", @"Jake",@"Mike"];
    NSArray* updatedEntries = [EasyStore selectAllEntriesForTable:@"Users"];
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* thisEntry = [updatedEntries objectAtIndex:i];
        NSString* thisWord = [thisEntry getStringForColumnName:@"name"];
        XCTAssertEqualObjects(thisWord, [updatedNames objectAtIndex:i], @"Returned strings not correctly updated");
    }
}

- (void)testUpdateAllEntries{
    
}

@end
