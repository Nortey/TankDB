//
//  TDPredicate.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "TDPredicate.h"

@implementation TDPredicate

/*
 *  Initializes the predicate
 */
-(id)init{
    self = [super init];
    if(self){
        _startClause = [NSMutableString stringWithString:@""];
        _setClause = [NSMutableString stringWithString:@""];
        _whereClause = [NSMutableString stringWithString:@""];
        _orderByClause = [NSMutableString stringWithString:@""];
        _limitClause = [NSMutableString stringWithString:@""];
        
        _updateSetArray = [NSMutableArray new];
        _subPredicates = [NSMutableArray new];
    }
    return self;
}

/*
 *  Start clause methods
 *  Beginning of predicate clauses including SELECT, DELETE, and UPDATE
 */
-(void)selectFromTable:(NSString *)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [_startClause appendFormat:@"SELECT * FROM %@" , tableLowerCase];
}

-(void)deleteFromTable:(NSString *)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [_startClause appendFormat:@"DELETE FROM %@" , tableLowerCase];
}

-(void)updateTable:(NSString*)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [_startClause appendFormat:@"UPDATE %@" , tableLowerCase];
}

-(void)countEntriesInTable:(NSString*)tableName{
    NSString* tableLowerCase = [tableName lowercaseString];
    [_startClause appendFormat:@"SELECT COUNT(*) AS count FROM %@" , tableLowerCase];
}

/*
 *  Compound predicate methods
 *  Called to surround an entire predicate in an AND or an OR
 */
-(void)And:(TDPredicate*)predicate{
    [predicate setSubPredicateType:@"AND"];
    [_subPredicates addObject:predicate];
}

-(void)Or:(TDPredicate*)predicate{
    [predicate setSubPredicateType:@"OR"];
    [_subPredicates addObject:predicate];
}

/*
 *  Predicate modifiers
 *  Modifiers called for predicates including ORDER, LIMIT and OFFSET
 */
-(void)withLimit:(int)limit{
    [_limitClause appendFormat:@" LIMIT %i", limit];
}

-(void)withLimit:(int)limit andOffset:(int)offset{
    [_limitClause appendFormat:@" LIMIT %i OFFSET %i", limit, offset];
}

-(void)orderAscendingByColumn:columnName{
    [_orderByClause appendFormat:@" ORDER BY %@ ASC" , [columnName lowercaseString]];
}

-(void)orderDescendingByColumn:columnName{
    [_orderByClause appendFormat:@" ORDER BY %@ DESC" , [columnName lowercaseString]];
}

/*
 *  Get predicate string
 *  Constructs the entire predicate including compound predicates
 */
-(NSString*)getPredicateString{
    
    // Append update parts of predicate
    [_setClause setString:[_updateSetArray componentsJoinedByString:@" , "]];
    
    // Construct sub predicates
    NSMutableString* subPredicateString = [NSMutableString stringWithString:@""];
    for(TDPredicate* predicate in _subPredicates){
        NSString* removeWhereString = [[predicate getPredicateString] stringByReplacingOccurrencesOfString:@"WHERE" withString:@""];
        NSString* subPredicate = [NSString stringWithFormat:@" %@ ( %@ ) ", [predicate getSubPredicateType], removeWhereString];
        [subPredicateString appendString:subPredicate];
    }
    
    // Construct predicate string
    NSString* returnedPredicateString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                                         _startClause, _setClause, _whereClause, subPredicateString, _orderByClause,_limitClause];
    return returnedPredicateString;
}

/*
 *  Properties
 */
-(NSString*)getSubPredicateType{
    return _subPredicateType;
}

-(void)setSubPredicateType:(NSString*)predicateType{
    _subPredicateType = [NSString stringWithString:predicateType];
}


/*
 *  Set column methods
 *  Set column for each data type for UPDATE
 */
-(void)setColumn:(NSString*)columnName toString:(NSString*)newValue{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = \"%@\"" , columnNameLowerCase, newValue];
    [_updateSetArray addObject:setString];
}

-(void)setColumn:(NSString*)columnName toInteger:(int)newValue;{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = %i" , columnNameLowerCase, newValue];
    [_updateSetArray addObject:setString];
}

-(void)setColumn:(NSString*)columnName toDate:(NSDate*)newValue{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    int unixTimestamp = [newValue timeIntervalSince1970];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = %i" , columnNameLowerCase, unixTimestamp];
    [_updateSetArray addObject:setString];
}

-(void)setColumn:(NSString*)columnName toFloat:(float)newValue{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = %f" , columnNameLowerCase, newValue];
    [_updateSetArray addObject:setString];
}

-(void)setColumnToTrue:(NSString *)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = 1" , columnNameLowerCase];
    [_updateSetArray addObject:setString];
}

-(void)setColumnToFalse:(NSString *)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* setString = [NSString stringWithFormat:@" SET %@ = 0" , columnNameLowerCase];
    [_updateSetArray addObject:setString];
}

/*
 *  String equal predicates
 */
-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = \"%@\"", columnNameLowerCase, string];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = \"%@\"", columnNameLowerCase, string];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName equalsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = \"%@\"", columnNameLowerCase, string];
    [_whereClause appendFormat:@"%@", newPredicate];
}

/*
 *  Contains string predicates
 */
-(void)whereColumn:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName containsString:(NSString*)string{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ LIKE \"%@%@%@\"", columnNameLowerCase, @"%", string, @"%"];
    [_whereClause appendFormat:@"%@", newPredicate];
}


/*
 *  Integer equal predicates
 */
-(void)whereColumn:(NSString*) columnName equalsInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName equalsInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName equalsInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}


/*
 *  Greater than integer predicates
 */
-(void)whereColumn:(NSString*) columnName isGreaterThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ > %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isGreaterThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ > %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isGreaterThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ > %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

/*
 *  Less than integer predicates
 */
-(void)whereColumn:(NSString*) columnName isLessThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ < %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isLessThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ < %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isLessThanInteger:(int)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ < %i", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}


/*
 *  Equals float predicates
 */
-(void)whereColumn:(NSString*) columnName equalsFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName equalsFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName equalsFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

/*
 *  Greater than float predicates
 */
-(void)whereColumn:(NSString*) columnName isGreaterThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ > %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isGreaterThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ > %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isGreaterThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ > %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

/*
 *  Less than float predicates
 */
-(void)whereColumn:(NSString*) columnName isLessThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ < %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumn:(NSString*) columnName isLessThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ < %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumn:(NSString*) columnName isLessThanFloat:(float)number{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ < %f", columnNameLowerCase, number];
    [_whereClause appendFormat:@"%@", newPredicate];
}


/*
 *  Boolean true predicates
 */
-(void)whereColumnIsTrue:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, 1];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnIsTrue:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, 1];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnIsTrue:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, 1];
    [_whereClause appendFormat:@"%@", newPredicate];
}

/*
 *  Boolean false predicates
 */
-(void)whereColumnIsFalse:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" WHERE %@ = %i", columnNameLowerCase, 0];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)andColumnIsFalse:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" AND %@ = %i", columnNameLowerCase, 0];
    [_whereClause appendFormat:@"%@", newPredicate];
}

-(void)orColumnIsFalse:(NSString*) columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSString* newPredicate = [NSString stringWithFormat:@" OR %@ = %i", columnNameLowerCase, 0];
    [_whereClause appendFormat:@"%@", newPredicate];
}

/*
 *  Date equal predicates
 */
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

/*
 *  Is after date predicates
 */
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


/*
 *  Is before date predicates
 */
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
