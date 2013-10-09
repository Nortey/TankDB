//
//  PredicateLimitOffsetTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/5/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateLimitOffsetTests : XCTestCase

@end

@implementation PredicateLimitOffsetTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testLimit{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"GIBBERISH"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"number"];
    
    [EasyStore completeDatabaseCreation];
    
    for(int i=0; i<20; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:i * 23 forColumn:@"number"];
        [EasyStore insert:entry intoTable:@"GIBBERISH"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"GIBBERISH"];
    [predicate withLimit:5];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 5, @"Incorrect number of results returned from query");
}

- (void)testOffset{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"GIBBERISH"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"number"];
    
    [EasyStore completeDatabaseCreation];
    
    for(int i=0; i<20; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:i * 23 forColumn:@"number"];
        [EasyStore insert:entry intoTable:@"GIBBERISH"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"GIBBERISH"];
    [predicate withLimit:20 andOffset:5];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
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
