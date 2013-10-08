EasyStore
=========

A lightweight object oriented local storage library for Objective C.

##Installation
1. Add a link to the libsqlite3.dylib library
![Image](Docs/images/add-sqlite-lib.png)

2. Copy the EasyStore static library and header files into your project<br/> 
(All files located in Installation/EasyStore) <br/>
![Image](Docs/images/copy-easy-store.png)

##Creating a Database with Tables

	#import "EasyStore.h"
	
	[EasyStore beginDatabaseCreation];
	
	EasyTable *table = [EasyStore createTableWithName:@"Users"];
    
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"age"];
    [table createBooleanColumnWithName:@"retired"];        
    
    [EasyStore completeDatabaseCreation];

##Insert Data into a Table

	EasyEntry* entry = [EasyEntry new];
    [entry setString:@"Bob" forColumnName:@"name"];
    [entry setInteger:68 forColumnName:@"age"];
    [entry setBoolean:true forColumnName:@"retired"];
    
    [EasyStore store:entry intoTable:@"Users"];


## Querying a Table

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
    
    // Get all data from a table
    entries = [EasyStore selectAllEntriesForTable:@"Users"];
	
## Keys
#### Add Identity column

Creates an autoincrementing primary key with the column name "id".

    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Students"];
    
    [table addIdentityColumn];
    [table createStringColumnWithName:@"name"];
    [table createFloatColumnWithName:@"gpa"];
    
    [EasyStore completeDatabaseCreation];

#### Set custom column to Identity column

    [EasyStore beginDatabaseCreation];
    
    EasyTable *tvTable = [EasyStore createTableWithName:@"TV_Shows"];
    [[tvTable createIntegerColumnWithName:@"identifier"] setAsIdentityColumn];
    [tvTable createStringColumnWithName:@"name"];
    [tvTable createDateColumnWithName:@"airingTime"];
    
    EasyTable *metaDataTable = [EasyStore createTableWithName:@"TV_Meta_Data"];
    [metaDataTable createIntegerColumnWithName:@"tv_identifier"];
    [metaDataTable createStringColumnWithName:@"station"];
    [metaDataTable createIntegerColumnWithName:@"views"];
    
    [EasyStore completeDatabaseCreation];

#### Add primary key

    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Cities"];
    
    [[table createStringColumnWithName:@"name"] setAsPrimaryKey];
    [table createFloatColumnWithName:@"latitude"];
    [table createFloatColumnWithName:@"longitude"];
    
    [EasyStore completeDatabaseCreation];

## Query Modifiers

#### Limit
	EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"results"];
    [predicate withLimit:5];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    
#### Offset
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"pagedResults"];
    [predicate withLimit:20 andOffset:5];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];

#### Order By Ascending

	EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Words"];
    [predicate orderAscendingByColumn:@"word"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    
#### Order by Descending
    EasyPredicate *predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Numbers"];
    [predicate orderDescendingByColumn:@"number"];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];


## Invoking Raw SQL Queries
	[EasyStore invokeRawQuery:@"INSERT INTO Words VALUES ( \"hello\" )"];
	


## Retrieving SQL Errors
    [EasyStore beginDatabaseCreation];
    
    EasyTable *table = [EasyStore createTableWithName:@"Users"];
    [table createStringColumnWithName:@"name"];
    [table createIntegerColumnWithName:@"age"];
    
    [EasyStore completeDatabaseCreation];
    
    If([EasyStore getStatus] == EASY_OK){
    	// All is good
    }else{
    	NSLog(@"SLQ error message: %@", [EasyStore getErrorMessage]);
    }


## Supported Data Types
    Integer	-	[table createIntegerColumnWithName:@"name"];
    String	-	[table createStringColumnWithName:@"name"];
    Float	-	[table createFloatColumnWithName:@"name"];
    Boolean	-	[table createBooleanColumnWithName:@"name"];
    Date	-	[table createDateColumnWithName:@"name"];
 

