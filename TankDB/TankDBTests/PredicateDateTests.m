//
//  PredicateDateTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/4/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TankDB.h"

@interface PredicateDateTests : XCTestCase

@end

@implementation PredicateDateTests

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
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createDateColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* now = [NSDate date];
    
    TDEntry* entry = [TDEntry new];
    [entry setDate:now forColumn:@"date"];
    [TankDB insert:entry intoTable:@"Users"];
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"date" equalsDate:now];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertTrue((int)[now timeIntervalSinceDate:[thisEntry dateForColumn:@"date"]] == 0, @"Incorrect date returned from query");
}

-(void)testStoreDateAsNow{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Date"];
    [table createDateColumnWithName:@"date"];
    [TankDB completeDatabaseCreation];
    
    TDEntry* entry = [TDEntry new];
    NSDate* now = [NSDate date];
    [entry setDateAsNowForColumn:@"date"];
    [TankDB insert:entry intoTable:@"Date"];
    
    NSArray* entries = [TankDB selectAllEntriesForTable:@"Date"];
    TDEntry* storedEntry = [entries objectAtIndex:0];
    NSDate* storedDate = [storedEntry dateForColumn:@"date"];
    
    XCTAssertTrue(abs([now timeIntervalSince1970] - [storedDate timeIntervalSince1970]) < 3, @"Column name incorrect");
}

-(void)testOrIsBeforeDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"BeforeDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [TankDB insert:entry intoTable:@"BeforeDate"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"BeforeDate"];
    [predicate whereColumn:@"money" isGreaterThanInteger:300];
    [predicate orColumn:@"date" isBeforeDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 4, @"Incorrect number of results returned from query");
    
    for(TDEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedDescending || money > 300, @"Incorrect entries selected");
    }
}

-(void)testAndIsBeforeDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"BeforeDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [TankDB insert:entry intoTable:@"BeforeDate"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"BeforeDate"];
    [predicate whereColumn:@"money" isGreaterThanInteger:100];
    [predicate andColumn:@"date" isBeforeDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    for(TDEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedDescending && money > 100, @"Incorrect entries selected");
    }
}

-(void)testWhereIsAfterDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"AfterDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [TankDB insert:entry intoTable:@"AfterDate"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"AfterDate"];
    [predicate whereColumn:@"date" isAfterDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    for(TDEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedAscending, @"Incorrect entries selected");
    }
}

-(void)testAndIsAfterDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"AfterDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [TankDB insert:entry intoTable:@"AfterDate"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"AfterDate"];
    [predicate whereColumn:@"money" isGreaterThanInteger:400];
    [predicate andColumn:@"date" isAfterDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    for(TDEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedAscending && money > 400, @"Incorrect entries selected");
    }
}


-(void)testOrIsAfterDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"AfterDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [TankDB insert:entry intoTable:@"AfterDate"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"AfterDate"];
    [predicate whereColumn:@"money" isLessThanInteger:200];
    [predicate orColumn:@"date" isAfterDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
    
    for(TDEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue(money < 200 || [now compare:thisDate] == NSOrderedAscending, @"Incorrect entries selected");
    }
}

-(void)testAndEqualsDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"amount"];
    [table createDateColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int amounts[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:amounts[i] forColumn:@"amount"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isGreaterThanInteger:200];
    [predicate andColumn:@"date" equalsDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    TDEntry* thisEntry = [entries objectAtIndex:0];
    int returnedAmount = [thisEntry integerForColumn:@"amount"];
    XCTAssertTrue((int)[now timeIntervalSinceDate:[thisEntry dateForColumn:@"date"]] == 0 && returnedAmount == 300, @"Incorrect date returned from query");
}

-(void)testOrEqualsDate{
    [TankDB beginDatabaseCreation];
    
    TDTable *table = [TankDB createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"amount"];
    [table createDateColumnWithName:@"date"];
    
    [TankDB completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int amounts[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        TDEntry* entry = [TDEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:amounts[i] forColumn:@"amount"];
        [TankDB insert:entry intoTable:@"Users"];
    }
    
    TDPredicate *predicate = [TDPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isLessThanInteger:200];
    [predicate orColumn:@"date" equalsDate:now];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

@end
