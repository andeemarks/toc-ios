#import "ProductionLine.h"
#import "Station.h"
#import "ProductionLineRunMetrics.h"

@implementation ProductionLine

@synthesize numberOfStations;
@synthesize inventory;
@synthesize stationData;
@synthesize partsBin;
@synthesize cycleCount;
@synthesize metrics;

-(id) initWithNumberOfStations:(int) theNumberOfStations andInventory: (int) theInventory {
    self = [super init];
    if (self) {
        self.numberOfStations = theNumberOfStations;
        self.inventory = theInventory;
    
        partsBin = [[Station alloc] initWithSize: self.inventory];
        stationData = [[NSMutableArray alloc] initWithCapacity:[self numberOfStations]];
        for(int n = 1; n <= self.numberOfStations; n++) {
            [stationData addObject:[[Station alloc] initWithId:n]];
        }
        
        metrics = [[ProductionLineRunMetrics alloc] initWithProductionLine: self];
        cycleCount = 0;
    }
    
    return self;
}

-(Station *) getSourceStationForStationId: (int)destinationStationId {
    if (destinationStationId == 0) {
        return partsBin;
    }
    
    return [stationData objectAtIndex: destinationStationId - 1];
}

-(void) runOneCycle {
    int stationIndex = 0;
    for (Station *station in stationData) {
        Station *sourceStation = [self getSourceStationForStationId: stationIndex];
        if (![sourceStation isEmpty]) {
            int amountToAdd = [sourceStation selectInventoryToRemove];
            [station increaseInventoryBy: amountToAdd];
        }
        stationIndex++;
    }
    
    cycleCount++;
}

-(Station *) stationAtIndex: (int) index {
    return [stationData objectAtIndex: index];
}

- (int) unprocessedInventory {
    return [partsBin size];
}

- (BOOL) isFinished {
    return ((Station *)stationData.lastObject).size >= inventory;
}

- (BOOL) hasUnprocessedInventory {
    return [partsBin size] > 0;
}

- (int) completedInventory {
    return ((Station *)stationData.lastObject).size;
}

-(void) completeRun {
    [metrics addObserver: self forKeyPath: @"saveSuccessful" options: NSKeyValueObservingOptionNew context: nil];
    
    NSError *saveError;
    [metrics saveWithError:&saveError];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id) metrics change: (NSDictionary *) change context: (void *) context {
    NSNumber *keyValue = (NSNumber *)[change objectForKey: NSKeyValueChangeNewKey];
    
    if ([ProductionLineRunMetrics didSaveSuccessfully: keyValue]) {
        NSLog(@"Save successful!");
    }
}

-(NSString *)toJSON {
    NSMutableString *json = [NSMutableString stringWithFormat: @"{\"number_of_stations\" : %i, \"initial_inventory_size\" : %i, \"cycle_count\" : %i", 
            [self numberOfStations], 
            [self inventory], 
            [self cycleCount]];

    [json appendString: @", \"stations\" : ["];
    for (Station *station in stationData) {
        [json appendFormat: @"{\"number\": %i, \"score\": %.1f, \"size\": %i} ", [station number], [station score], [station size]];
        [json appendFormat: (station == [stationData lastObject]) ? @"" : @", "];
    }
    [json appendString: @"]}"];

    return json;
}

@end
