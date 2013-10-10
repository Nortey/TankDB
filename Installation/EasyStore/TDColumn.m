//
//  EasyColumn.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "TDColumn.h"

@implementation TDColumn

/*
 *  Initialize table
 *  Initializes the column with the given name and column type.
 */
-(id)initWithName:(NSString*)name withType:(EasyType)type{
    self = [super init];
    if (self) {
        _primaryKey = @"";
        _autoIncrement = @"";
        _name = [[NSString alloc] initWithString:name];
        _type = type;
    }
    return self;
}

/*
 *  Set column as identity
 *  When called, this column will be an autoincrementing primary key in the database upon creation
 */
-(void)setAsIdentityColumn{
    _primaryKey = @" PRIMARY KEY ";
    _autoIncrement = @" AUTOINCREMENT";
}

/*
 *  Set column as primary key
 *  When called, this column will be an primary key in the database upon creation
 */
-(void)setAsPrimaryKey{
    _primaryKey = @" PRIMARY KEY ";
}


/*
 *  Get column creation string
 *  Constructs the query used to create the column
 */
-(NSString*)getCreationString{
    NSString* columnType = [Utility convertType:_type];
    NSString* createString = [NSString stringWithFormat:@"%@ %@%@%@", [_name lowercaseString], columnType, _primaryKey, _autoIncrement];
    
    return createString;
}

/*
 *  Properties
 */

-(NSString*)getName{
    return _name;
}


-(EasyType)getType{
    return _type;
}


@end
