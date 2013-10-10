//
//  StoreTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"


@interface StoreTests : XCTestCase

@end

@implementation StoreTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testStoreIntoDB{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    TDColumn* nameColumn = [table createColumnWithName:@"name" withType:TDString];
    TDColumn* amountColumn = [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:45 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    XCTAssertEqualObjects([nameColumn getName], @"name", @"Column name incorrect");
    XCTAssertEqualObjects([amountColumn getName], @"amount", @"Column name incorrect");
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Status is not TD_OK");
}

- (void)testStoreBooleanIntoDB{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    TDColumn* firstColumn = [table createBooleanColumnWithName:@"isValid"];
    TDColumn* secondColumn = [table createBooleanColumnWithName:@"isSuccessful"];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setBoolean:TRUE forColumn:@"isValid"];
    [entry setBoolean:FALSE forColumn:@"isSuccessful"];
    [TankDB insert:entry intoTable:@"Users"];
    
    XCTAssertEqualObjects([firstColumn getName], @"isValid", @"Column name incorrect");
    XCTAssertEqualObjects([secondColumn getName], @"isSuccessful", @"Column name incorrect");
    XCTAssertEqual([TankDB getStatus], TD_OK, @"Status is not TD_OK");
}


- (void)testStoreSpecialCharacters{
}

- (void)testTableSpecialCharacters{
    
}

-(void)testStoreIntoTableNotExists{
    
}

-(void)testStoreIntoColumnNotExists{
    
}

-(void)testPrimaryKeyUniqueness{
    
}


@end
