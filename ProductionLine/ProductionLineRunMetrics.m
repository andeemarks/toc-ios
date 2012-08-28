//
//  ProductionLineRunMetrics.m
//  ProductionLine
//
//  Created by Andrew Marks on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLineRunMetrics.h"

@implementation ProductionLineRunMetrics

@synthesize response;
@synthesize line;

-(id) initWithProductionLine:(ProductionLine *) theLine {
    self = [super init];
    if (self) {
        self.response = [NSMutableData alloc];
        self.line = theLine;
    }
    
    return self;    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)theResponse {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)theResponse;
    
    NSLog(@"Received response status code %i", [httpResponse statusCode]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [response appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"Finished loading - response = %@", [self response]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

-(BOOL)saveWithError:(NSError **) outError {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:9393/productionline/run"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [[line toJSON] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        return YES;
    } else {
        *outError = [[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorCannotConnectToHost userInfo:nil];
        return NO;
    }
}

@end
