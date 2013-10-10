//
//  PredicateNumberTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/30/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateIntegerTests : XCTestCase

@end

@implementation PredicateIntegerTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testWherePredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" equalsInteger:4444];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqual([singleEntry integerForColumn:@"amount"], 4444, @"Incorrect entry returned from query");
}

- (void)testOrPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" equalsInteger:4444];
    [predicate orColumn:@"amount" equalsInteger:5555];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    TDEntry* firstEntry = [entries objectAtIndex:0];
    BOOL correct =  ( 4444 == [firstEntry integerForColumn:@"amount"] || 5555 == [firstEntry integerForColumn:@"amount"] );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    TDEntry* secondEntry = [entries objectAtIndex:0];
    correct = ( 4444 == [secondEntry integerForColumn:@"amount"] || 5555 == [secondEntry integerForColumn:@"amount"] );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

- (void)testAndPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"age" withType:TDString];
    [table createColumnWithName:@"money" withType:TDString];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setInteger:21 forColumn:@"age"];
    [entry setInteger:83832 forColumn:@"money"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setInteger:35 forColumn:@"age"];
    [entry2 setInteger:99090 forColumn:@"money"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setInteger:3 forColumn:@"age"];
    [entry3 setInteger:90 forColumn:@"money"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"age" equalsInteger:3];
    [predicate andColumn:@"money" equalsInteger:90];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqual([singleEntry integerForColumn:@"age"], 3, @"Incorrect entry returned from query");
    XCTAssertEqual([singleEntry integerForColumn:@"money"], 90, @"Incorrect entry returned from query");
}

-(void)testWhereGreaterThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isGreaterThanInteger:4000];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    TDEntry* firstEntry = [entries objectAtIndex:0];
    TDEntry* secondEntry = [entries objectAtIndex:1];

    XCTAssertTrue([firstEntry integerForColumn:@"amount"] > 4000, @"Incorrect entry returned from query");
    XCTAssertTrue([secondEntry integerForColumn:@"amount"] > 4000, @"Incorrect entry returned from query");
}

-(void)testOrGreaterThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate orColumn:@"amount" isGreaterThanInteger:5000];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    TDEntry* firstEntry = [entries objectAtIndex:0];
    TDEntry* secondEntry = [entries objectAtIndex:1];
    
    BOOL correct = ( [@"John" isEqualToString:[firstEntry stringForColumn:@"name"]] || [firstEntry integerForColumn:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    correct = ( [@"John" isEqualToString:[secondEntry stringForColumn:@"name"]] || [secondEntry integerForColumn:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

-(void)testAndGreaterThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate andColumn:@"amount" isGreaterThanInteger:10000];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 0, @"Incorrect number of results returned from query");
}

-(void)testWhereLessThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"amount"];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isLessThanInteger:4000];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* firstEntry = [entries objectAtIndex:0];
    XCTAssertTrue([firstEntry integerForColumn:@"amount"] < 4000, @"Incorrect entry returned from query");
}

-(void)testOrLessThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:TDString];
    [table createColumnWithName:@"amount" withType:TDInteger];
    
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:@"John" forColumn:@"name"];
    [entry setInteger:3333 forColumn:@"amount"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDEntry* entry2 = [TDEntry new];
    [entry2 setString:@"Blake" forColumn:@"name"];
    [entry2 setInteger:4444 forColumn:@"amount"];
    [TankDB insert:entry2 intoTable:@"Users"];
    
    TDEntry* entry3 = [TDEntry new];
    [entry3 setString:@"Dan" forColumn:@"name"];
    [entry3 setInteger:5555 forColumn:@"amount"];
    [TankDB insert:entry3 intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Dan"];
    [predicate orColumn:@"amount" isLessThanInteger:5000];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
}

-(void)testAndLessThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"money"];
    [table createIntegerColumnWithName:@"time"];
    
    [TankDB completeDatabaseCreation];
    
    int moneyArray[] = {100, 200, 300, 400, 500};
    int timeArray[] = {1, 2, 3, 4, 5};
    
    for(int i=0; i<5; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:moneyArray[i] forColumn:@"money"];
        [entry setInteger:timeArray[i] forColumn:@"time"];
        [TankDB insert:entry intoTable:@"Users"];
    }
        
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"money" isGreaterThanInteger:200];
    [predicate andColumn:@"time" isLessThanInteger:4];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    for(int i=0; i<[entries count]; i++){
        TDEntry* entry = [entries objectAtIndex:i];
        int money = [entry integerForColumn:@"money"];
        int time = [entry integerForColumn:@"time"];
        
        XCTAssertTrue(money > 200 && time < 4, @"Incorrect results returned from select query");
    }
}
 


@end
