//
//  TankDBTests.m
//  TankDBTests
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"
#import "TDColumn.h"

@interface CreateTests : XCTestCase

@end

@implementation CreateTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testCreateTableAndColumns{
    TDTable *table = [TankDB createTableWithName:@"Users"];
    TDColumn* nameColumn = [table createColumnWithName:@"name" withType:TDString];
    TDColumn* amountColumn = [table createColumnWithName:@"amount" withType:TDInteger];
    
    XCTAssertEqualObjects([nameColumn getName], @"name", @"Column name incorrect");
    XCTAssertEqualObjects([amountColumn getName], @"amount", @"Column name incorrect");
    
    XCTAssertEqual([nameColumn getType], TDString, @"Column type incorrect");
    XCTAssertEqual([amountColumn getType], TDInteger, @"Column type incorrect");
}

- (void)testCreateTankDB{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Status is not TD_OK");
    XCTAssertEqualObjects([TankDB getErrorMessage], @"", @"Error message is not empty");
}

- (void)testCreateTableWithIdentity{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    TDColumn* identityColumn = [table createColumnWithName:@"id" withType:TDInteger];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [identityColumn setAsIdentityColumn];
    
    [TankDB completeDatabaseCreation];
    
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Status is not TD_OK");
    XCTAssertEqualObjects([TankDB getErrorMessage], @"", @"Error message is not empty");
}

- (void)testCreateTableWithBuiltInIdentity{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    
    [table addIdentityColumn];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Status is not TD_OK");
    XCTAssertEqualObjects([TankDB getErrorMessage], @"", @"Error message is not empty");
}

- (void)testCreateTableWithPrimaryKey{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    
    [[table createColumnWithName:@"name" withType:TDString] setAsPrimaryKey];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Status is not TD_OK");
    XCTAssertEqualObjects([TankDB getErrorMessage], @"", @"Error message is not empty");
}



@end
