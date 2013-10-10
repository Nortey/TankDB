//
//  UtilityTests.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utility.h"

@interface UtilityTests : XCTestCase

@end

@implementation UtilityTests

- (void)setUp{
    [super setUp];
}

- (void)tearDown{
    [super tearDown];
}

- (void)testConvertType{
    NSString* numberType = [Utility convertType:TDInteger];
    NSString* stringType = [Utility convertType:TDString];
    NSString* booleanType = [Utility convertType:TDBoolean];
    NSString* dateType = [Utility convertType:TDDate];
    NSString* floatType = [Utility convertType:TDFloat];
    NSString* invalidType = [Utility convertType:-1];
    
    XCTAssertEqualObjects(numberType, @"INTEGER", @"Convert TDInteger failed");
    XCTAssertEqualObjects(stringType, @"TEXT", @"Convert TDString failed");
    XCTAssertEqualObjects(booleanType, @"INTEGER", @"Convert TDBoolean failed");
    XCTAssertEqualObjects(dateType, @"INTEGER", @"Convert TDDate failed");
    XCTAssertEqualObjects(floatType, @"REAL", @"Convert TDFloat failed");
    XCTAssertEqualObjects(invalidType, nil, @"Invalid value converted");
}

@end
