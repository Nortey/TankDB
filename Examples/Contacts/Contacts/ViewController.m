//
//  ViewController.m
//  Contacts
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import "ViewController.h"
#import "EasyStore.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    currentContact = -1;
    
    NSArray* currentEntries = [EasyStore selectAllEntriesForTable:@"Contacts"];
    if([currentEntries count] > 0){
        currentContact++;
        [self setContact:currentContact];
    }
}

-(IBAction)addContact:(id)sender{
    NSString* name = [contactName text];
    NSString* phoneNumber = [contactPhoneNumber text];
    NSString* emailAddres = [contactEmailAddress text];
    
    EasyEntry* entry = [EasyEntry new];
    [entry setString:name forColumn:@"name"];
    [entry setString:phoneNumber forColumn:@"emailAddress"];
    [entry setString:emailAddres forColumn:@"phoneNumber"];
    
    [EasyStore insert:entry intoTable:@"Contacts"];
    
    [self resetForm];
}

-(IBAction)nextContact:(id)sender{
    currentContact++;
    [self setContact:currentContact];
}

-(IBAction)lastContact:(id)sender{
    currentContact--;
    [self setContact:currentContact];
}

-(void)setContact:(int)index{
    EasyPredicate* predicate = [EasyPredicate new];
    [predicate selectFromTable:@"Contacts"];
    [predicate whereColumn:@"id" equalsInteger:index];
    
    NSArray* entries = [EasyStore selectEntriesWithPredicate:predicate];
    if([entries count] > 0){
        EasyEntry* entry = [entries objectAtIndex:0];
        
        NSString* name = [entry stringForColumn:@"name"];
        NSString* phoneNumber = [entry stringForColumn:@"phoneNumber"];
        NSString* emailAddres = [entry stringForColumn:@"emailAddress"];
        
        [lblName setText:name];
        [lblPhoneNumber setText:phoneNumber];
        [lblEmailAddress setText:emailAddres];
    }
}

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
