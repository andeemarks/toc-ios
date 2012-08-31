//
// Created by amarks on 31/08/12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Environment.h"

@implementation Environment

static Environment *sharedInstance = nil;

@synthesize myApiURL;

- (id)init
{
    self = [super init];

    if (self) {
        // Do Nada
    }

    return self;
}

- (void)initializeSharedInstance
{
    NSString* configuration = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* envsPListPath = [bundle pathForResource:@"Environments" ofType:@"plist"];
    NSDictionary* allEnvironmentConfiguration = [[NSDictionary alloc] initWithContentsOfFile:envsPListPath];
    NSDictionary* environmentConfig = [allEnvironmentConfiguration objectForKey:configuration];

    self.myApiURL = [environmentConfig valueForKey:@"api-url"];
}

#pragma mark - Lifecycle Methods

+ (Environment *)sharedInstance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
            [sharedInstance initializeSharedInstance];
        }
        return sharedInstance;
    }
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

- (void) release
{
    // Do Nada
}

- (id) autorelease
{
    return self;
}

- (id) retain
{
    return self;
}

@end