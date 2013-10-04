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
    }
    return self;
}

-(NSString*)getPredicateString{
    
    // Append update parts of predicate
    [setClause setString:[updateSetArray componentsJoinedByString:@" , "]];
    
    // Construct predicate string
    NSString* returnedPredicateString = [NSString stringWithFormat:@"%@%@%@%@", startClause, setClause, whereClause, orderByClause];
    
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

// Needs testing
-(void)setColumn:(NSString*)columnName toString:(NSString*)newValue{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = \"%@\"" , columnNameLowerCase, newValue];
    [updateSetArray addObject:setString];
}

// Needs testing
-(void)setColumn:(NSString*)columnName toNumber:(int)newValue;{
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

-(void)andColumnName:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = \"%@\"", columnNameLowerCase, string];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName equalsString:(NSString*)string{
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

-(void)andColumnName:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [whereClause appendFormat:@"%@", newPredicate];
}


// Number Equal predicates
-(void)whereColumn:(NSString*) columnName equalsNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName equalsNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName equalsNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}


// Number greater than predicates
-(void)whereColumn:(NSString*) columnName isGreaterThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ > %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName isGreaterThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ > %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName isGreaterThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ > %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

// Number greater than predicates
-(void)whereColumn:(NSString*) columnName isLessThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ < %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnName:(NSString*) columnName isLessThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ < %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnName:(NSString*) columnName isLessThanNumber:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ < %i", columnNameLowerCase, number];
    [whereClause appendFormat:@"%@", newPredicate];
}


@end
