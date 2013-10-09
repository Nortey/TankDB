//
//  AppDelegate.m
//  Contacts
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "AppDelegate.h"
#import "EasyStore.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    // Create the EasyStore database
    [EasyStore beginDatabaseCreation];
    
    EasyTable* contactsTable = [EasyStore createTableWithName:@"Contacts"];
    
    [contactsTable addIdentityColumn];
    [contactsTable createStringColumnWithName:@"name"];
    [contactsTable createStringColumnWithName:@"emailAddress"];
    [contactsTable createStringColumnWithName:@"phoneNumber"];
    
    [EasyStore completeDatabaseCreation];
    
    return YES;
}

@end
