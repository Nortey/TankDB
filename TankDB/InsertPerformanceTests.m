//
//  InsertPerformanceTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/12/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

#define RUN_INSERT_PERF_TESTS 0
#define NUM_RECORDS 100000

@interface InsertPerformanceTests : XCTestCase

@end

@implementation InsertPerformanceTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

// TODO add to test utility class
-(NSString *) genRandStringLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

-(void)testRunPerformanceTests{
    if(RUN_INSERT_PERF_TESTS){
      //  [self insertEntries];
        [self insertBulkEntries];
    }
}

-(NSArray*)getEntries:(int)numEntries{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"amount"];
    [table createBooleanColumnWithName:@"isValid"];
    
    [TankDB completeDatabaseCreation];
    
    NSMutableArray* randomEntries = [NSMutableArray new];
    for(int i=0; i<numEntries; i++){
        TDEntry* entry = [TDEntry new];
        NSString* name = [self genRandStringLength:12];
        int amount = arc4random() % 10000;
        BOOL isValid = arc4random() % 2;
        
        [entry setString:name forColumn:@"name"];
        [entry setInteger:amount forColumn:@"amount"];
        [entry setBoolean:isValid forColumn:@"isValid"];
        
        [randomEntries addObject:entry];
    }
    
    return randomEntries;
}

- (void)insertEntries{
    NSDate *methodStart = [NSDate date];
    
    NSArray* entries = [self getEntries:NUM_RECORDS];
    for(TDEntry *entry in entries){
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"insertEntries executionTime = %f", executionTime);
}

- (void)insertBulkEntries{
    NSDate *methodStart = [NSDate date];
    
    NSArray* entries = [self getEntries:NUM_RECORDS];
    [TankDB performBulkInsert:entries intoTable:@"Users"];
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"insertEntries executionTime = %f", executionTime);
}

@end
