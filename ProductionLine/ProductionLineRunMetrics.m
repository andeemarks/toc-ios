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
    NSLog(@"Received response %@", theResponse);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //    NSLog(@"Received %@", data);
    [response appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished loading - response = %@", [self response]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

-(NSNumber *) save {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:9393/productionline/run"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *jsonString = [NSString stringWithFormat: @"{\"number_of_stations\" : %i, \"initial_inventory_size\" : %i }", [line numberOfStations], [line inventory]];
    NSData *requestData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        NSLog(@"Successful creation of connection to REST service");
    } else {
        NSLog(@"Unable to create connection to REST service");
    }
    
    return 0;
}

@end
