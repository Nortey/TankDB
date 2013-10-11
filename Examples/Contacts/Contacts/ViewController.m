//
//  ViewController.m
//  Contacts
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "ViewController.h"
#import "TankDB.h"

@interface ViewController ()

@end

@implementation ViewController


/*
 *  ViewDidload
 *  When the view loads, check if contacts already exist and display the first one
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    currentContact = 1;
    [self setContact:currentContact];
}

/*
 *  Add Contact
 *  Add a contact to the local storage with the values in the textboxes
 */
-(IBAction)addContact:(id)sender{
    NSString* name = [contactName text];
    NSString* phoneNumber = [contactPhoneNumber text];
    NSString* emailAddres = [contactEmailAddress text];
    
    TDEntry* entry = [TDEntry new];
    [entry setString:name forColumn:@"name"];
    [entry setString:phoneNumber forColumn:@"emailAddress"];
    [entry setString:emailAddres forColumn:@"phoneNumber"];
    
    [TankDB insert:entry intoTable:@"Contacts"];
    
    [self resetForm];
}

/*
 *  Next contact
 *  View the next contact in the database
 */
-(IBAction)nextContact:(id)sender{
    int numContacts = [self getNumContacts];
    
    if(currentContact < numContacts){
        currentContact++;
    }
    
    [self setContact:currentContact];
}

/*
 *  Previous contact
 *  View the previous contact in the databasae
 */
-(IBAction)lastContact:(id)sender{
    
    if(currentContact > 1){
        currentContact--;
    }

    [self setContact:currentContact];
}

/*
 *  Set Contact
 *  Get the contact for the given index. Change the labels to the values of that contact
 */
-(void)setContact:(int)index{
    TDPredicate* predicate = [TDPredicate new];
    [predicate selectFromTable:@"Contacts"];
    [predicate whereColumn:@"id" equalsInteger:index];
    
    NSArray* entries = [TankDB selectEntriesWithPredicate:predicate];
    if([entries count] > 0){
        TDEntry* entry = [entries objectAtIndex:0];
        
        NSString* name = [entry stringForColumn:@"name"];
        NSString* phoneNumber = [entry stringForColumn:@"phoneNumber"];
        NSString* emailAddres = [entry stringForColumn:@"emailAddress"];
        
        [lblName setText:name];
        [lblPhoneNumber setText:phoneNumber];
        [lblEmailAddress setText:emailAddres];
    }else{
        [lblName setText:@"-"];
        [lblPhoneNumber setText:@"-"];
        [lblEmailAddress setText:@"-"];
    }
}


/*
 *  Get Number of Contacts
 *  Query for the total number of contacts in the database
 */
-(int)getNumContacts{
    TDPredicate* predicate = [TDPredicate new];
    [predicate countEntriesInTable:@"Contacts"];
    int count = [TankDB countEntriesWithPredicate:predicate];
    
    return count;
}

/*
 *  Reset form
 *  Clear the labels and hide the keyboard
 */
-(void)resetForm{
    [contactName resignFirstResponder];
    [contactPhoneNumber resignFirstResponder];
    [contactEmailAddress resignFirstResponder];
    
    [contactName setText:@""];
    [contactPhoneNumber setText:@""];
    [contactEmailAddress setText:@""];
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
