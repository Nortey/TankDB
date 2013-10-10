//
//  CountTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface CountTests : XCTestCase

@end

@implementation CountTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testCountAll{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Numbers"];
    [table createIntegerColumnWithName:@"number"];
    
    [TankDB completeDatabaseCreation];
    
    int numEntries = 27;
    for(int i=0; i<numEntries; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:i forColumn:@"number"];
        [TankDB insert:entry intoTable:@"Numbers"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate countEntriesInTable:@"Numbers"];
    
    int count = [TankDB countEntriesWithPredicate:predicate];
    
    XCTAssertEqual(count, numEntries, @"Incorrect number of results returned from query");
}



@end
