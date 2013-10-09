//
//  CountTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface CountTests : XCTestCase

@end

@implementation CountTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testCountAll{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Numbers"];
    [table createIntegerColumnWithName:@"number"];
    
    [EasyStore completeDatabaseCreation];
    
    int numEntries = 27;
    for(int i=0; i<numEntries; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:i forColumn:@"number"];
        [EasyStore insert:entry intoTable:@"Numbers"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate countEntriesInTable:@"Numbers"];
    
    int count = [EasyStore countEntriesWithPredicate:predicate];
    
    XCTAssertEqual(count, numEntries, @"Incorrect number of results returned from query");
}



@end
