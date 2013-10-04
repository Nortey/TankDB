//
//  EasyTable.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "EasyTable.h"


@implementation EasyTable

/* Public Methods */

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
 Create column
 */
-(EasyColumn*)createColumnWithName:(NSString*)name withType:(int)type{
    EasyColumn* column = [[EasyColumn alloc] initWitName:name withType:type];
    [_columns addObject:column];
    
    return column;
}

-(EasyColumn*)createStringColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyString];
}


-(EasyColumn*)createNumberColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyNumber];
}

-(EasyColumn*)createBooleanColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyBoolean];
}

-(EasyColumn*)createDateColumnWithName:(NSString*)name{
    return [self createColumnWithName:name withType:EasyDate];
}

-(void)addIdentityColumn{
    EasyColumn* identityColumn = [self createColumnWithName:@"id" withType:EasyNumber];
    [identityColumn setAsIdentityColumn];
}


/* Private Methods */
-(NSString*)getCreationString;{
    NSMutableArray* columnStringArray = [NSMutableArray new];
    for(EasyColumn* column in _columns){
        [columnStringArray addObject:[column getCreationString]];
    }
    
    NSString* allColumnStrings = [columnStringArray componentsJoinedByString:@", "];
    NSString* createString = [NSString stringWithFormat:@"( %@ )", allColumnStrings];
    
    return createString;
}


/* Properties */

-(NSString*)getName{
    return _name;
}

@end
