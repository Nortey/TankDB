//
//  EasyEntry.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "TDEntry.h"

@implementation TDEntry

/*
 *  Initializes the entry
 */
-(id)init{
    self = [super init];
    if(self){
        _entryDicitonary = [NSMutableDictionary new];
    }
    
    return self;
}

/*
 *  Set column value methods
 *  Sets the value for the column to be saved in the database
 */
-(void)setString:(NSString*)string forColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    [_entryDicitonary setObject:string forKey:columnNameLowerCase];
}

-(void)setInteger:(int)integer forColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *numberObject = [NSNumber numberWithInteger:integer];
    [_entryDicitonary setObject:numberObject forKey:columnNameLowerCase];
}

-(void)setBoolean:(BOOL)booleanValue forColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *boolObject = [NSNumber numberWithBool:booleanValue];
    [_entryDicitonary setObject:boolObject forKey:columnNameLowerCase];
}

-(void)setDate:(NSDate*)date forColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *dateNumber = [NSNumber numberWithInt:[date timeIntervalSince1970]];
    [_entryDicitonary setObject:dateNumber forKey:columnNameLowerCase];
}

-(void)setDateAsNowForColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *dateNumber = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
    [_entryDicitonary setObject:dateNumber forKey:columnNameLowerCase];
}

-(void)setFloat:(float)floatNumber forColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *numberObject = [NSNumber numberWithFloat:floatNumber];
    [_entryDicitonary setObject:numberObject forKey:columnNameLowerCase];
}


/*
 *  Get column value methods
 *  Gets the value for the column
 */
-(NSString*)stringForColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [_entryDicitonary objectForKey:columnNameLowerCase];
}

-(int)integerForColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [[_entryDicitonary objectForKey:columnNameLowerCase] intValue];
}

-(BOOL)booleanForColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [[_entryDicitonary objectForKey:columnNameLowerCase] boolValue];
}

-(NSDate*)dateForColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    int unixTimestamp = [[_entryDicitonary objectForKey:columnNameLowerCase] integerValue];
    return [NSDate dateWithTimeIntervalSince1970:unixTimestamp];
}

-(float)floatForColumn:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [[_entryDicitonary objectForKey:columnNameLowerCase] floatValue];
}


/*
 *  Properties
 */

-(NSMutableDictionary*)getEntries{
    return _entryDicitonary;
}

-(NSString*)description{
    NSMutableString* entryString = [NSMutableString stringWithString:@"\n"];
    
    for(NSString* key in _entryDicitonary){
        [entryString appendFormat:@"%@ : %@ \n", key, [_entryDicitonary objectForKey:key]];
    }
    
    return entryString;
}

@end
