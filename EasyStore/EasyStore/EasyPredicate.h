//
//  EasyPredicate.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO Error if calling WHERE multiple times

@interface EasyPredicate : NSObject{
    /*BOOL isWhereClause;
    BOOL isAndClause;
    BOOL isOrClause;*/
    
    NSMutableString *startClause;
    NSMutableString *orderByClause;
    NSMutableString *setClause;
    NSMutableString *whereClause;
    NSMutableArray* updateSetArray;
}

-(void)selectFromTable:(NSString*)tableName;
-(void)deleteFromTable:(NSString*)tableName;
-(void)updateTable:(NSString*)tableName;

-(void)setColumn:(NSString*)columnName toString:(NSString*)newValue;
-(void)setColumn:(NSString*)columnName toNumber:(int)newValue;

-(void)orderAscendingByColumn:columnName;
-(void)orderDescendingByColumn:columnName;

// Equals string
-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string;
-(void)andColumnName:(NSString*) columnName equalsString:(NSString*)string;
-(void)orColumnName:(NSString*) columnName equalsString:(NSString*)string;

// Contains string
-(void)whereColumn:(NSString*) columnName containsString:(NSString*)string;
-(void)andColumnName:(NSString*) columnName containsString:(NSString*)string;
-(void)orColumnName:(NSString*) columnName containsString:(NSString*)string;

// Equals number
-(void)whereColumn:(NSString*) columnName equalsNumber:(int)number;
-(void)andColumnName:(NSString*) columnName equalsNumber:(int)number;
-(void)orColumnName:(NSString*) columnName equalsNumber:(int)number;

// Greater than number
-(void)whereColumn:(NSString*) columnName isGreaterThanNumber:(int)number;
-(void)andColumnName:(NSString*) columnName isGreaterThanNumber:(int)number;
-(void)orColumnName:(NSString*) columnName isGreaterThanNumber:(int)number;

// Less than than number
-(void)whereColumn:(NSString*) columnName isLessThanNumber:(int)number;
-(void)andColumnName:(NSString*) columnName isLessThanNumber:(int)number;
-(void)orColumnName:(NSString*) columnName isLessThanNumber:(int)number;

// Boolean values
-(void)whereColumnIsTrue:(NSString*) columnName;
-(void)andColumnNameIsTrue:(NSString*) columnName;
-(void)orColumnNameIsTrue:(NSString*) columnName;

-(void)whereColumnIsFalse:(NSString*) columnName;
-(void)andColumnNameIsFalse:(NSString*) columnName;
-(void)orColumnNameIsFalse:(NSString*) columnName;

// Date values

//TODO IMPLEMENT
/*
-(void)whereColumn:(NSString*) columnName equalsDate:(NSDate*)date;
-(void)andColumnName:(NSString*) columnName equalsDate:(NSDate*)date;
-(void)orColumnName:(NSString*) columnName equalsDate:(NSDate*)date;

-(void)whereColumn:(NSString*) columnName isAfterDate:(NSDate*)date;
-(void)andColumnName:(NSString*) columnName isAfterDate:(NSDate*)date;
-(void)orColumnName:(NSString*) columnName isAfterDate:(NSDate*)date;

-(void)whereColumn:(NSString*) columnName isBeforeDate:(NSDate*)date;
-(void)andColumnName:(NSString*) columnName isBeforeDate:(NSDate*)date;
-(void)orColumnName:(NSString*) columnName isBeforeDate:(NSDate*)date;
 */

-(NSString*)getPredicateString;

 
@end
