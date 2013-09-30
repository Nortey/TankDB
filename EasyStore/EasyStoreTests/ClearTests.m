//
//  ClearTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface ClearTests : XCTestCase

@end

@implementation ClearTests

-(void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

-(void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testClearEasyStore{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Bill" forColumnName:@"name"];
    [entry setNumber:38 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    NSArray* entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Entry not properly stored in EasyStore");
    
    [EasyStore clearEasyStore];
    entries = [EasyStore getAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 0, @"Easy store not properly cleared");
}

@end
