//
//  EasyColumn.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@interface EasyColumn : NSObject{
    // MULTICOLUMN PRIMARY KEYS
    
    NSString* _name;
    NSString* _autoIncrement;
    NSString* _primaryKey;
    EasyType _type;
}


/* Public Methods */
-(id)initWitName:(NSString*)name withType:(EasyType)type;
-(void)setAsIdentityColumn;
-(void)setAsPrimaryKey;

/* Private Methods */
-(NSString*)getCreationString;


/* Properties */
-(NSString*)getName;
-(EasyType)getType;

@end
