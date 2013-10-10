//
//  EasyTable.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDColumn.h"

@interface TDTable : NSObject{
    NSString* _name;
    NSMutableArray* _columns;
}


-(id)initWithName:(NSString*)name;

/* Create columns */
-(TDColumn*)createColumnWithName:(NSString*)name withType:(int)type;
-(TDColumn*)createStringColumnWithName:(NSString*)name;
-(TDColumn*)createIntegerColumnWithName:(NSString*)name;
-(TDColumn*)createBooleanColumnWithName:(NSString*)name;
-(TDColumn*)createDateColumnWithName:(NSString*)name;
-(TDColumn*)createFloatColumnWithName:(NSString*)name;

/* Other public methods */
-(void)addIdentityColumn;

/* Private Methods */
-(NSString*)getCreationString;

/* Properties */
-(NSString*)getName;

@end
