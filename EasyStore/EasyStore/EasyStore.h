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

/* Database creation methods */
+(void)beginDatabaseCreation;
+(void)completeDatabaseCreation;
+(void)deleteDatabaseFile;
+(EasyTable*)createTableWithName:(NSString*)name;

/* Raw queries */
+(void)invokeRawQuery:(NSString*)query;
+(NSArray*)invokeRawSelectQuery:(NSString*)query;

/* Database modifier methods */
+(void)clearEasyStore;
+(void)store:(EasyEntry*)entry intoTable:(NSString*)tableName;
+(NSArray*)selectAllEntriesForTable:(NSString*)tableName;

/* Predicate methods */
+(NSArray*)selectEntriesWithPredicate:(EasyPredicate*)predicate;
+(void)deleteEntriesWithPredicate:(EasyPredicate*)predicate;
+(void)updateEntriesWithPredicate:(EasyPredicate*)predicate;

/* Private Methods */
+(void)setEasyStoreStatus:(EasyStatus)status withError:(NSString*)error;

/* Properties */
+(EasyStatus)getStatus;
+(NSString*)getErrorMessage;

@end
