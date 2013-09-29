//
//  EasyStore.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <sqlite3.h>
#import <Foundation/Foundation.h>

#import "EasyTable.h"
#import "EasyColumn.h"

@interface EasyStore : NSObject{
    
}

/* Public Methods */
+(void)start;
+(void)done;
+(EasyStatus)getStatus;
+(NSString*)getErrorMessage;
+(void)setEasyStoreStatus:(EasyStatus)status withError:(NSString*)error;

+(EasyTable*)createTableWithName:(NSString*)name;
+(void)invokeRawQuery:(NSString*)query;
+(void)store:(NSDictionary*)entry intoTable:(NSString*)tableName;


/* Private Methods */

@end
