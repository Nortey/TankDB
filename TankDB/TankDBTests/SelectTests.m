//
//  SelectTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface SelectTests : XCTestCase

@end

@implementation SelectTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testGetAllEntries{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:45 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored");
    
    TDEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* entryName = [selectedEntry stringForColumn:@"name"];
    int amount = [selectedEntry integerForColumn:@"amount"];
    
    XCTAssertEqualObjects(entryName, @"John", @"Name not properly stored");
    XCTAssertEqual(amount, 45, @"Amount not properly stored");
}

-(void)testSelectUpperToLowerCase{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"SELECTTESTS"];
    [table createColumnWithName:@"FIRSTCOLUMN" withType:TDString];
    [table createColumnWithName:@"SECONDCOLUMN" withType:TDInteger];
    [table createColumnWithName:@"THIRDCOLUMN" withType:TDString];
    [table createColumnWithName:@"FOURTHCOLUMN" withType:TDInteger];

    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"firstValue" forColumn:@"firstcolumn"];
    [entry setInteger:383 forColumn:@"secondcolumn"];
    [entry setString:@"thirdValue" forColumn:@"thirdcolumn"];
    [entry setInteger:2001 forColumn:@"fourthcolumn"];
    [TankDB insert:entry intoTable:@"selecttests"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"selecttests"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored");
    
    TDEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* firstEntry = [selectedEntry stringForColumn:@"firstcolumn"];
    int secondEntry = [selectedEntry integerForColumn:@"secondcolumn"];
    NSString* thirdEntry = [selectedEntry stringForColumn:@"thirdcolumn"];
    int fourthEntry = [selectedEntry integerForColumn:@"fourthcolumn"];
    
    XCTAssertEqualObjects(firstEntry, @"firstValue", @"Entry not properly stored");
    XCTAssertEqual(secondEntry, 383, @"Entry not properly stored");
    XCTAssertEqualObjects(thirdEntry, @"thirdValue", @"Entry not properly stored");
    XCTAssertEqual(fourthEntry, 2001, @"Entry not properly stored");
}

-(void)testSelectLowerToUpperCase{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"selecttests"];
    [table createColumnWithName:@"firstcolumn" withType:TDString];
    [table createColumnWithName:@"secondcolumn" withType:TDInteger];
    [table createColumnWithName:@"thirdcolumn" withType:TDString];
    [table createColumnWithName:@"fourthcolumn" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"firstValue" forColumn:@"FIRSTCOLUMN"];
    [entry setInteger:383 forColumn:@"SECONDCOLUMN"];
    [entry setString:@"thirdValue" forColumn:@"THIRDCOLUMN"];
    [entry setInteger:2001 forColumn:@"FOURTHCOLUMN"];
    [TankDB insert:entry intoTable:@"SELECTTESTS"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"SELECTTESTS"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored");
    
    TDEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* firstEntry = [selectedEntry stringForColumn:@"FIRSTCOLUMN"];
    int secondEntry = [selectedEntry integerForColumn:@"SECONDCOLUMN"];
    NSString* thirdEntry = [selectedEntry stringForColumn:@"THIRDCOLUMN"];
    int fourthEntry = [selectedEntry integerForColumn:@"FOURTHCOLUMN"];
    
    XCTAssertEqualObjects(firstEntry, @"firstValue", @"Entry not properly stored");
    XCTAssertEqual(secondEntry, 383, @"Entry not properly stored");
    XCTAssertEqualObjects(thirdEntry, @"thirdValue", @"Entry not properly stored");
    XCTAssertEqual(fourthEntry, 2001, @"Entry not properly stored");
}

- (void)testGetSpecialCharacters{
    // TODO more special characters
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Characters"];
    [table createColumnWithName:@"firstColumn" withType:TDString];
    [table createColumnWithName:@"secondColumn" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"(){}[].;:?/|'" forColumn:@"firstColumn"];
    [TankDB insert:entry intoTable:@"Characters"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Characters"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored");
    
    TDEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* entryFirstColumn = [selectedEntry stringForColumn:@"firstColumn"];
    
    XCTAssertEqualObjects(entryFirstColumn, @"(){}[].;:?/|'", @"Name not properly stored");
}

-(void)testSelectSomeColumnsEmpty{
    // TODO TEST
}

-(void)testSelectMixedCase{
    // TODO TEST
}

-(void)testSelectTableNotExists{
    // TODO TEST
}

-(void)testSelectColumnNotExists{
    // TODO TEST
}

-(void)testGetNumbersAsStrings{
    // TODO TEST
}



@end
