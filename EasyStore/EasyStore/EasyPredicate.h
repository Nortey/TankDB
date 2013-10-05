//
//  EasyPredicate.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyPredicate : NSObject{
    
    NSString* _subPredicateType;
    
    NSMutableString* _startClause;
    NSMutableString* _orderByClause;
    NSMutableString* _limitClause;
    NSMutableString* _offsetClause;
    NSMutableString* _setClause;
    NSMutableString* _whereClause;
    
    NSMutableArray* _subPredicates;
    NSMutableArray* _updateSetArray;
}

/* Query methods */
-(void)selectFromTable:(NSString*)tableName;
-(void)deleteFromTable:(NSString*)tableName;
-(void)updateTable:(NSString*)tableName;

/* Compound Predicate methods */
-(void)And:(EasyPredicate*)predicate;
-(void)Or:(EasyPredicate*)predicate;

/* Predicate modifiers */
-(void)limit:(int)limit;
-(void)offset:(int)offset;
-(void)orderAscendingByColumn:columnName;
-(void)orderDescendingByColumn:columnName;

/* Properties */
-(NSString*)getPredicateString;
-(NSString*)getSubPredicateType;
-(void)setSubPredicateType:(NSString*)subPredicateType;

/* Set column methods */
-(void)setColumn:(NSString*)columnName toString:(NSString*)newValue;
-(void)setColumn:(NSString*)columnName toInteger:(int)newValue;
-(void)setColumn:(NSString*)columnName toBoolean:(BOOL)newValue;
-(void)setColumn:(NSString*)columnName toDate:(NSDate*)newValue;
-(void)setColumn:(NSString*)columnName toFloat:(float)newValue;

/* Equals string */
-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string;
-(void)andColumn:(NSString*) columnName equalsString:(NSString*)string;
-(void)orColumn:(NSString*) columnName equalsString:(NSString*)string;

/* Contains String */
-(void)whereColumn:(NSString*) columnName containsString:(NSString*)string;
-(void)andColumn:(NSString*) columnName containsString:(NSString*)string;
-(void)orColumn:(NSString*) columnName containsString:(NSString*)string;

/* Equals Integer */
-(void)whereColumn:(NSString*) columnName equalsInteger:(int)number;
-(void)andColumn:(NSString*) columnName equalsInteger:(int)number;
-(void)orColumn:(NSString*) columnName equalsInteger:(int)number;

/* Greater than integer */
-(void)whereColumn:(NSString*) columnName isGreaterThanInteger:(int)number;
-(void)andColumn:(NSString*) columnName isGreaterThanInteger:(int)number;
-(void)orColumn:(NSString*) columnName isGreaterThanInteger:(int)number;

/* Less than than integer */
-(void)whereColumn:(NSString*) columnName isLessThanInteger:(int)number;
-(void)andColumn:(NSString*) columnName isLessThanInteger:(int)number;
-(void)orColumn:(NSString*) columnName isLessThanInteger:(int)number;


/* Equals float */
-(void)whereColumn:(NSString*) columnName equalsFloat:(float)number;
-(void)andColumn:(NSString*) columnName equalsFloat:(float)number;
-(void)orColumn:(NSString*) columnName equalsFloat:(float)number;

/* Greater than float */
-(void)whereColumn:(NSString*) columnName isGreaterThanFloat:(float)number;
-(void)andColumn:(NSString*) columnName isGreaterThanFloat:(float)number;
-(void)orColumn:(NSString*) columnName isGreaterThanFloat:(float)number;

/* Less than than float */
-(void)whereColumn:(NSString*) columnName isLessThanFloat:(float)number;
-(void)andColumn:(NSString*) columnName isLessThanFloat:(float)number;
-(void)orColumn:(NSString*) columnName isLessThanFloat:(float)number;

/* Boolean is true */
-(void)whereColumnIsTrue:(NSString*) columnName;
-(void)andColumnIsTrue:(NSString*) columnName;
-(void)orColumnIsTrue:(NSString*) columnName;

/* Boolean is false */
-(void)whereColumnIsFalse:(NSString*) columnName;
-(void)andColumnIsFalse:(NSString*) columnName;
-(void)orColumnIsFalse:(NSString*) columnName;

/* Equals date */
-(void)whereColumn:(NSString*) columnName equalsDate:(NSDate*)date;
-(void)andColumn:(NSString*) columnName equalsDate:(NSDate*)date;
-(void)orColumn:(NSString*) columnName equalsDate:(NSDate*)date;

/* Is after date */
-(void)whereColumn:(NSString*) columnName isAfterDate:(NSDate*)date;
-(void)andColumn:(NSString*) columnName isAfterDate:(NSDate*)date;
-(void)orColumn:(NSString*) columnName isAfterDate:(NSDate*)date;

/* Is before date */
-(void)whereColumn:(NSString*) columnName isBeforeDate:(NSDate*)date;
-(void)andColumn:(NSString*) columnName isBeforeDate:(NSDate*)date;
-(void)orColumn:(NSString*) columnName isBeforeDate:(NSDate*)date;

 
@end
