//
//  READConnection.h
//  readResponse
//
//  Created by Lev on 3/23/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface READConnection : NSObject{
    NSMutableData *receivedData;
}

@property(nonatomic, retain) NSMutableData *receivedData;
- (void) setConnection: (NSString *) myUrl;

@end
