//
//  EasyEntry.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "EasyEntry.h"

@implementation EasyEntry

-(id)init{
    self = [super init];
    if(self){
        entryDicitonary = [NSMutableDictionary new];
    }
    
    return self;
}

/* Public Methods */
-(void)setString:(NSString*)string forColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    [entryDicitonary setObject:string forKey:columnNameLowerCase];
}

-(void)setInteger:(int)integer forColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *numberObject = [NSNumber numberWithInteger:integer];
    [entryDicitonary setObject:numberObject forKey:columnNameLowerCase];
}

-(void)setBoolean:(BOOL)booleanValue forColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *boolObject = [NSNumber numberWithBool:booleanValue];
    [entryDicitonary setObject:boolObject forKey:columnNameLowerCase];
}

-(void)setDate:(NSDate*)date forColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *dateNumber = [NSNumber numberWithInt:[date timeIntervalSince1970]];
    [entryDicitonary setObject:dateNumber forKey:columnNameLowerCase];
}

-(void)setDateAsNowForColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *dateNumber = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
    [entryDicitonary setObject:dateNumber forKey:columnNameLowerCase];
}

-(void)setFloat:(float)floatNumber forColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    NSNumber *numberObject = [NSNumber numberWithFloat:floatNumber];
    [entryDicitonary setObject:numberObject forKey:columnNameLowerCase];
}


-(NSString*)getStringForColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [entryDicitonary objectForKey:columnNameLowerCase];
}

-(int)getIntegerForColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [[entryDicitonary objectForKey:columnNameLowerCase] intValue];
}

-(BOOL)getBooleanForColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [[entryDicitonary objectForKey:columnNameLowerCase] boolValue];
}

-(NSDate*)getDateForColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    int unixTimestamp = [[entryDicitonary objectForKey:columnNameLowerCase] integerValue];
    return [NSDate dateWithTimeIntervalSince1970:unixTimestamp];
}

-(float)getFloatForColumnName:(NSString*)columnName{
    NSString* columnNameLowerCase = [columnName lowercaseString];
    return [[entryDicitonary objectForKey:columnNameLowerCase] floatValue];
}


-(NSString *)description{
    return [entryDicitonary description];
}

/* Properties */
-(NSMutableDictionary*)getEntries{
    return entryDicitonary;
}

@end
