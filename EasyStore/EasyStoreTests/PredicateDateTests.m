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

-(void)testWhereEqualsPredicate{
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

-(void)testStoreDateAsNow{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Date"];
    [table createDateColumnWithName:@"date"];
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    NSDate* now = [NSDate date];
    [entry setDateAsNowForColumnName:@"date"];
    [EasyStore store:entry intoTable:@"Date"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Date"];
    EasyEntry* storedEntry = [entries objectAtIndex:0];
    NSDate* storedDate = [storedEntry getDateForColumnName:@"date"];
    
    XCTAssertTrue(abs([now timeIntervalSince1970] - [storedDate timeIntervalSince1970]) < 3, @"Column name incorrect");
}

@end
