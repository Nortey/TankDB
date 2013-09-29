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

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testStoreIntoEasyStore{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    EasyColumn* nameColumn = [table createColumnWithName:@"name" withType:EasyString];
    EasyColumn* amountColumn = [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    NSDictionary* dic = @{@"name": @"John", @"amount": [NSNumber numberWithInt:89] };
    [EasyStore store:dic intoTable:@"Users"];
    
    XCTAssertEqualObjects([nameColumn getName], @"name", @"Column name incorrect");
    XCTAssertEqualObjects([amountColumn getName], @"amount", @"Column name incorrect");
}

@end
