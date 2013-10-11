//
//  AppDelegate.m
//  Contacts
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "AppDelegate.h"
#import "TankDB.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    // Create the database
    [TankDB beginDatabaseCreation];
    
    TDTable* contactsTable = [TankDB createTableWithName:@"Contacts"];
    
    [contactsTable addIdentityColumn];
    [contactsTable createStringColumnWithName:@"name"];
    [contactsTable createStringColumnWithName:@"emailAddress"];
    [contactsTable createStringColumnWithName:@"phoneNumber"];
    
    [TankDB completeDatabaseCreation];
    
    return YES;
}

@end
