//
//  UtilityTests.m
//  EasyStore
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
    NSString* numberType = [Utility convertType:EasyInteger];
    NSString* stringType = [Utility convertType:EasyString];
    NSString* booleanType = [Utility convertType:EasyBoolean];
    NSString* dateType = [Utility convertType:EasyDate];
    NSString* floatType = [Utility convertType:EasyFloat];
    NSString* invalidType = [Utility convertType:-1];
    
    XCTAssertEqualObjects(numberType, @"INTEGER", @"Convert EasyInteger failed");
    XCTAssertEqualObjects(stringType, @"TEXT", @"Convert EasyString failed");
    XCTAssertEqualObjects(booleanType, @"INTEGER", @"Convert EasyBoolean failed");
    XCTAssertEqualObjects(dateType, @"INTEGER", @"Convert EasyDate failed");
    XCTAssertEqualObjects(floatType, @"REAL", @"Convert EasyFloat failed");
    XCTAssertEqualObjects(invalidType, nil, @"Invalid value converted");
}

@end
