//
//  Station.m
//  ProductionLine
//
//  Created by Andrew Marks on 17/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Station.h"

@implementation Station

@synthesize score;
@synthesize size;
@synthesize number;

-(id) initWithId:(int) myNumber {
    self = [super init];
    if (self) {
        self.number = myNumber;
    }

    return self;
}

-(id) initWithSize:(int) mySize {
    self = [super init];
    if (self) {
        self.size = mySize;
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Station: %d Size: %d Score: %d", [self number], [self size], [self score]];
}

-(int) reduceInventoryBy:(int) amountToReduce {
    if (size - amountToReduce >= 0) {
        size -= amountToReduce;
    } else {
        size = 0;
    }
    
    return size;
}

-(void) increaseInventoryBy:(int) amountToIncrease {
    size += amountToIncrease;
}

@end
