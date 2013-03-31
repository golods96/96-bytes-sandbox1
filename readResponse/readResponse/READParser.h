//
//  READParser.h
//  readResponse
//
//  Created by Lev on 3/30/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface READParser : NSObject

- (void) establishDBConnection;
- (void) openDB : (NSString *) writablePath;

@end
