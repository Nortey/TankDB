//
//  EasyColumn.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "EasyColumn.h"

@implementation EasyColumn

/* Public Methods */

-(id)initWitName:(NSString*)name withType:(EasyType)type{
    self = [super init];
    if (self) {
        _name = [[NSString alloc] initWithString:name];
        _type = type;
    }
    return self;
}

-(NSString*)getCreationString{
    NSString* columnType = [Utility convertType:_type];
    NSString* createString = [NSString stringWithFormat:@"%@ %@", _name, columnType];
    
    return createString;
}

/* Properties */

-(NSString*)getName{
    return _name;
}


-(EasyType)getType{
    return _type;
}


@end
