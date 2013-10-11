//
//  Utility.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSString*)convertType:(TDType)type{
    switch (type) {
        case TDInteger:
            return @"INTEGER"; break;
        case TDString:
            return @"TEXT"; break;
        case TDBoolean:
            return @"INTEGER"; break;
        case TDDate:
            return @"INTEGER"; break;
        case TDFloat:
            return @"REAL"; break;
    }
    
    return nil;
    
}

@end
