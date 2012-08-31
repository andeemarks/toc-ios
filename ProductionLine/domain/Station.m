#import "Station.h"

@implementation Station

@synthesize score;
@synthesize size;
@synthesize number;
@synthesize dice;
@synthesize changes;

-(id) initWithId:(int) myNumber andSize: (int) mySize {
    self = [super init];
    if (self) {
        self.number = myNumber;
        self.size = mySize;
        self.score = 0.0f;
        self.changes = [[StationChangeMetrics alloc] init];
    }

    return self;
}

-(id) initWithId:(int) myNumber {
    return [self initWithId: myNumber andSize: 0];
}

-(id) initWithSize:(int) mySize {
    return [self initWithId: 0 andSize: mySize];
}

-(BOOL) isEmpty {
    return size <= 0;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Station: %d Size: %d Score: %.1f Changes: %@", number, size, score, changes];
}

-(int) selectInventoryToRemove {
    dice = arc4random_uniform(6) + 1;
    return [self reduceInventoryBy: dice];
}
            
-(int) reduceInventoryBy:(int) amountToReduce {
    if (size - amountToReduce < 0) {
        amountToReduce = size;
    } 
    
    size -= amountToReduce;
    
    changes.removed = amountToReduce;
    
    return amountToReduce;
}

-(void) increaseInventoryBy:(int) amountToIncrease {
    size += amountToIncrease;

    changes.added = amountToIncrease;
    
    score += ((float)amountToIncrease - 3.5);
}

-(NSString *) recentChanges {
    return [changes description];
}
@end
