//
//  TDTable.m
//  TankDB
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "TDTable.h"


@implementation TDTable

/* 
 *  Initialize table
 *  Initializes the table with the provided name. Will convert the name to lowercase.
 */
-(id)initWithName:(NSString*)name{
    self = [super init];
    if (self) {
        NSString* tableName = [name lowercaseString];
        
        _name = [[NSString alloc] initWithString:tableName];
        _columns = [NSMutableArray new];
    }
    return self;
}


/*
 *  Column creation
 *  Creates the column based on the column datatype
 */
-(TDColumn*)createColumnWithName:(NSString*)name withType:(int)type{
    TDColumn* column = [[TDColumn alloc] initWithName:name withType:type];
    [_columns addObject:column];
    
    return column;
}

-(TDColumn*)createStringColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:TDString];
}

-(TDColumn*)createIntegerColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:TDInteger];
}

-(TDColumn*)createBooleanColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:TDBoolean];
}

-(TDColumn*)createDateColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:TDDate];
}

-(TDColumn*)createFloatColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:TDFloat];
}


/*
 *  Add Identity column
 *  Adds a primary autoincrementing column named 'id' to the table
 */
-(void)addIdentityColumn{
    TDColumn* identityColumn = [self createColumnWithName:@"id" withType:TDInteger];
    [identityColumn setAsIdentityColumn];
}


/*
 *  Get table creation string
 *  Constructs the query used to create the table
 */
-(NSString*)getCreationString;{
    NSMutableArray* columnStringArray = [NSMutableArray new];
    for(TDColumn* column in _columns){
        [columnStringArray addObject:[column getCreationString]];
    }
    
    NSString* allColumnStrings = [columnStringArray componentsJoinedByString:@", "];
    NSString* createString = [NSString stringWithFormat:@"( %@ )", allColumnStrings];
    
    return createString;
}


/* 
 *  Properties
 */

-(NSString*)getName{
    return _name;
}

@end
