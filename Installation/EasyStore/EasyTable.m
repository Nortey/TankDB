//
//  EasyTable.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "EasyTable.h"


@implementation EasyTable

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
-(EasyColumn*)createColumnWithName:(NSString*)name withType:(int)type{
    EasyColumn* column = [[EasyColumn alloc] initWithName:name withType:type];
    [_columns addObject:column];
    
    return column;
}

-(EasyColumn*)createStringColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyString];
}

-(EasyColumn*)createIntegerColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyInteger];
}

-(EasyColumn*)createBooleanColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyBoolean];
}

-(EasyColumn*)createDateColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyDate];
}

-(EasyColumn*)createFloatColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyFloat];
}


/*
 *  Add Identity column
 *  Adds a primary autoincrementing column named 'id' to the table
 */
-(void)addIdentityColumn{
    EasyColumn* identityColumn = [self createColumnWithName:@"id" withType:EasyInteger];
    [identityColumn setAsIdentityColumn];
}


/*
 *  Get table creation string
 *  Constructs the query used to create the table
 */
-(NSString*)getCreationString;{
    NSMutableArray* columnStringArray = [NSMutableArray new];
    for(EasyColumn* column in _columns){
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
