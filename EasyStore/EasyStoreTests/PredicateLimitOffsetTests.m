//
//  PredicateLimitTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/5/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EasyStore.h"

@interface PredicateLimitOffsetTests : XCTestCase

@end

@implementation PredicateLimitOffsetTests

- (void)setUp{
    [super setUp];
    [EasyStore clearEasyStore];
}

- (void)tearDown{
    [super tearDown];
    [EasyStore clearEasyStore];
}

- (void)testExample{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
