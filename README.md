EasyStore
=========

A lightweight object oriented SQLite wrapper.

##Installation
1. Add a link to the libsqlite3.dylib library
![AddSqliteImg](Docs/images/add-sqlite-lib.png)

2. Copy the EasyStore static library and header files into your project (All files located in Installation/EasyStore) 
![AddSqliteImg](Docs/images/copy-easy-store.png)

##Creating a table

	#import "EasyStore.h"
	
	[EasyStore beginDatabaseCreation];
	
	EasyTable *table = [EasyStore createTableWithName:@"Users"];
    
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"age"];
    [table createBooleanColumnWithName:@"retired"];
    
    [EasyStore completeDatabaseCreation];

##Insert data into a table

	EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Bob" forColumnName:@"name"];
    [entry setInteger:68 forColumnName:@"age"];
    [entry setBoolean:true forColumnName:@"retired"];
    
    [EasyStore store:entry intoTable:@"Users"];


##Querying a table

 	EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Users"];
    [predicate whereColumn:@"age" isGreaterThanInteger:65];
    [predicate andColumnIsFalse:@"retired"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    for(EasyEntry *entry in entries){
    	NSString *name = [entry getNameForColumn:@"name"];
    	int age = [entry getIntegerForColumn:@"age"];
    	bool retired = [entry getBooleanForColumn:@"retired"];
    }

##Get all data from a table

	NSArray* entries = [EasyStore selectAllEntriesForTable:@"Users"];

## Invoking raw SQL queries
(TODO)

## Retrieving SQLite errors
(TODO)

 

