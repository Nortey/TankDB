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
    [entryDicitonary setObject:string forKey:columnName];
}

-(void)setNumber:(int)number forColumnName:(NSString*)columnName{
    NSNumber *numberObject = [NSNumber numberWithInteger:number];
    [entryDicitonary setObject:numberObject forKey:columnName];
}

-(NSString*)getStringForColumnName:(NSString*)columnName{
    return [entryDicitonary objectForKey:columnName];
}

-(int)getNumberForColumnName:(NSString*)columnName{
    return [[entryDicitonary objectForKey:columnName] intValue];
}


-(NSString *)description{
    return [entryDicitonary description];
}

/* Properties */
-(NSMutableDictionary*)getEntries{
    return entryDicitonary;
}

@end
