//
//  _LastTests.m
//  EasyStore
//
//  Created by Jeremy Nortey on 10/6/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface _LastTests : XCTestCase

@end

extern void __gcov_flush(void);

@implementation _LastTests

- (void)setUp{
    [super setUp];
}

- (void)tearDown{
    [super tearDown];
}

- (void)testFlush{
    __gcov_flush();
}

@end
