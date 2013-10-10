//
//  zFlush.m
//  TankDB
//
//  Created by Jeremy Nortey on 10/6/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface zFlush : XCTestCase

@end

extern void __gcov_flush(void);

@implementation zFlush

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
