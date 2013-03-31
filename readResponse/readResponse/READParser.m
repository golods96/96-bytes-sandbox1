//
//  READParser.m
//  readResponse
//
//  Created by Lev on 3/30/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import "READParser.h"
#import <sqlite3.h>

@implementation READParser


- (void) establishDBConnection
{
    
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"read.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success){
        [self openDB:writableDBPath ];
        return;
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"read.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (success) {
        [self openDB:writableDBPath ];
    }
    
}

- (void) openDB: (NSString *) writableDBPath
{
    NSLog(@"opening db...");
    
    sqlite3 *schemeDB;
    sqlite3_stmt    *statement;
    const char *dbpath = [writableDBPath UTF8String];
    
    if (sqlite3_open(dbpath, &schemeDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "SELECT * FROM schemes";
        
        if (sqlite3_prepare_v2(schemeDB, sql_stmt, -1, &statement, NULL) != SQLITE_OK)
        {
            NSLog(@"Failed to get data");
        } else {
            NSLog(@"got data");
            
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *schemeName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)];
                
                NSLog(schemeName);
                
            }
            
            sqlite3_close(schemeDB);
        }
        
    } else {
        NSLog(@"Failed to open/create database");
    }
    
}

@end
