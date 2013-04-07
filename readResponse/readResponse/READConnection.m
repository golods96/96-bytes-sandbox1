//
//  READConnection.m
//  readResponse
//
//  Created by Lev on 3/23/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import "READConnection.h"
#import "READParser.h"
#import <libxml/xmlreader.h>

@implementation READConnection

@synthesize receivedData;


- (void)setConnection:(NSString *)myUrl
{
    receivedData = [[NSMutableData alloc] init];
    // create request
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]
                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                               timeoutInterval:60.0];
    
    // create connection with request and start loading data
    NSURLConnection *myConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
    
    if (myConnection){
        //receivedData = [NSData data];
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
    [receivedData setLength:0];
    NSLog(@"received response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
     NSLog(@"received data %d", [data length]);
    [receivedData appendData:data];
    NSLog(@"receivedData is now %d", [receivedData length]);
    //receivedData = data;
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
   // NSString *str = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    //NSLog(@"str: %@", str);
    
    READParser *myParser = [READParser alloc];

    
    [myParser establishDBConnection];
    
    xmlTextReaderPtr myXMLReader = xmlReaderForMemory([receivedData bytes], [receivedData length], NULL, NULL,  (XML_PARSE_NOBLANKS | XML_PARSE_NOCDATA | XML_PARSE_NOERROR | XML_PARSE_NOWARNING));
    
    if (myXMLReader == NULL){
        NSLog(@"bad xml");
    } else{
        NSLog(@"good xml");
        
        NSMutableString *currentElement = nil;
        NSMutableString *currentText = nil;
        NSMutableString *currentAttribute = nil;
        NSMutableString *currentCData = nil;
        NSMutableString *currentEntityReference = nil;
        NSMutableString *currentEntity = nil;
        NSMutableString *currentProcessingInstruction = nil;
        NSMutableString *currentComment = nil;
        NSMutableString *currentDocument = nil;
        NSMutableString *currentDocumentType = nil;
        NSMutableString *currentDocumentFragment = nil;
        NSMutableString *currentNotation = nil;
        NSMutableString *whitespace = nil;
        NSMutableString *significantWhitespace = nil;
        NSMutableString *endElement = nil;
        NSMutableString *endEntity = nil;
        NSMutableString *xmlDeclaration = nil;
        char* temp;
        
        while (true) {
            if (!xmlTextReaderRead(myXMLReader)) break;
            switch (xmlTextReaderNodeType(myXMLReader)) {
                case XML_READER_TYPE_ELEMENT: {
                    temp = (char *) xmlTextReaderConstName(myXMLReader);
                    currentElement = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"element %@", currentElement);
                    break;
                }
                case XML_READER_TYPE_ATTRIBUTE: {
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentAttribute = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"attribute %@", currentAttribute);
                    break;
                }
                case XML_READER_TYPE_TEXT: {
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentText = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"text %@", currentText);
                    break;
                }
                case XML_READER_TYPE_CDATA: {
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentCData = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"CData %@", currentCData);
                    break;
                }
                case XML_READER_TYPE_NONE:{
                    NSLog(@"none");
                    break;
                }
                case XML_READER_TYPE_ENTITY_REFERENCE:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentEntityReference = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentEntityReference %@", currentEntityReference);
                    break;
                }
                case XML_READER_TYPE_ENTITY:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentEntity = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentEntity %@", currentEntity);
                    break;
                }
                case XML_READER_TYPE_PROCESSING_INSTRUCTION:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentProcessingInstruction = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentProcessingInstruction %@", currentProcessingInstruction);
                    break;
                }
                case XML_READER_TYPE_COMMENT:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentComment = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentComment %@", currentComment);
                    break;
                }
                case XML_READER_TYPE_DOCUMENT:{
                    NSLog(@"type: document");
                    break;
                }
                case XML_READER_TYPE_DOCUMENT_TYPE:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentDocumentType = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentDocumentType %@", currentDocumentType);
                    break;
                }
                case XML_READER_TYPE_DOCUMENT_FRAGMENT:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentDocumentFragment = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentDocumentFragment %@", currentDocumentFragment);
                    break;
                }
                case XML_READER_TYPE_NOTATION:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    currentNotation = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"currentNotation %@", currentNotation);
                    break;
                }
                case XML_READER_TYPE_WHITESPACE:{
                    NSLog(@"type: whitespace");
                    break;
                }
                case XML_READER_TYPE_SIGNIFICANT_WHITESPACE:{
                    
                    NSLog(@"type: whitespace");
                    
                    break;
                }
                case XML_READER_TYPE_END_ELEMENT:{

                    NSLog(@"endElement %@", endElement);
                    break;
                }
                case XML_READER_TYPE_END_ENTITY:{

                    NSLog(@"endEntity %@", endEntity);
                    break;
                }
                case XML_READER_TYPE_XML_DECLARATION:{
                    temp = (char *) xmlTextReaderConstValue(myXMLReader);
                    xmlDeclaration = [NSMutableString stringWithCString:temp encoding:NSUTF8StringEncoding];
                    NSLog(@"xmlDeclaration %@", xmlDeclaration);
                    break;
                }
                default:
                    break;
            }
        }
        
    }
 
    /*
     XML_READER_TYPE_NONE = 0
     XML_READER_TYPE_ELEMENT = 1
     XML_READER_TYPE_ATTRIBUTE = 2
     XML_READER_TYPE_TEXT = 3
     XML_READER_TYPE_CDATA = 4
     XML_READER_TYPE_ENTITY_REFERENCE = 5
     XML_READER_TYPE_ENTITY = 6
     XML_READER_TYPE_PROCESSING_INSTRUCTION = 7
     XML_READER_TYPE_COMMENT = 8
     XML_READER_TYPE_DOCUMENT = 9
     XML_READER_TYPE_DOCUMENT_TYPE = 10
     XML_READER_TYPE_DOCUMENT_FRAGMENT = 11
     XML_READER_TYPE_NOTATION = 12
     XML_READER_TYPE_WHITESPACE = 13
     XML_READER_TYPE_SIGNIFICANT_WHITESPACE = 14
     XML_READER_TYPE_END_ELEMENT = 15
     XML_READER_TYPE_END_ENTITY = 16
     XML_READER_TYPE_XML_DECLARATION = 17
     */
    
}

@end
