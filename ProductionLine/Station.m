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

-(id) initWithId:(int) myNumber andSize: (int) mySize {
    self = [super init];
    if (self) {
        self.number = myNumber;
        self.size = mySize;
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
    return [NSString stringWithFormat:@"Station: %d Size: %d Score: %d", [self number], [self size], [self score]];
}

-(int) reduceInventoryBy:(int) amountToReduce {
    if (size - amountToReduce < 0) {
        amountToReduce = size;
    } 
    
    size -= amountToReduce;
    
    return amountToReduce;
}

-(void) increaseInventoryBy:(int) amountToIncrease {
    size += amountToIncrease;

    score += (amountToIncrease - 3.5);
}

@end
