#import "ProductionLineRunMetrics.h"
#import "Environment.h"

@implementation ProductionLineRunMetrics

@synthesize response;
@synthesize line;
@synthesize saveSuccessful;

-(id) initWithProductionLine:(ProductionLine *) theLine {
    self = [super init];
    if (self) {
        self.response = [NSMutableData alloc];
        self.line = theLine;
        self.saveSuccessful = kUndefined;
    }
    
    return self;    
}

+(BOOL) didSaveSuccessfully: (NSNumber *) keyValue {
    return (([keyValue intValue] == kSuccess));
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)theResponse {
    int responseStatus = [(NSHTTPURLResponse *)theResponse statusCode];
    DLog(@"Received response status code %i", responseStatus);
    if (responseStatus == 201) {
        self.saveSuccessful = kSuccess;
    } else {
        self.saveSuccessful = kFail;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [response appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.saveSuccessful == kSuccess) {
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
        NSString *saved_run_id = [json objectForKey:@"_id"];
        DLog(@"Successfully saved run.  ID = %@", saved_run_id);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    DLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);

    self.saveSuccessful = kFail;
}

-(BOOL)saveWithError:(NSError **) outError {
    Environment *myEnvironment = [Environment sharedInstance];
    NSString *apiURL = myEnvironment.myApiURL;
    NSString *fullAPIURL = [NSString stringWithFormat: @"%@/productionline/run", apiURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: fullAPIURL]];
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
