//
//  PredicateDateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/4/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateDateTests : XCTestCase

@end

@implementation PredicateDateTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

-(void)testUpdate{
    
}

-(void)testWherePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createDateColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* now = [NSDate date];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setDate:now forColumnName:@"date"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"date" equalsDate:now];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertTrue((int)[now timeIntervalSinceDate:[thisEntry getDateForColumnName:@"date"]] == 0, @"Incorrect date returned from query");
}

@end
