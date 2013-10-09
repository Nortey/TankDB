//
//  EasyTable.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyColumn.h"

@interface EasyTable : NSObject{
    NSString* _name;
    NSMutableArray* _columns;
}


-(id)initWithName:(NSString*)name;

/* Create columns */
-(EasyColumn*)createColumnWithName:(NSString*)name withType:(int)type;
-(EasyColumn*)createStringColumnWithName:(NSString*)name;
-(EasyColumn*)createIntegerColumnWithName:(NSString*)name;
-(EasyColumn*)createBooleanColumnWithName:(NSString*)name;
-(EasyColumn*)createDateColumnWithName:(NSString*)name;
-(EasyColumn*)createFloatColumnWithName:(NSString*)name;

/* Other public methods */
-(void)addIdentityColumn;

/* Private Methods */
-(NSString*)getCreationString;

/* Properties */
-(NSString*)getName;

@end
