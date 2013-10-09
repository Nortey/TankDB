//
//  PredicateDateTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/4/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateDateTests : XCTestCase

@end

@implementation PredicateDateTests

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
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createDateColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* now = [NSDate date];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setDate:now forColumn:@"date"];
    [EasyStore insert:entry intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"date" equalsDate:now];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertTrue((int)[now timeIntervalSinceDate:[thisEntry dateForColumn:@"date"]] == 0, @"Incorrect date returned from query");
}

-(void)testStoreDateAsNow{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Date"];
    [table createDateColumnWithName:@"date"];
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    NSDate* now = [NSDate date];
    [entry setDateAsNowForColumn:@"date"];
    [EasyStore insert:entry intoTable:@"Date"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Date"];
    EasyEntry* storedEntry = [entries objectAtIndex:0];
    NSDate* storedDate = [storedEntry dateForColumn:@"date"];
    
    XCTAssertTrue(abs([now timeIntervalSince1970] - [storedDate timeIntervalSince1970]) < 3, @"Column name incorrect");
}

-(void)testOrIsBeforeDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"BeforeDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [EasyStore insert:entry intoTable:@"BeforeDate"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"BeforeDate"];
    [predicate whereColumn:@"money" isGreaterThanInteger:300];
    [predicate orColumn:@"date" isBeforeDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 4, @"Incorrect number of results returned from query");
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedDescending || money > 300, @"Incorrect entries selected");
    }
}

-(void)testAndIsBeforeDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"BeforeDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [EasyStore insert:entry intoTable:@"BeforeDate"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"BeforeDate"];
    [predicate whereColumn:@"money" isGreaterThanInteger:100];
    [predicate andColumn:@"date" isBeforeDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedDescending && money > 100, @"Incorrect entries selected");
    }
}

-(void)testWhereIsAfterDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"AfterDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [EasyStore insert:entry intoTable:@"AfterDate"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"AfterDate"];
    [predicate whereColumn:@"date" isAfterDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedAscending, @"Incorrect entries selected");
    }
}

-(void)testAndIsAfterDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"AfterDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [EasyStore insert:entry intoTable:@"AfterDate"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"AfterDate"];
    [predicate whereColumn:@"money" isGreaterThanInteger:400];
    [predicate andColumn:@"date" isAfterDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue([now compare:thisDate] == NSOrderedAscending && money > 400, @"Incorrect entries selected");
    }
}


-(void)testOrIsAfterDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"AfterDate"];
    [table addIdentityColumn];
    
    [table createIntegerColumnWithName:@"money"];
    [table createStringColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int money[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:money[i] forColumn:@"money"];
        [EasyStore insert:entry intoTable:@"AfterDate"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"AfterDate"];
    [predicate whereColumn:@"money" isLessThanInteger:200];
    [predicate orColumn:@"date" isAfterDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 3, @"Incorrect number of results returned from query");
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry dateForColumn:@"date"];
        int money = [entry integerForColumn:@"money"];
        XCTAssertTrue(money < 200 || [now compare:thisDate] == NSOrderedAscending, @"Incorrect entries selected");
    }
}

-(void)testAndEqualsDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"amount"];
    [table createDateColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int amounts[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:amounts[i] forColumn:@"amount"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isGreaterThanInteger:200];
    [predicate andColumn:@"date" equalsDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    int returnedAmount = [thisEntry integerForColumn:@"amount"];
    XCTAssertTrue((int)[now timeIntervalSinceDate:[thisEntry dateForColumn:@"date"]] == 0 && returnedAmount == 300, @"Incorrect date returned from query");
}

-(void)testOrEqualsDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createIntegerColumnWithName:@"amount"];
    [table createDateColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now, date3, date4];
    int amounts[] = {100, 200, 300, 400, 500};
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumn:@"date"];
        [entry setInteger:amounts[i] forColumn:@"amount"];
        [EasyStore insert:entry intoTable:@"Users"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"amount" isLessThanInteger:200];
    [predicate orColumn:@"date" equalsDate:now];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    XCTAssertEqual((int)[entries count], 2, @"Incorrect number of results returned from query");
}

@end
