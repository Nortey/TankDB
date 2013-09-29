//
//  EasyStore.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "EasyStore.h"

/* Static variables */
static NSMutableArray* _tables;
static sqlite3* _database;
static NSString* _databasePath;
static EasyStatus _status;
static NSString* _errorMessage;

@implementation EasyStore


/*
    Initialize
 */
+(void)start{
    _tables = [NSMutableArray new];
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"easy_store.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO){
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_database) == SQLITE_OK){
            sqlite3_close(_database);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
}

+(void)done{
    for(EasyTable *table in _tables){
        NSString* tableName = [table getName];
        NSString* tableCreatetionString = [table getCreationString];
        NSString* createTableQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ %@", tableName, tableCreatetionString];
        [EasyStore invokeRawQuery:createTableQuery];
    }
}

+(EasyStatus)getStatus{
    return _status;
}

+(NSString*)getErrorMessage{
    return _errorMessage;
}

+(void)setEasyStoreStatus:(EasyStatus)status withError:(NSString*)error{
    _status = status;
    _errorMessage = [NSString stringWithString:error];
}

+(void)invokeRawQuery:(NSString*)query{
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_database) == SQLITE_OK){
        char *errMsg;
        const char *sql_stmt = [query UTF8String];
        
        if (sqlite3_exec(_database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            [EasyStore setEasyStoreStatus:Easy_ERROR withError:[NSString stringWithFormat:@"%s", errMsg]];
        }else{
            [EasyStore setEasyStoreStatus:Easy_OK withError:@""];
        }
        sqlite3_close(_database);
    } else {
       [EasyStore setEasyStoreStatus:Easy_ERROR withError:@"Failed to open database"];
    }
}

/*
    Create table
*/
+(EasyTable*)createTableWithName:(NSString*)name{
    EasyTable* table = [[EasyTable alloc] initWithName:name];
    [_tables addObject:table];
    
    return table;
}

/*
    Store into table
*/

+(void)store:(NSDictionary*)entry intoTable:(NSString*)tableName{
    NSMutableArray* columnNamesArray = [NSMutableArray new];
    NSMutableArray* columnValuesArray = [NSMutableArray new];
    
    for(NSString* key in entry){
        [columnNamesArray addObject:key];
        NSObject *value = [entry objectForKey:key];
        
        if([value isKindOfClass:[NSString class]]){
            value = [NSString stringWithFormat:@"\"%@\"", value];
        }
        
        [columnValuesArray addObject:value];
    }
    
    NSString *columnNames = [columnNamesArray componentsJoinedByString:@", "];
    NSString *columnValues = [columnValuesArray componentsJoinedByString:@", "];
    NSString *storeQuery = [NSString stringWithFormat:@"INSERT INTO %@ ( %@ ) VALUES ( %@ )", tableName, columnNames, columnValues];
   
    [EasyStore invokeRawQuery:storeQuery];
}



@end
