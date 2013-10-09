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
-(void)setString:(NSString*)string forColumn:(NSString*)columnName;
-(void)setInteger:(int)integer forColumn:(NSString*)columnName;
-(void)setBoolean:(BOOL)booleanValue forColumn:(NSString*)columnName;
-(void)setFloat:(float)floatNumber forColumn:(NSString*)columnName;
-(void)setDate:(NSDate*)date forColumn:(NSString*)columnName;
-(void)setDateAsNowForColumn:(NSString*)columnName;

/* Get column value methods */
-(NSString*)stringForColumn:(NSString*)columnName;
-(int)integerForColumn:(NSString*)columnName;
-(BOOL)booleanForColumn:(NSString*)columnName;
-(NSDate*)dateForColumn:(NSString*)columnName;
-(float)floatForColumn:(NSString*)columnName;

/* Properties */
-(NSMutableDictionary*)getEntries;
-(NSString*)description;

@end
