//
//  RawQueryTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface RawQueryTests : XCTestCase

@end

@implementation RawQueryTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testCreateTableUsingRawQuery{
    [TankDB beginDatabaseCreation];
    
    NSString* createTableQuery = @"CREATE TABLE users ( name TEXT, amount INTEGER )";
    [TankDB invokeRawQuery:createTableQuery];
    
    XCTAssertTrue([TankDB getStatus] == TD_OK, @"Raw SQL query table creation failed");
}

- (void)testInsertUsingRawQuery{
    [TankDB beginDatabaseCreation];
    
    TDTable* table = [TankDB createTableWithName:@"Words"];
    [table createStringColumnWithName:@"word"];
    
    [TankDB completeDatabaseCreation];
    [TankDB invokeRawQuery:@"INSERT INTO Words VALUES ( \"hello\" )"];
    
    XCTAssertTrue([TankDB getStatus] == TD_OK, @"Raw SQL query table creation failed");
}

- (void)testSelectUsingRawQuery{

}

- (void)testUpdateUsingRawQuery{

}

- (void)testDeleteUsingRawQuery{
}

@end
