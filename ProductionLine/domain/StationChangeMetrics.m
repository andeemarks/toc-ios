//
//  StationChangeMetrics.m
//  ProductionLine
//
//  Created by Andrew Marks on 31/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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
