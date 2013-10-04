//
//  ClearTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface DeleteTests : XCTestCase

@end

@implementation DeleteTests

-(void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

-(void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testClearEasyStore{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Bill" forColumnName:@"name"];
    [entry setNumber:38 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    [EasyStore clearEasyStore];
    entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 0, @"Easy store not properly cleared");
}

- (void)testDeleteEntry{
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
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate deleteFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    [EasyStore deleteEntriesWithPredicate:predicate];
    NSArray* remainingEntries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[remainingEntries count], 1, @"Incorrect number of results returned from query");
}

-(void)deleteUsingIdentityColumn{
    
}

@end
