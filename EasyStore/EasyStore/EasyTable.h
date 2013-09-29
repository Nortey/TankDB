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


/* Public Methods */
-(EasyColumn*)createColumnWithName:(NSString*)name withType:(int)type;
-(NSString*)getCreationString;

/* Properties */
-(NSString*)getName;

@end
