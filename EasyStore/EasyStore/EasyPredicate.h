//
//  EasyPredicate.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyPredicate : NSObject{
    /*BOOL isWhereClause;
    BOOL isAndClause;
    BOOL isOrClause;*/
    
    NSMutableString *predicateString;
}

-(void)selectFromTable:(NSString*)tableName;

// Equals string
-(void)whereColumn:(NSString*) columnName equalsString:(NSString*)string;
-(void)andColumnName:(NSString*) columnName equalsString:(NSString*)string;
-(void)orColumnName:(NSString*) columnName equalsString:(NSString*)string;

/*
// Begins with / Ends with / Contains
-(void)whereColumn:(NSString*) columnName isLikeString:(NSString*)string;
-(void)andColumnName:(NSString*) columnName isLikeString:(NSString*)string;
-(void)orColumnName:(NSString*) columnName isLikeString:(NSString*)string;
*/

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

-(NSString*)getPredicateString;

 
@end
