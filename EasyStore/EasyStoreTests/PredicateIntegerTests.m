//
//  PredicateNumberTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/30/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateIntegerTests : XCTestCase

@end

@implementation PredicateIntegerTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testWherePredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" equalsInteger:4444];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqual([singleEntry getIntegerForColumnName:@"amount"], 4444, @"Incorrect entry returned from query");
}

- (void)testOrPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" equalsInteger:4444];
    [predicate orColumn:@"amount" equalsInteger:5555];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    BOOL correct =  ( 4444 == [firstEntry getIntegerForColumnName:@"amount"] || 5555 == [firstEntry getIntegerForColumnName:@"amount"] );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    EasyEntry* secondEntry = [entries objectAtIndex:0];
    correct = ( 4444 == [secondEntry getIntegerForColumnName:@"amount"] || 5555 == [secondEntry getIntegerForColumnName:@"amount"] );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

- (void)testAndPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"age" withType:EasyString];
    [table createColumnWithName:@"money" withType:EasyString];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setInteger:21 forColumnName:@"age"];
    [entry setInteger:83832 forColumnName:@"money"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setInteger:35 forColumnName:@"age"];
    [entry2 setInteger:99090 forColumnName:@"money"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setInteger:3 forColumnName:@"age"];
    [entry3 setInteger:90 forColumnName:@"money"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"age" equalsInteger:3];
    [predicate andColumn:@"money" equalsInteger:90];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqual([singleEntry getIntegerForColumnName:@"age"], 3, @"Incorrect entry returned from query");
    XCTAssertEqual([singleEntry getIntegerForColumnName:@"money"], 90, @"Incorrect entry returned from query");
}

-(void)testWhereGreaterThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isGreaterThanInteger:4000];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    EasyEntry* secondEntry = [entries objectAtIndex:1];

    XCTAssertTrue([firstEntry getIntegerForColumnName:@"amount"] > 4000, @"Incorrect entry returned from query");
    XCTAssertTrue([secondEntry getIntegerForColumnName:@"amount"] > 4000, @"Incorrect entry returned from query");
}

-(void)testOrGreaterThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate orColumn:@"amount" isGreaterThanInteger:5000];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    EasyEntry* secondEntry = [entries objectAtIndex:1];
    
    BOOL correct = ( [@"John" isEqualToString:[firstEntry getStringForColumnName:@"name"]] || [firstEntry getIntegerForColumnName:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    correct = ( [@"John" isEqualToString:[secondEntry getStringForColumnName:@"name"]] || [secondEntry getIntegerForColumnName:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

-(void)testAndGreaterThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate andColumn:@"amount" isGreaterThanInteger:10000];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 0, @"Incorrect number of results returned from query");
}

-(void)testWhereLessThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"amount"];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isLessThanInteger:4000];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    XCTAssertTrue([firstEntry getIntegerForColumnName:@"amount"] < 4000, @"Incorrect entry returned from query");
}

-(void)testOrLessThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyInteger];
    
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setInteger:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setInteger:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setInteger:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"Dan"];
    [predicate orColumn:@"amount" isLessThanInteger:5000];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
}

-(void)testAndLessThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"money"];
    [table createIntegerColumnWithName:@"time"];
    
    [EasyStore completeDatabaseCreation];
    
    int moneyArray[] = {100, 200, 300, 400, 500};
    int timeArray[] = {1, 2, 3, 4, 5};
    
    for(int i=0; i<5; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:moneyArray[i] forColumnName:@"money"];
        [entry setInteger:timeArray[i] forColumnName:@"time"];
        [EasyStore store:entry intoTable:@"Users"];
    }
        
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"money" isGreaterThanInteger:200];
    [predicate andColumn:@"time" isLessThanInteger:4];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    for(int i=0; i<[entries count]; i++){
        EasyEntry* entry = [entries objectAtIndex:i];
        int money = [entry getIntegerForColumnName:@"money"];
        int time = [entry getIntegerForColumnName:@"time"];
        
        XCTAssertTrue(money > 200 && time < 4, @"Incorrect results returned from select query");
    }
}
 


@end
