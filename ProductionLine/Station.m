//
//  Station.m
//  ProductionLine
//
//  Created by Andrew Marks on 17/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Station.h"

@implementation Station

-(id) initWithId:(int) myNumber andSize:(int) mySize {
    self = [super init];
    if (self) {
        size = mySize;
        number = myNumber;
    }

    return self;
}

@end
