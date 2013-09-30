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
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:45 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* entryName = [selectedEntry getStringForColumnName:@"name"];
    int amount = [selectedEntry getNumberForColumnName:@"amount"];
    
    XCTAssertEqualObjects(entryName, @"John", @"Name not properly stored in EasyStore");
    XCTAssertEqual(amount, 45, @"Amount not properly stored in EasyStore");
}

-(void)testSelectUpperToLowerCase{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"SELECTTESTS"];
    [table createColumnWithName:@"FIRSTCOLUMN" withType:EasyString];
    [table createColumnWithName:@"SECONDCOLUMN" withType:EasyNumber];
    [table createColumnWithName:@"THIRDCOLUMN" withType:EasyString];
    [table createColumnWithName:@"FOURTHCOLUMN" withType:EasyNumber];

    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"firstValue" forColumnName:@"firstcolumn"];
    [entry setNumber:383 forColumnName:@"secondcolumn"];
    [entry setString:@"thirdValue" forColumnName:@"thirdcolumn"];
    [entry setNumber:2001 forColumnName:@"fourthcolumn"];
    [EasyStore store:entry intoTable:@"selecttests"];
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"selecttests"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* firstEntry = [selectedEntry getStringForColumnName:@"firstcolumn"];
    int secondEntry = [selectedEntry getNumberForColumnName:@"secondcolumn"];
    NSString* thirdEntry = [selectedEntry getStringForColumnName:@"thirdcolumn"];
    int fourthEntry = [selectedEntry getNumberForColumnName:@"fourthcolumn"];
    
    XCTAssertEqualObjects(firstEntry, @"firstValue", @"Entry not properly stored");
    XCTAssertEqual(secondEntry, 383, @"Entry not properly stored");
    XCTAssertEqualObjects(thirdEntry, @"thirdValue", @"Entry not properly stored");
    XCTAssertEqual(fourthEntry, 2001, @"Entry not properly stored");
}

-(void)testSelectLowerToUpperCase{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"selecttests"];
    [table createColumnWithName:@"firstcolumn" withType:EasyString];
    [table createColumnWithName:@"secondcolumn" withType:EasyNumber];
    [table createColumnWithName:@"thirdcolumn" withType:EasyString];
    [table createColumnWithName:@"fourthcolumn" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"firstValue" forColumnName:@"FIRSTCOLUMN"];
    [entry setNumber:383 forColumnName:@"SECONDCOLUMN"];
    [entry setString:@"thirdValue" forColumnName:@"THIRDCOLUMN"];
    [entry setNumber:2001 forColumnName:@"FOURTHCOLUMN"];
    [EasyStore store:entry intoTable:@"SELECTTESTS"];
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"SELECTTESTS"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    EasyEntry* selectedEntry = [entries objectAtIndex:0];
    NSString* firstEntry = [selectedEntry getStringForColumnName:@"FIRSTCOLUMN"];
    int secondEntry = [selectedEntry getNumberForColumnName:@"SECONDCOLUMN"];
    NSString* thirdEntry = [selectedEntry getStringForColumnName:@"THIRDCOLUMN"];
    int fourthEntry = [selectedEntry getNumberForColumnName:@"FOURTHCOLUMN"];
    
    XCTAssertEqualObjects(firstEntry, @"firstValue", @"Entry not properly stored");
    XCTAssertEqual(secondEntry, 383, @"Entry not properly stored");
    XCTAssertEqualObjects(thirdEntry, @"thirdValue", @"Entry not properly stored");
    XCTAssertEqual(fourthEntry, 2001, @"Entry not properly stored");
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

@end