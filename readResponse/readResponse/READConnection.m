//
//  READConnection.m
//  readResponse
//
//  Created by Lev on 3/23/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import "READConnection.h"

@implementation READConnection

@synthesize receivedData;


- (void)setConnection:(NSString *)myUrl
{
    // create request
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]
                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                               timeoutInterval:60.0];
    
    // create connection with request and start loading data
    NSURLConnection *myConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
    
    if (myConnection){
        receivedData = [NSMutableData data];
        NSLog(@"good");
        
    } else{
        NSLog(@"bad");
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    //[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    

}

@end
