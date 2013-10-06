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

-(void)testSetPredicate{
    
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
        [entry setString:[students objectAtIndex:i] forColumnName:@"name"];
        [entry setFloat:gpas[i] forColumnName:@"gpa"];
        [EasyStore store:entry intoTable:@"Students"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Students"];
    [predicate whereColumn:@"gpa" equalsFloat:1.223];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertEqual([thisEntry getFloatForColumnName:@"gpa"], 1.223f, @"Incorrect floating point number returned");
}

@end
