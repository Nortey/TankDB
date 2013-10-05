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
    
    XCTAssertEqualObjects(numberType, @"INTEGER", @"Convert EasyNumber failed");
    XCTAssertEqualObjects(stringType, @"TEXT", @"Convert EasyString failed");
}

@end
