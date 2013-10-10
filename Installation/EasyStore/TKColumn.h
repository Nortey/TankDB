//
//  EasyColumn.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@interface TKColumn : NSObject{
    NSString* _name;
    NSString* _autoIncrement;
    NSString* _primaryKey;
    EasyType _type;
}

-(id)initWithName:(NSString*)name withType:(EasyType)type;

/* Other Public Methods */
-(void)setAsIdentityColumn;
-(void)setAsPrimaryKey;

/* Private Methods */
-(NSString*)getCreationString;

/* Properties */
-(NSString*)getName;
-(EasyType)getType;

@end
