//
//  EasyEntry.h
//  EasyStore
//
//  Created by Jeremy Nortey on 9/29/13.
//  Copyright (c) 2013 Jeremy Nortey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyEntry : NSObject{
    NSMutableDictionary* _entryDicitonary;
}

/* Set column value methods */
-(void)setString:(NSString*)string forColumnName:(NSString*)columnName;
-(void)setInteger:(int)integer forColumnName:(NSString*)columnName;
-(void)setBoolean:(BOOL)booleanValue forColumnName:(NSString*)columnName;
-(void)setFloat:(float)floatNumber forColumnName:(NSString*)columnName;
-(void)setDate:(NSDate*)date forColumnName:(NSString*)columnName;
-(void)setDateAsNowForColumnName:(NSString*)columnName;

/* Get column value methods */
-(NSString*)getStringForColumnName:(NSString*)columnName;
-(int)getIntegerForColumnName:(NSString*)columnName;
-(BOOL)getBooleanForColumnName:(NSString*)columnName;
-(NSDate*)getDateForColumnName:(NSString*)columnName;
-(float)getFloatForColumnName:(NSString*)columnName;

/* Properties */
-(NSMutableDictionary*)getEntries;

@end
