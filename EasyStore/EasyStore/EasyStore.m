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
    Public Methods
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


+(EasyTable*)createTableWithName:(NSString*)name{
    EasyTable* table = [[EasyTable alloc] initWithName:name];
    [_tables addObject:table];
    
    return table;
}


+(void)clearEasyStore{
    NSArray* tablesArray = [EasyStore getAllEntriesForTable:@"sqlite_master"];
    
    for(EasyEntry* entry in tablesArray){
        NSString* tableName = [entry getStringForColumnName:@"tbl_name"];
        NSString* dropQuery = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", tableName];
        [EasyStore invokeRawQuery:dropQuery];
    }
}

+(void)addIdentityColumn{
    
}

/*
    Queries
 */
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

+(NSArray*)invokeRawSelectQuery:(NSString*)query{
    NSMutableArray* selectArray = [NSMutableArray new];
    sqlite3_stmt *selectstmt;
    
    const char *dbpath = [_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_database) == SQLITE_OK) {
        const char *command = [query UTF8String];
        
        if (sqlite3_prepare_v2(_database, command, -1, &selectstmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(selectstmt) == SQLITE_ROW) {
                NSMutableDictionary *columnDictionary = [NSMutableDictionary new];
                
                int numColumns = sqlite3_column_count(selectstmt);
                for(int i=0; i<numColumns; i++){
                    NSString *columnName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, i)];
                    NSString *columnValue = nil;
                    @try{
                        columnValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, i)];
                    }@catch (NSException* e) {
                        
                    }
                    
                    if(columnValue != nil){
                        [columnDictionary setObject:columnValue forKey:columnName];
                    }
                }
                [selectArray addObject:columnDictionary];
            }
            
            [EasyStore setEasyStoreStatus:Easy_OK withError:@""];
        }else{
            [EasyStore setEasyStoreStatus:Easy_ERROR withError:@"Failed to open database"];
        }
        sqlite3_finalize(selectstmt);
    }
    
    sqlite3_close (_database);
    
    return selectArray;
}

+(void)store:(EasyEntry*)entry intoTable:(NSString*)tableName{
    NSMutableArray* columnNamesArray = [NSMutableArray new];
    NSMutableArray* columnValuesArray = [NSMutableArray new];
    NSMutableDictionary* entries = [entry getEntries];
    NSString* tableNameLowerCase = [tableName lowercaseString];
    
    for(NSString* key in entries){
        [columnNamesArray addObject:key];
        NSObject *value = [entries objectForKey:key];
        
        if([value isKindOfClass:[NSString class]]){
            value = [NSString stringWithFormat:@"\"%@\"", value];
        }
        
        [columnValuesArray addObject:value];
    }
    	
    NSString *columnNames = [columnNamesArray componentsJoinedByString:@", "];
    NSString *columnValues = [columnValuesArray componentsJoinedByString:@", "];
    NSString *storeQuery = [NSString stringWithFormat:@"INSERT INTO %@ ( %@ ) VALUES ( %@ )", tableNameLowerCase, columnNames, columnValues];
    
    [EasyStore invokeRawQuery:storeQuery];
}

+(NSArray*)getAllEntriesForTable:(NSString*)tableName{
    NSString* tableNameLowerCase = [tableName lowercaseString];
    NSString* selectQuery = [NSString stringWithFormat:@"SELECT * FROM %@", tableNameLowerCase];
    NSArray* selectArray = [EasyStore invokeRawSelectQuery:selectQuery];
    
    NSMutableArray* allEntries = [NSMutableArray new];
    for(NSDictionary* dict in selectArray){
        EasyEntry* entry = [EasyEntry new];
        
        for(NSString* key in dict){
            [entry setString:[dict objectForKey:key] forColumnName:key];
        }
        
        [allEntries addObject:entry];
    }
    
    return allEntries;
}

+(NSArray*)getEntriesWithPredicate:(EasyPredicate*)predicate{
    NSString *selectQuery = [predicate getPredicateString];
    NSArray* selectArray = [EasyStore invokeRawSelectQuery:selectQuery];
    
    NSMutableArray* allEntries = [NSMutableArray new];
    for(NSDictionary* dict in selectArray){
        EasyEntry* entry = [EasyEntry new];
        
        for(NSString* key in dict){
            [entry setString:[dict objectForKey:key] forColumnName:key];
        }
        
        [allEntries addObject:entry];
    }

    return allEntries;
}

+(void)deleteEntriesWithPredicate:(EasyPredicate*)predicate{
    NSString *deleteQuery = [predicate getPredicateString];
    [EasyStore invokeRawQuery:deleteQuery];
}

+(void)updateEntriesWithPredicate:(EasyPredicate*)predicate{
    NSString *updateQuery = [predicate getPredicateString];
    [EasyStore invokeRawQuery:updateQuery];
}


/*
    Private Methods
 */

+(void)setEasyStoreStatus:(EasyStatus)status withError:(NSString*)error{
    _status = status;
    _errorMessage = [NSString stringWithString:error];
}


/*
    Properties
 */

+(EasyStatus)getStatus{
    return _status;
}

+(NSString*)getErrorMessage{
    return _errorMessage;
}



@end
