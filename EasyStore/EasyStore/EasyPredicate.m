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

-(NSString*)getPredicateString{
    return predicateString;
}

-(void)selectFromTable:(NSString *)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [predicateString appendFormat:@"SELECT * FROM %@" , tableLowerCase];
}

// String Equal predicates
-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = \"%@\"", columnNameLowerCase, string];
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


// Number Equal predicates
-(void)whereColumn:(NSString*) columnName equalsNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName equalsNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName equalsNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}


// Number greater than predicates
-(void)whereColumn:(NSString*) columnName isGreaterThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ > %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName isGreaterThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ > %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName isGreaterThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ > %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

// Number greater than predicates
-(void)whereColumn:(NSString*) columnName isLessThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ < %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName isLessThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ < %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName isLessThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ < %i", columnNameLowerCase, number];
    [predicateString appendFormat:@"%@", newPredicate];
}


@end
