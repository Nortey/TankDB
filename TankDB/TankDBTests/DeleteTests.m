//
//  ClearTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface DeleteTests : XCTestCase

@end

@implementation DeleteTests

-(void)setUp{
    [super setUp];
    [TankDB clear];
}

-(void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testDeleteDatabaseFile{
    
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    [TankDB deleteDatabaseFile];
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Database file not correctly deleted");
}

- (void)testClear{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"Bill" forColumn:@"name"];
    [entry setInteger:38 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly");
    
    [TankDB clear];
    entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 0, @"DB not properly cleared");
}

- (void)testDeleteEntry{
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
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate deleteFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    [TankDB deleteEntriesWithPredicate:predicate];
    NSArray* remainingEntries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[remainingEntries count], 1, @"Incorrect number of results returned from query");
}

-(void)testDeleteUsingIdentityColumn{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Schools"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"name"];
    [table createBooleanColumnWithName:@"funded"];
    [TankDB completeDatabaseCreation];
    
    NSArray* names = @[@"Leander", @"Cedar Park", @"Westwood", @"Austin High", @"Coronado", @"Morehead"];
    bool funded[] = {true, false, true, false, true, false};
    
    for (int i=0; i<[names count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setBoolean:funded[i] forColumn:@"funded"];
        [TankDB insert:entry intoTable:@"Schools"];
    }
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Schools"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    TDPredicate* predicate = [TDPredicate new];
    [predicate deleteFromTable:@"Schools"];
    [predicate whereColumn:@"id" isGreaterThanInteger:3];
    
    [TankDB deleteEntriesWithPredicate:predicate];
    entries = [TankDB selectAllEntriesForTable:@"Schools"];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
}

@end
