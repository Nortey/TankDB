//
//  ViewController.h
//  Contacts
//
//  Created by Jeremy Nortey on 10/9/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int currentContact;
    
    IBOutlet UILabel* lblName;
    IBOutlet UILabel* lblPhoneNumber;
    IBOutlet UILabel* lblEmailAddress;
    
    IBOutlet UITextField* contactName;
    IBOutlet UITextField* contactPhoneNumber;
    IBOutlet UITextField* contactEmailAddress;
}

-(IBAction)addContact:(id)sender;
-(IBAction)nextContact:(id)sender;
-(IBAction)lastContact:(id)sender;

-(void)setContact:(int)index;
-(int)getNumContacts;
-(void)resetForm;

@end
