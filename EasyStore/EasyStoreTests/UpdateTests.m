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
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setString:[states objectAtIndex:i] forColumn:@"state"];
        [EasyStore insert:entry intoTable:@"Users"];
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
        NSString* thisWord = [thisEntry stringForColumn:@"name"];
        XCTAssertEqualObjects(thisWord, [updatedNames objectAtIndex:i], @"Returned strings not correctly updated");
    }
}

- (void)testUpdateAllEntries{
    
}

-(void)testUpdateInteger{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateInteger"];
    [table addIdentityColumn];
    [table createIntegerColumnWithName:@"integer"];
    
    [EasyStore completeDatabaseCreation];
    
    int integers[] = { -1, -2, -3, -4, 1, 2, 3 , 4};
    
    for(int i=0; i<8; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:integers[i] forColumn:@"integer"];
        [EasyStore insert:entry intoTable:@"UpdateInteger"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateInteger"];
    [predicate setColumn:@"integer" toInteger:-5];
    [predicate whereColumn:@"integer" isGreaterThanInteger:0];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateInteger"];
    
    for(EasyEntry* entry in entries){
        int integer = [entry integerForColumn:@"integer"];
        XCTAssertTrue(integer < 0, @"Integer values not correctly updated");
    }
}

-(void)testUpdateBooleanTrue{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateBoolean"];
    [table addIdentityColumn];
    [table createBooleanColumnWithName:@"boolean"];
    
    [EasyStore completeDatabaseCreation];
    
    int booleanValues[] = {true, true, true, true, false, false, false, false};
    
    for(int i=0; i<8; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:booleanValues[i] forColumn:@"boolean"];
        [EasyStore insert:entry intoTable:@"UpdateBoolean"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateBoolean"];
    [predicate setColumnToTrue:@"boolean"];
    [predicate whereColumnIsFalse:@"boolean"];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateBoolean"];
    
    for(EasyEntry* entry in entries){
        bool boolValue = [entry booleanForColumn:@"boolean"];
        XCTAssertTrue(boolValue == true, @"Boolean values not correctly updated");
    }
}

-(void)testUpdateBooleanFalse{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateBoolean"];
    [table addIdentityColumn];
    [table createBooleanColumnWithName:@"boolean"];
    
    [EasyStore completeDatabaseCreation];
    
    int booleanValues[] = {true, true, true, true, false, false, false, false};
    
    for(int i=0; i<8; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setInteger:booleanValues[i] forColumn:@"boolean"];
        [EasyStore insert:entry intoTable:@"UpdateBoolean"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateBoolean"];
    [predicate setColumnToFalse:@"boolean"];
    [predicate whereColumnIsTrue:@"boolean"];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateBoolean"];
    
    for(EasyEntry* entry in entries){
        bool boolValue = [entry booleanForColumn:@"boolean"];
        XCTAssertTrue(boolValue == false, @"Boolean values not correctly updated");
    }
}

-(void)testUpdateDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateDates"];
    [table addIdentityColumn];
    [table createDateColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    
    NSArray* dates = @[date1, date2, now];
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [EasyStore insert:entry intoTable:@"UpdateDates"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateDates"];
    [predicate setColumn:@"date" toDate:now];
    [predicate whereColumn:@"date" isBeforeDate:now];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateDates"];
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        XCTAssertTrue(abs([now timeIntervalSince1970] - [thisDate timeIntervalSince1970]) < 3, @"Boolean values not correctly updated");
    }
}

-(void)testUpdateFloat{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateFloat"];
    [table addIdentityColumn];
    [table createFloatColumnWithName:@"floats"];
    
    [EasyStore completeDatabaseCreation];
    
    float floats[] = { 0.032, 0.435, 0.232, 0.533, 0.623, 0.667};
    
    for(int i=0; i<6; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setFloat:floats[i] forColumn:@"floats"];
        [EasyStore insert:entry intoTable:@"UpdateFloat"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateFloat"];
    [predicate setColumn:@"floats" toFloat:0.001];
    [predicate whereColumn:@"floats" isGreaterThanFloat:0.5];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateFloat"];
    
    for(EasyEntry* entry in entries){
        float floatNumber = [entry floatForColumn:@"floats"];
        XCTAssertTrue(floatNumber < 0.5, @"Float values not correctly updated");
    }
}

@end
