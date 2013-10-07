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
    [entry setDate:now forColumnName:@"date"];
    [EasyStore store:entry intoTable:@"Users"];
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"date" equalsDate:now];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];
    XCTAssertEqual((int)[entries count], 1, @"Incorrect number of results returned from query");
    
    EasyEntry* thisEntry = [entries objectAtIndex:0];
    XCTAssertTrue((int)[now timeIntervalSinceDate:[thisEntry getDateForColumnName:@"date"]] == 0, @"Incorrect date returned from query");
}

-(void)testStoreDateAsNow{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Date"];
    [table createDateColumnWithName:@"date"];
    [EasyStore completeDatabaseCreation];
    
    EasyEntry* entry = [EasyEntry new];
    NSDate* now = [NSDate date];
    [entry setDateAsNowForColumnName:@"date"];
    [EasyStore store:entry intoTable:@"Date"];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"Date"];
    EasyEntry* storedEntry = [entries objectAtIndex:0];
    NSDate* storedDate = [storedEntry getDateForColumnName:@"date"];
    
    XCTAssertTrue(abs([now timeIntervalSince1970] - [storedDate timeIntervalSince1970]) < 3, @"Column name incorrect");
}

/*-(void)testUpdateDate{
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"UpdateDates"];
    [table addIdentityColumn];
    [table createStringColumnWithName:@"date"];
    
    [EasyStore completeDatabaseCreation];
    
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:-5000];
    NSDate* now = [NSDate date];
    //NSDate* date3 = [NSDate dateWithTimeIntervalSinceNow:5000];
    //NSDate* date4 = [NSDate dateWithTimeIntervalSinceNow:10000];
    
    NSArray* dates = @[date1, date2, now];
    
    for(int i=0; i<[dates count]; i++){
        EasyEntry* entry = [EasyEntry new];
        [entry setDate:[dates objectAtIndex:i] forColumnName:@"date"];
        [EasyStore store:entry intoTable:@"UpdateDates"];
    }
    
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate updateTable:@"UpdateBoolean"];
    [predicate setColumn:@"date" toDate:now];
    [predicate whereColumn:@"date" isBeforeDate:now];
    [EasyStore updateEntriesWithPredicate:predicate];
    
    NSArray* entries = [EasyStore selectAllEntriesForTable:@"UpdateDates"];
    
    for(EasyEntry* entry in entries){
        NSDate *thisDate = [entry getDateForColumnName:@"date"];
        XCTAssertTrue(, @"Boolean values not correctly updated");
    }
}*/

@end
