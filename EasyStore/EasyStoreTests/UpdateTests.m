//
//  UpdateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface UpdateTests : XCTestCase

@end

@implementation UpdateTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testUpdateSingleEntry{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createStringColumnWithName:@"state"];
    
    [EasyStore completeDatabaseCreation];
    
    NSArray* names = @[@"Bill", @"John", @"Kyle", @"Jake",@"Mike"];
    NSArray* states = @[@"Texas", @"Alabama", @"Delaware", @"California",@"Florida"];
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setString:[names objectAtIndex:i] forColumnName:@"name"];
        [entry setString:[states objectAtIndex:i] forColumnName:@"state"];
        [EasyStore store:entry intoTable:@"Users"];
    }
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"Users"];
    [predicate setColumn:@"name" toString:@"Paul"];
    [predicate whereColumn:@"state" equalsString:@"Alabama"];
    
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* updatedNames = @[@"Bill", @"Paul", @"Kyle", @"Jake",@"Mike"];
    NSArray* updatedEntries = [EasyStore selectAllEntriesForTable:@"Users"];
    
    for(int i=0; i<[names count]; i++){
        EasyEntry* thisEntry = [updatedEntries objectAtIndex:i];
        NSString* thisWord = [thisEntry getStringForColumnName:@"name"];
        XCTAssertEqualObjects(thisWord, [updatedNames objectAtIndex:i], @"Returned strings not correctly updated");
    }
}

- (void)testUpdateAllEntries{
    
}

-(void)testUpdateInteger{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateInteger"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"integer"];
    
    [EasyStore completeDatabaseCreation];
    
    int integers[] = { -1, -2, -3, -4, 1, 2, 3 , 4};
    
    for(int i=0; i<8; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:integers[i] forColumnName:@"integer"];
        [EasyStore store:entry intoTable:@"UpdateInteger"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateInteger"];
    [predicate setColumn:@"integer" toInteger:-5];
    [predicate whereColumn:@"integer" isGreaterThanInteger:0];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateInteger"];
    
    for(EasyEntry* entry in entries){
        int integer = [entry getIntegerForColumnName:@"integer"];
        XCTAssertTrue(integer < 0, @"Integer values not correctly updated");
    }
}

-(void)testUpdateBoolean{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateBoolean"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"boolean"];
    
    [EasyStore completeDatabaseCreation];
    
    int booleanValues[] = {true, true, true, true, false, false, false, false};
    
    for(int i=0; i<8; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:booleanValues[i] forColumnName:@"boolean"];
        [EasyStore store:entry intoTable:@"UpdateBoolean"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateBoolean"];
    [predicate setColumnToTrue:@"boolean"];
    [predicate whereColumnIsFalse:@"boolean"];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateBoolean"];
    
    for(EasyEntry* entry in entries){
        bool boolValue = [entry getBooleanForColumnName:@"boolean"];
        XCTAssertTrue(boolValue == true, @"Boolean values not correctly updated");
    }
}

@end
