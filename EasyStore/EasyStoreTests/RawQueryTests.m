//
//  RawQueryTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface RawQueryTests : XCTestCase

@end

@implementation RawQueryTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testCreateTableUsingRawQuery{
    [EasyStore beginDatabaseCreation];
    
    NSString* createTableQuery = @"CREATE TABLE users ( name TEXT, amount INTEGER )";
    [EasyStore invokeRawQuery:createTableQuery];
    
    XCTAssertTrue([EasyStore getStatus] == Easy_OK, @"Raw SQL query table creation failed");
}

- (void)testInsertUsingRawQuery{
    [EasyStore beginDatabaseCreation];
    
    EasyTable* table = [EasyStore createTableWithName:@"Words"];
    [table createStringColumnWithName:@"word"];
    
    [EasyStore completeDatabaseCreation];
    [EasyStore invokeRawQuery:@"INSERT INTO Words VALUES ( \"hello\" )"];
    
    XCTAssertTrue([EasyStore getStatus] == Easy_OK, @"Raw SQL query table creation failed");
}

- (void)testSelectUsingRawQuery{
//    [EasyStore beginDatabaseCreation];
//    
//    EasyTable* table = [EasyStore createTableWithName:@"Words"];
//    [table createStringColumnWithName:@"word"];
//    
//    [EasyStore completeDatabaseCreation];
//    [EasyStore invokeRawQuery:@"INSERT INTO Words VALUES ( \"hello\" )"];
//    
//    XCTAssertTrue([EasyStore getStatus] == Easy_OK, @"Raw SQL query table creation failed");
}

- (void)testUpdateUsingRawQuery{
    //    [EasyStore beginDatabaseCreation];
    //
    //    EasyTable* table = [EasyStore createTableWithName:@"Words"];
    //    [table createStringColumnWithName:@"word"];
    //
    //    [EasyStore completeDatabaseCreation];
    //    [EasyStore invokeRawQuery:@"INSERT INTO Words VALUES ( \"hello\" )"];
    //
    //    XCTAssertTrue([EasyStore getStatus] == Easy_OK, @"Raw SQL query table creation failed");
}

- (void)testDeleteUsingRawQuery{
    //    [EasyStore beginDatabaseCreation];
    //
    //    EasyTable* table = [EasyStore createTableWithName:@"Words"];
    //    [table createStringColumnWithName:@"word"];
    //
    //    [EasyStore completeDatabaseCreation];
    //    [EasyStore invokeRawQuery:@"INSERT INTO Words VALUES ( \"hello\" )"];
    //
    //    XCTAssertTrue([EasyStore getStatus] == Easy_OK, @"Raw SQL query table creation failed");
}

@end
