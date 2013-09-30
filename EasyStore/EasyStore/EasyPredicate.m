//
//  EasyPredicate.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "EasyPredicate.h"

@implementation EasyPredicate

-(id)init{
    self = [super init];
    if(self){
        predicateString = [NSMutableString stringWithString:@""];
    }
    return self;
}

-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@"WHERE %@ = \"%@\"", columnNameLowerCase, string];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = \"%@\"", columnNameLowerCase, string];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = \"%@\"", columnNameLowerCase, string];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(NSString*)getPredicateString{
    return predicateString;
}


@end
