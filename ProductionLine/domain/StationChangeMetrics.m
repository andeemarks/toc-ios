#import "StationChangeMetrics.h"

@implementation StationChangeMetrics

@synthesize added;
@synthesize removed;

- (id) init {
    self = [super init];
    if (self) {
        self.added = 0;
        self.removed = 0;
    }

    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat: @"+%d, -%d", [self added], [self removed]];
}

@end
