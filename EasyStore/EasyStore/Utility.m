//
//  Utility.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSString*)convertType:(EasyType)type{
    switch (type) {
        case EasyNumber:
            return @"INTEGER"; break;
        case EasyString:
            return @"TEXT"; break;
        case EasyBoolean:
            return @"INTEGER"; break;
    }
    
    return nil;
    
}

@end
