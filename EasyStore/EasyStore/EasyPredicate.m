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
        startClause = [NSMutableString stringWithString:@""];
        setClause = [NSMutableString stringWithString:@""];
        whereClause = [NSMutableString stringWithString:@""];
        orderByClause = [NSMutableString stringWithString:@""];
        
        updateSetArray = [NSMutableArray new];
        subPredicates = [NSMutableArray new];
    }
    return self;
}

-(void)And:(EasyPredicate*)predicate{
    [predicate setSubPredicateType:@"AND"];
    [subPredicates addObject:predicate];
}

-(void)Or:(EasyPredicate*)predicate{
    [predicate setSubPredicateType:@"OR"];
    [subPredicates addObject:predicate];
}

-(void)setSubPredicateType:(NSString*)predicateType{
    subPredicateType = [NSString stringWithString:predicateType];
}

-(NSString*)getSubPredicateType{
    return subPredicateType;
}

-(NSString*)getPredicateString{
    
    // Append update parts of predicate
    [setClause setString:[updateSetArray componentsJoinedByString:@" , "]];
    
    // Construct sub predicates
    NSMutableString* subPredicateString = [NSMutableString stringWithString:@""];
    for(EasyPredicate* predicate in subPredicates){
        NSString* subPredicate = [NSString stringWithFormat:@" %@ ( %@ ) ", [predicate getSubPredicateType], [predicate getPredicateString]];
        [subPredicateString appendString:subPredicate];
    }
    
    // Construct predicate string
    NSString* returnedPredicateString = [NSString stringWithFormat:@"%@%@%@%@%@", startClause, setClause, whereClause, subPredicateString, orderByClause];
    
    // Reset the predicate
    [startClause setString:@""];
    [setClause setString:@""];
    [whereClause setString:@""];
    [orderByClause setString:@""];
    [updateSetArray removeAllObjects];
    
    return returnedPredicateString;
}

// Start Clauses
-(void)selectFromTable:(NSString *)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [startClause appendFormat:@"SELECT * FROM %@" , tableLowerCase];
}

-(void)deleteFromTable:(NSString *)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [startClause appendFormat:@"DELETE FROM %@" , tableLowerCase];
}

-(void)updateTable:(NSString*)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [startClause appendFormat:@"UPDATE %@" , tableLowerCase];
}

// Set clauses

-(void)setColumn:(NSString*)columnName toString:(NSString*)newValue{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = \"%@\"" , columnNameLowerCase, newValue];
    [updateSetArray addObject:setString];
}

-(void)setColumn:(NSString*)columnName toInteger:(int)newValue;{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = %i" , columnNameLowerCase, newValue];
    [updateSetArray addObject:setString];
}


// Order by
-(void)orderAscendingByColumn:columnName{
    [orderByClause appendFormat:@" ORDER BY %@ ASC" , [columnName lowercaseString]];
}

-(void)orderDescendingByColumn:columnName{
    [orderByClause appendFormat:@" ORDER BY %@ DESC" , [columnName lowercaseString]];
}


// String Equal predicates
-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = \"%@\"", columnNameLowerCase, string];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = \"%@\"", columnNameLowerCase, string];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = \"%@\"", columnNameLowerCase, string];
    [whereClause appendFormat:@"%@", newPredicate];
}

// Contains string

-(void)whereColumn:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [whereClause appendFormat:@"%@", newPredicate];
}


// Number Equal predicates
-(void)whereColumn:(NSString*) columnName equalsInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName equalsInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName equalsInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}


// Number greater than predicates
-(void)whereColumn:(NSString*) columnName isGreaterThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ > %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isGreaterThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ > %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isGreaterThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ > %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

// Integer greater than predicates
-(void)whereColumn:(NSString*) columnName isLessThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ < %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isLessThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ < %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isLessThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ < %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}


// Equals float
-(void)whereColumn:(NSString*) columnName equalsFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName equalsFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName equalsFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

// Greater than float
-(void)whereColumn:(NSString*) columnName isGreaterThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ > %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isGreaterThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ > %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isGreaterThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ > %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

// Less than than float
-(void)whereColumn:(NSString*) columnName isLessThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ < %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isLessThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ < %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isLessThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ < %f", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}



// Boolean predicates

-(void)whereColumnIsTrue:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, 1];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnIsTrue:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, 1];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnIsTrue:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, 1];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)whereColumnIsFalse:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, 0];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnIsFalse:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, 0];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnIsFalse:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, 0];
    [whereClause appendFormat:@"%@", newPredicate];
}

// Date Equal predicates
-(void)whereColumn:(NSString*) columnName equalsDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self whereColumn:columnName equalsInteger:unixTimestamp];
}

-(void)andColumn:(NSString*) columnName equalsDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self andColumn:columnName equalsInteger:unixTimestamp];
}

-(void)orColumn:(NSString*) columnName equalsDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self orColumn:columnName equalsInteger:unixTimestamp];
}

// Date after predicates
-(void)whereColumn:(NSString*) columnName isAfterDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self whereColumn:columnName isGreaterThanInteger:unixTimestamp];
}

-(void)andColumn:(NSString*) columnName isAfterDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self andColumn:columnName isGreaterThanInteger:unixTimestamp];
}

-(void)orColumn:(NSString*) columnName isAfterDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self orColumn:columnName isGreaterThanInteger:unixTimestamp];
}


// Date before predicates
-(void)whereColumn:(NSString*) columnName isBeforeDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self whereColumn:columnName isLessThanInteger:unixTimestamp];
}

-(void)andColumn:(NSString*) columnName isBeforeDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self andColumn:columnName isLessThanInteger:unixTimestamp];
}

-(void)orColumn:(NSString*) columnName isBeforeDate:(NSDate*)date{
    int unixTimestamp = [date timeIntervalSince1970];
    [self orColumn:columnName isLessThanInteger:unixTimestamp];
}


@end
