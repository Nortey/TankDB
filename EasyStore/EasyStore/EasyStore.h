//
//  EasyStore.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <sqlite3.h>
#import <Foundation/Foundation.h>

#import "EasyConstants.h"
#import "Utility.h"
#import "EasyTable.h"
#import "EasyColumn.h"
#import "EasyEntry.h"
#import "EasyPredicate.h"

@interface EasyStore : NSObject{

}

/* Public Methods */
+(void)start;
+(void)done;
+(EasyTable*)createTableWithName:(NSString*)name;
+(void)clearEasyStore;


/* Queries */
+(void)invokeRawQuery:(NSString*)query;
+(NSArray*)invokeRawSelectQuery:(NSString*)query;
+(void)store:(EasyEntry*)entry intoTable:(NSString*)tableName;
+(NSArray*)getAllEntriesForTable:(NSString*)tableName;

/* Select */
+(NSArray*)getEntriesWithPredicate:(EasyPredicate*)predicate;
+(void)deleteEntriesWithPredicate:(EasyPredicate*)predicate;
+(void)updateEntriesWithPredicate:(EasyPredicate*)predicate;

/* Private Methods */
+(void)setEasyStoreStatus:(EasyStatus)status withError:(NSString*)error;

/* Properties */
+(EasyStatus)getStatus;
+(NSString*)getErrorMessage;

@end
