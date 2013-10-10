//
//  UpdateTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/3/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface UpdateTests : XCTestCase

@end

@implementation UpdateTests

- (void)setUp{
    [super setUp];
    [TankDB clear];
}

- (void)tearDown{
    [super tearDown];
    [TankDB clear];
}

- (void)testUpdateSingleEntry{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createStringColumnWithName:@"state"];
    
    [TankDB completeDatabaseCreation];
    
    NSArray* names = @[@"Bill", @"John", @"Kyle", @"Jake",@"Mike"];
    NSArray* states = @[@"Texas", @"Alabama", @"Delaware", @"California",@"Florida"];
    
    for(int i=0; i<[names count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setString:[names objectAtIndex:i] forColumn:@"name"];
        [entry setString:[states objectAtIndex:i] forColumn:@"state"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual([entries count], [names count], @"Incorrect number of results returned from query");
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate updateTable:@"Users"];
    [predicate setColumn:@"name" toString:@"Paul"];
    [predicate whereColumn:@"state" equalsString:@"Alabama"];
    
    [TankDB updateEntriesWithPredicate:predicate];
    
    NSArray* updatedNames = @[@"Bill", @"Paul", @"Kyle", @"Jake",@"Mike"];
    NSArray* updatedEntries = [TankDB selectAllEntriesForTable:@"Users"];
    
    for(int i=0; i<[names count]; i++){
        TDEntry* thisEntry = [updatedEntries objectAtIndex:i];
        NSString* thisWord = [thisEntry stringForColumn:@"name"];
        XCTAssertEqualObjects(thisWord, [updatedNames objectAtIndex:i], @"Returned strings not correctly updated");
    }
}

- (void)testUpdateAllEntries{
    
}

-(void)testUpdateInteger{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"UpdateInteger"];
    [table addIdentityColumn];
    [table createIntegerColumnWithName:@"integer"];
    
    [TankDB completeDatabaseCreation];
    
    int integers[] = { -1, -2, -3, -4, 1, 2, 3 , 4};
    
    for(int i=0; i<8; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:integers[i] forColumn:@"integer"];
        [TankDB insert:entry intoTable:@"UpdateInteger"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate updateTable:@"UpdateInteger"];
    [predicate setColumn:@"integer" toInteger:-5];
    [predicate whereColumn:@"integer" isGreaterThanInteger:0];
    [TankDB updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"UpdateInteger"];
    
    for(TDEntry* entry in entries){
        int integer = [entry integerForColumn:@"integer"];
        XCTAssertTrue(integer < 0, @"Integer values not correctly updated");
    }
}

-(void)testUpdateBooleanTrue{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"UpdateBoolean"];
    [table addIdentityColumn];
    [table createBooleanColumnWithName:@"boolean"];
    
    [TankDB completeDatabaseCreation];
    
    int booleanValues[] = {true, true, true, true, false, false, false, false};
    
    for(int i=0; i<8; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:booleanValues[i] forColumn:@"boolean"];
        [TankDB insert:entry intoTable:@"UpdateBoolean"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate updateTable:@"UpdateBoolean"];
    [predicate setColumnToTrue:@"boolean"];
    [predicate whereColumnIsFalse:@"boolean"];
    [TankDB updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"UpdateBoolean"];
    
    for(TDEntry* entry in entries){
        bool boolValue = [entry booleanForColumn:@"boolean"];
        XCTAssertTrue(boolValue == true, @"Boolean values not correctly updated");
    }
}

-(void)testUpdateBooleanFalse{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"UpdateBoolean"];
    [table addIdentityColumn];
    [table createBooleanColumnWithName:@"boolean"];
    
    [TankDB completeDatabaseCreation];
    
    int booleanValues[] = {true, true, true, true, false, false, false, false};
    
    for(int i=0; i<8; i++){
        TDEntry* entry = [TDEntry new];
        [entry setInteger:booleanValues[i] forColumn:@"boolean"];
        [TankDB insert:entry intoTable:@"UpdateBoolean"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate updateTable:@"UpdateBoolean"];
    [predicate setColumnToFalse:@"boolean"];
    [predicate whereColumnIsTrue:@"boolean"];
    [TankDB updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"UpdateBoolean"];
    
    for(TDEntry* entry in entries){
        bool boolValue = [entry booleanForColumn:@"boolean"];
        XCTAssertTrue(boolValue == false, @"Boolean values not correctly updated");
    }
}

-(void)testUpdateDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"UpdateDates"];
    [table addIdentityColumn];
    [table createDateColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    
    NSArray* dates = @[date1, date2, now];
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [TankDB insert:entry intoTable:@"UpdateDates"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate updateTable:@"UpdateDates"];
    [predicate setColumn:@"date" toDate:now];
    [predicate whereColumn:@"date" isBeforeDate:now];
    [TankDB updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"UpdateDates"];
    
    for(TDEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        XCTAssertTrue(abs([now timeIntervalSince1970] - [thisDate timeIntervalSince1970]) < 3, @"Boolean values not correctly updated");
    }
}

-(void)testUpdateFloat{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"UpdateFloat"];
    [table addIdentityColumn];
    [table createFloatColumnWithName:@"floats"];
    
    [TankDB completeDatabaseCreation];
    
    float floats[] = { 0.032, 0.435, 0.232, 0.533, 0.623, 0.667};
    
    for(int i=0; i<6; i++){
        TDEntry* entry = [TDEntry new];
        [entry setFloat:floats[i] forColumn:@"floats"];
        [TankDB insert:entry intoTable:@"UpdateFloat"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate updateTable:@"UpdateFloat"];
    [predicate setColumn:@"floats" toFloat:0.001];
    [predicate whereColumn:@"floats" isGreaterThanFloat:0.5];
    [TankDB updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"UpdateFloat"];
    
    for(TDEntry* entry in entries){
        float floatNumber = [entry floatForColumn:@"floats"];
        XCTAssertTrue(floatNumber < 0.5, @"Float values not correctly updated");
    }
}

@end
