//
//  PredicateFloatTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/4/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateFloatTests : XCTestCase

@end

@implementation PredicateFloatTests


- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

-(void)testWhereEqualsPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"Luffy", @"Sanji", @"Zorro", @"Usopp"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"gpa" equalsFloat:1.223];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry floatForColumn:@"gpa"], 1.223f, @"Incorrect floating point number returned");
}

-(void)testAndEqualsPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"A"];
    [predicate andColumn:@"gpa" equalsFloat:3.948];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry floatForColumn:@"gpa"], 3.948f, @"Incorrect floating point number returned");
}

-(void)testOrEqualsPredicate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"B"];
    [predicate orColumn:@"gpa" equalsFloat:4.0];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

-(void)testAndIsGreater{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"A"];
    [predicate andColumn:@"gpa" isGreaterThanFloat:2.583];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}


-(void)testOrIsGreater{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"B"];
    [predicate orColumn:@"gpa" isGreaterThanFloat:3.950];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

-(void)testWhereIsLessThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"Luffy", @"Sanji", @"Zorro", @"Usopp"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"gpa" isLessThanFloat:2.583];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry floatForColumn:@"gpa"], 1.223f, @"Incorrect floating point number returned");
}


-(void)testAndIsLessThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"A"];
    [predicate andColumn:@"gpa" isLessThanFloat:3.949];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

-(void)testOrIsLessThan{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [EasyStore insert:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"B"];
    [predicate orColumn:@"gpa" isLessThanFloat:2.0];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

@end
