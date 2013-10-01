//
//  StoreTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"


@interface StoreTests : XCTestCase

@end

@implementation StoreTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testStoreIntoEasyStore{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    EasyColumn* nameColumn = [table createColumnWithName:@"name" withType:EasyString];
    EasyColumn* amountColumn = [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:45 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    XCTAssertEqualObjects([nameColumn getName], @"name", @"Column name incorrect");
    XCTAssertEqualObjects([amountColumn getName], @"amount", @"Column name incorrect");
    XCTAssertEqual([EasyStore getStatus], Easy_OK, @"Status is not Easy_OK");
}

- (void)testStoreSpecialCharacters{
}

- (void)testTableSpecialCharacters{
    
}

-(void)testStoreIntoTableNotExists{
    
}

-(void)testStoreIntoColumnNotExists{
    
}


@end
