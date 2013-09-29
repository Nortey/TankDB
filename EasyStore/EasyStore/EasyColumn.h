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
    NSString* _name;
    EasyType _type;
}


/* Public Methods */
-(id)initWitName:(NSString*)name withType:(EasyType)type;
-(NSString*)getCreationString;


/* Properties */
-(NSString*)getName;
-(EasyType)getType;

@end
