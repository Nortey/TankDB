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

- (void)testDeleteDatabaseFile{
    
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    [EasyStore deleteDatabaseFile];
    XCTAssertEqual([EasyStore getStatus], Easy_OK, @"Database file not correctly deleted");
}

- (void)testClearEasyStore{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Bill" forColumn:@"name"];
    [entry setInteger:38 forColumn:@"amount"];
    [EasyStore insert:entry intoTable:@"Users"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    [EasyStore clearEasyStore];
    entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 0, @"Easy store not properly cleared");
}

- (void)testDeleteEntry{
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
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate deleteFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Blake"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    [EasyStore deleteEntriesWithPredicate:predicate];
    NSArray* remainingEntries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[remainingEntries count], 1, @"Incorrect number of results returned from query");
}

-(void)testDeleteUsingIdentityColumn{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Schools"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"name"];
    [table createBooleanColumnWithName:@"funded"];
    [EasyStore completeDatabaseCreation];
    
    NSArray* names = @[@"Leander", @"Cedar Park", @"Westwood", @"Austin High", @"Coronado", @"Morehead"];
    bool funded[] = {true, false, true, false, true, false};
    
    for (int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setBoolean:funded[i] forColumn:@"funded"];
        [EasyStore insert:entry intoTable:@"Schools"];
    }
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Schools"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    EasyPredicate* predicate = [EasyPredicate new];
    [predicate deleteFromTable:@"Schools"];
    [predicate whereColumn:@"id" isGreaterThanInteger:3];
    
    [EasyStore deleteEntriesWithPredicate:predicate];
    entries = [EasyStore selectAllEntriesForTable:@"Schools"];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
}

@end
