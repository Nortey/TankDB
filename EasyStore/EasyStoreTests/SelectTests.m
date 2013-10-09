//
//  SelectTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface SelectTests : XCTestCase

@end

@implementation SelectTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testGetAllEntries{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:45 forColumn:@"amount"];
    [EasyStore insert:entry intoTable:@"Users"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* entryName = [selectedEntry stringForColumn:@"name"];
    int amount = [selectedEntry integerForColumn:@"amount"];
    
    XCTAssertEqualObjects(entryName, @"John", @"Name not properly stored in EasyStore");
    XCTAssertEqual(amount, 45, @"Amount not properly stored in EasyStore");
}

-(void)testSelectUpperToLowerCase{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"SELECTTESTS"];
    [table createColumnWithName:@"FIRSTCOLUMN" withType:EasyString];
    [table createColumnWithName:@"SECONDCOLUMN" withType:EasyInteger];
    [table createColumnWithName:@"THIRDCOLUMN" withType:EasyString];
    [table createColumnWithName:@"FOURTHCOLUMN" withType:EasyInteger];

    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"firstValue" forColumn:@"firstcolumn"];
    [entry setInteger:383 forColumn:@"secondcolumn"];
    [entry setString:@"thirdValue" forColumn:@"thirdcolumn"];
    [entry setInteger:2001 forColumn:@"fourthcolumn"];
    [EasyStore insert:entry intoTable:@"selecttests"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"selecttests"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
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
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"selecttests"];
    [table createColumnWithName:@"firstcolumn" withType:EasyString];
    [table createColumnWithName:@"secondcolumn" withType:EasyInteger];
    [table createColumnWithName:@"thirdcolumn" withType:EasyString];
    [table createColumnWithName:@"fourthcolumn" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"firstValue" forColumn:@"FIRSTCOLUMN"];
    [entry setInteger:383 forColumn:@"SECONDCOLUMN"];
    [entry setString:@"thirdValue" forColumn:@"THIRDCOLUMN"];
    [entry setInteger:2001 forColumn:@"FOURTHCOLUMN"];
    [EasyStore insert:entry intoTable:@"SELECTTESTS"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"SELECTTESTS"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
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
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Characters"];
    [table createColumnWithName:@"firstColumn" withType:EasyString];
    [table createColumnWithName:@"secondColumn" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"(){}[].;:?/|'" forColumn:@"firstColumn"];
    //[entry setNumber:45 forColumnName:@"secondColumn"];
    [EasyStore insert:entry intoTable:@"Characters"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Characters"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* entryFirstColumn = [selectedEntry stringForColumn:@"firstColumn"];
    //int amount = [selectedEntry getNumberForColumnName:@"amount"];
    
    XCTAssertEqualObjects(entryFirstColumn, @"(){}[].;:?/|'", @"Name not properly stored in EasyStore");
    //XCTAssertEqual(amount, 45, @"Amount not properly stored in EasyStore");
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
