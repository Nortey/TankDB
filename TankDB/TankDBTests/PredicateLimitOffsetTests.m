//
//  PredicateLimitOffsetTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/5/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateLimitOffsetTests : XCTestCase

@end

@implementation PredicateLimitOffsetTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testLimit{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"GIBBERISH"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"number"];
    
    [TankDB completeDatabaseCreation];
    
    for(int i=0; i<20; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:i * 23 forColumn:@"number"];
        [TankDB insert:entry intoTable:@"GIBBERISH"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"GIBBERISH"];
    [predicate withLimit:5];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 5, @"Incorrect number of results returned from query");
}

- (void)testOffset{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"GIBBERISH"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"number"];
    
    [TankDB completeDatabaseCreation];
    
    for(int i=0; i<20; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:i * 23 forColumn:@"number"];
        [TankDB insert:entry intoTable:@"GIBBERISH"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"GIBBERISH"];
    [predicate withLimit:20 andOffset:5];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 15, @"Incorrect number of results returned from query");
}

-(void)testLimitWithOrderBy{
    
}

-(void)testOrderByInteger{
    
}

-(void)testOrderByFloat{
    
}

-(void)testOrderByDate{
    
}

-(void)testOrderByString{
    
}

@end
