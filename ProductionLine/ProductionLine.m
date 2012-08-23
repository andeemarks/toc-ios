//
//  ProductionLine.m
//  ProductionLine
//
//  Created by Andrew Marks on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLine.h"
#import "Station.h"

@implementation ProductionLine

@synthesize numberOfStations;
@synthesize inventory;
@synthesize stationData;
@synthesize partsBin;
@synthesize cycleCount;

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
        
        cycleCount = 0;
    }
    
    return self;
}

-(void) runOneCycle {
    int amountToAdd = [partsBin selectInventoryToRemove];
    
    for (Station *station in stationData) {
        [station increaseInventoryBy: amountToAdd];
        if (station != [stationData lastObject]) {
            amountToAdd = [station selectInventoryToRemove];
        }
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
@end
