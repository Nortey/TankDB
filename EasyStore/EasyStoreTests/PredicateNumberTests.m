//
//  PredicateNumberTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/30/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateNumberTests : XCTestCase

@end

@implementation PredicateNumberTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testWherePredicate{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" equalsNumber:4444];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqual([singleEntry getNumberForColumnName:@"amount"], 4444, @"Incorrect entry returned from query");
}

- (void)testOrPredicate{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" equalsNumber:4444];
    [predicate orColumnName:@"amount" equalsNumber:5555];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    BOOL correct =  ( 4444 == [firstEntry getNumberForColumnName:@"amount"] || 5555 == [firstEntry getNumberForColumnName:@"amount"] );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    EasyEntry* secondEntry = [entries objectAtIndex:0];
    correct = ( 4444 == [secondEntry getNumberForColumnName:@"amount"] || 5555 == [secondEntry getNumberForColumnName:@"amount"] );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

- (void)testAndPredicate{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"age" withType:EasyString];
    [table createColumnWithName:@"money" withType:EasyString];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setNumber:21 forColumnName:@"age"];
    [entry setNumber:83832 forColumnName:@"money"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setNumber:35 forColumnName:@"age"];
    [entry2 setNumber:99090 forColumnName:@"money"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setNumber:3 forColumnName:@"age"];
    [entry3 setNumber:90 forColumnName:@"money"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"age" equalsNumber:3];
    [predicate andColumnName:@"money" equalsNumber:90];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* singleEntry = [entries objectAtIndex:0];
    XCTAssertEqual([singleEntry getNumberForColumnName:@"age"], 3, @"Incorrect entry returned from query");
    XCTAssertEqual([singleEntry getNumberForColumnName:@"money"], 90, @"Incorrect entry returned from query");
}

-(void)testWhereGreaterThan{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isGreaterThanNumber:4000];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    EasyEntry* secondEntry = [entries objectAtIndex:1];

    XCTAssertTrue([firstEntry getNumberForColumnName:@"amount"] > 4000, @"Incorrect entry returned from query");
    XCTAssertTrue([secondEntry getNumberForColumnName:@"amount"] > 4000, @"Incorrect entry returned from query");
}

-(void)testOrGreaterThan{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate orColumnName:@"amount" isGreaterThanNumber:5000];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    EasyEntry* secondEntry = [entries objectAtIndex:1];
    
    BOOL correct = ( [@"John" isEqualToString:[firstEntry getStringForColumnName:@"name"]] || [firstEntry getNumberForColumnName:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    correct = ( [@"John" isEqualToString:[secondEntry getStringForColumnName:@"name"]] || [secondEntry getNumberForColumnName:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

-(void)testAndGreaterThan{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate andColumnName:@"amount" isGreaterThanNumber:10000];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 0, @"Incorrect number of results returned from query");
}

-(void)testWhereLessThan{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createNumberColumnWithName:@"amount"];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isLessThanNumber:4000];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    XCTAssertTrue([firstEntry getNumberForColumnName:@"amount"] < 4000, @"Incorrect entry returned from query");
}

/*-(void)testOrGreaterThan{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate orColumnName:@"amount" isGreaterThanNumber:5000];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    EasyEntry* firstEntry = [entries objectAtIndex:0];
    EasyEntry* secondEntry = [entries objectAtIndex:1];
    
    BOOL correct = ( [@"John" isEqualToString:[firstEntry getStringForColumnName:@"name"]] || [firstEntry getNumberForColumnName:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
    
    correct = ( [@"John" isEqualToString:[secondEntry getStringForColumnName:@"name"]] || [secondEntry getNumberForColumnName:@"amount"] > 5000 );
    XCTAssertTrue(correct, @"Incorrect entry returned from query");
}

-(void)testAndGreaterThan{
    [EasyStore start];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createColumnWithName:@"name" withType:EasyString];
    [table createColumnWithName:@"amount" withType:EasyNumber];
    
    [EasyStore done];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:@"John" forColumnName:@"name"];
    [entry setNumber:3333 forColumnName:@"amount"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyEntry* entry2 = [EasyEntry new];
    [entry2 setString:@"Blake" forColumnName:@"name"];
    [entry2 setNumber:4444 forColumnName:@"amount"];
    [EasyStore store:entry2 intoTable:@"Users"];
    
    EasyEntry* entry3 = [EasyEntry new];
    [entry3 setString:@"Dan" forColumnName:@"name"];
    [entry3 setNumber:5555 forColumnName:@"amount"];
    [EasyStore store:entry3 intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"name" equalsString:@"John"];
    [predicate andColumnName:@"amount" isGreaterThanNumber:10000];
    
    NSArray* entries = [EasyStore getEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 0, @"Incorrect number of results returned from query");
}*/
 


@end
