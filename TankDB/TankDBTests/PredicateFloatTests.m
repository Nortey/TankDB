//
//  PredicateFloatTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/4/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateFloatTests : XCTestCase

@end

@implementation PredicateFloatTests


- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

-(void)testWhereEqualsPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"Luffy", @"Sanji", @"Zorro", @"Usopp"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"gpa" equalsFloat:1.223];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry floatForColumn:@"gpa"], 1.223f, @"Incorrect floating point number returned");
}

-(void)testAndEqualsPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"A"];
    [predicate andColumn:@"gpa" equalsFloat:3.948];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry floatForColumn:@"gpa"], 3.948f, @"Incorrect floating point number returned");
}

-(void)testOrEqualsPredicate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"B"];
    [predicate orColumn:@"gpa" equalsFloat:4.0];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

-(void)testAndIsGreater{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"A"];
    [predicate andColumn:@"gpa" isGreaterThanFloat:2.583];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}


-(void)testOrIsGreater{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"B"];
    [predicate orColumn:@"gpa" isGreaterThanFloat:3.950];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

-(void)testWhereIsLessThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"Luffy", @"Sanji", @"Zorro", @"Usopp"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"gpa" isLessThanFloat:2.583];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry floatForColumn:@"gpa"], 1.223f, @"Incorrect floating point number returned");
}


-(void)testAndIsLessThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"A"];
    [predicate andColumn:@"gpa" isLessThanFloat:3.949];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

-(void)testOrIsLessThan{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Students"];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* students = @[@"A", @"A", @"A", @"B"];
    float gpas[] = {3.948, 4.0, 1.223, 2.584};
    
    for(int i=0; i<[students count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[students objectAtIndex:i] forColumn:@"name"];
        [entry setFloat:gpas[i] forColumn:@"gpa"];
        [TankDB insert:entry intoTable:@"Students"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"name" equalsString:@"B"];
    [predicate orColumn:@"gpa" isLessThanFloat:2.0];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

@end
