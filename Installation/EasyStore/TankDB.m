//
//  EasyStore.m
//  EasyStore
//
//  Created by Jeremy Nortey on 9/28/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "TankDB.h"

/* Static variables */
static NSMutableArray* _tables;
static sqlite3* _database;
static NSString* _databasePath;
static TDStatus _status;
static NSString* _errorMessage;

@implementation TankDB

/*
 *  Begin database creation
 *  Creates the database file and attempts to open the database
 */
+(void)beginDatabaseCreation{
    _tables = [NSMutableArray new];
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"easy_store.db"]];
    
    // Open the database
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: _databasePath ] == NO){
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_database) == SQLITE_OK){
            sqlite3_close(_database);
        } else {
            [TankDB setStatus:TD_ERROR withError:@"Failed to open/create database"];
        }
    }
}

/*
 *  Complete database creation
 *  Creates all tables and columns if they do not exist
 */
+(void)completeDatabaseCreation{
    for(TDTable *table in _tables){
        NSString* tableName = [table getName];
        NSString* tableCreatetionString = [table getCreationString];
        NSString* createTableQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ %@", tableName, tableCreatetionString];
        [TankDB invokeRawQuery:createTableQuery];
    }
}

/*
 *  Delete database file
 *  Deletes the physical database file stored on disk
 */
+(void)deleteDatabaseFile{
    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath: _databasePath error: &error];
    if(error){
        [TankDB setStatus:TD_ERROR withError:[error localizedDescription]];
    }
}


/*
 *  Create table with name
 *  Creates a new table in the database
 */
+(TDTable*)createTableWithName:(NSString*)name{
    TDTable* table = [[TDTable alloc] initWithName:name];
    [_tables addObject:table];
    
    return table;
}

/*
 *  Invoke raw query
 */
+(void)invokeRawQuery:(NSString*)query{
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_database) == SQLITE_OK){
        char *errMsg;
        const char *sql_stmt = [query UTF8String];
        
        if (sqlite3_exec(_database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            [TankDB setStatus:TD_ERROR withError:[NSString stringWithFormat:@"%s", errMsg]];
        }else{
            [TankDB setStatus:TD_OK withError:@""];
        }
        sqlite3_close(_database);
    } else {
        [TankDB setStatus:TD_ERROR withError:@"Failed to open database"];
    }
}

/*
 *  Invoke raw select query
 *  Invokes a raw select query and returns the results as an array of EasyEntry objects
 */
+(NSArray*)invokeRawSelectQuery:(NSString*)query{
    NSMutableArray* selectArray = [NSMutableArray new];
    sqlite3_stmt *selectstmt;
    
    const char *dbpath = [_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_database) == SQLITE_OK) {
        const char *command = [query UTF8String];
        
        // Perform the query
        if (sqlite3_prepare_v2(_database, command, -1, &selectstmt, NULL) == SQLITE_OK) {
            
            // For each row returned
            while (sqlite3_step(selectstmt) == SQLITE_ROW) {
                NSMutableDictionary *columnDictionary = [NSMutableDictionary new];
                
                // For each column in each row
                int numColumns = sqlite3_column_count(selectstmt);
                for(int i=0; i<numColumns; i++){
                    
                    // Get the column name
                    NSString *columnValue = nil;
                    NSString *columnName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, i)];
                    
                    // Attempt to get the column value or return nil if it does not exist
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
            
            [TankDB setStatus:TD_OK withError:@""];
        }else{
            [TankDB setStatus:TD_ERROR withError:[NSString stringWithFormat:@"%s", sqlite3_errmsg(_database)]];
        }
        sqlite3_finalize(selectstmt);
    }
    
    sqlite3_close (_database);
    return selectArray;
}


/*
 *  Clear easy store
 *  Will remove all tables from the database. Completely clears Easystore.
 */
+(void)clear{
    NSArray* tablesArray = [TankDB selectAllEntriesForTable:@"sqlite_master"];
    
    for(TDEntry* entry in tablesArray){
        NSString* tableName = [entry stringForColumn:@"tbl_name"];
        NSString* dropQuery = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", tableName];
        [TankDB invokeRawQuery:dropQuery];
    }
}

/*
 *  Store entry
 *  Will construct the query necessary to store the entry into the table
 */
+(void)insert:(TDEntry*)entry intoTable:(NSString*)tableName{
    NSMutableArray* columnNamesArray = [NSMutableArray new];
    NSMutableArray* columnValuesArray = [NSMutableArray new];
    NSMutableDictionary* entries = [entry getEntries];
    NSString* tableNameLowerCase = [tableName lowercaseString];
    
    // Add array of columns, wrapping strings in quotes
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
    
    [TankDB invokeRawQuery:storeQuery];
}

/*
 *  Get all entries for table
 *  Gets all rows in a table and returns an array of EasyEntry objects
 */
+(NSArray*)selectAllEntriesForTable:(NSString*)tableName{
    NSString* tableNameLowerCase = [tableName lowercaseString];
    NSString* selectQuery = [NSString stringWithFormat:@"SELECT * FROM %@", tableNameLowerCase];
    NSArray* selectArray = [TankDB invokeRawSelectQuery:selectQuery];
    
    NSMutableArray* allEntries = [NSMutableArray new];
    for(NSDictionary* dict in selectArray){
        TDEntry* entry = [TDEntry new];
        
        for(NSString* key in dict){
            [entry setString:[dict objectForKey:key] forColumn:key];
        }
        
        [allEntries addObject:entry];
    }
    
    return allEntries;
}

/*
 *  Get entries with predicate
 *  Constructs and invokes a select statement with a predicate. Returns array of EasyEntry objects.
 */
+(NSArray*)selectEntriesWithPredicate:(TDPredicate*)predicate{
    NSString *selectQuery = [predicate getPredicateString];
    NSArray* selectArray = [TankDB invokeRawSelectQuery:selectQuery];
    
    NSMutableArray* allEntries = [NSMutableArray new];
    for(NSDictionary* dict in selectArray){
        TDEntry* entry = [TDEntry new];
        
        for(NSString* key in dict){
            [entry setString:[dict objectForKey:key] forColumn:key];
        }
        
        [allEntries addObject:entry];
    }

    return allEntries;
}

/*
 *  Get entries with predicate
 *  Constructs and invokes a delete statement with a predicate
 */
+(void)deleteEntriesWithPredicate:(TDPredicate*)predicate{
    NSString *deleteQuery = [predicate getPredicateString];
    [TankDB invokeRawQuery:deleteQuery];
}

/*
 *  Get entries with predicate
 *  Constructs and invokes an update statement with a predicate
 */
+(void)updateEntriesWithPredicate:(TDPredicate*)predicate{
    NSString *updateQuery = [predicate getPredicateString];
    [TankDB invokeRawQuery:updateQuery];
}

/*
 *  Count entries with predicate
 *  Invokes raw count query
 */
+(int)countEntriesWithPredicate:(TDPredicate*)predicate{
    NSArray* entries = [self selectEntriesWithPredicate:predicate];
    
    if([entries count] > 0){
        TDEntry* countEntry = [entries objectAtIndex:0];
        int count = [countEntry integerForColumn:@"count"];
        return count;
    }
    
    return 0;
}
    

/*
 *  Set EasyStore status
 *  Sets the status and error message after an sql query is performed
 */
+(void)setStatus:(TDStatus)status withError:(NSString*)error{
    _status = status;
    _errorMessage = [NSString stringWithString:error];
}

/*
 *  Properties
 */
+(TDStatus)getStatus{
    return _status;
}

+(NSString*)getErrorMessage{
    return _errorMessage;
}



@end
