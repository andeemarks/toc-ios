//
//  ProductionLine.h
//  ProductionLine
//
//  Created by Andrew Marks on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@interface ProductionLine : NSObject

@property int numberOfStations;
@property int inventory;
@property (nonatomic) NSMutableArray *stationData;
@property (strong, nonatomic) Station *partsBin;

-(void) runOneCycle;
-(id) initWithNumberOfStations:(int) theNumberOfStations andInventory: (int) theInventory;
-(Station *) stationAtIndex: (int) index;
-(BOOL) isFinished;
-(int) completedInventory;
-(int) unprocessedInventory;
- (BOOL) hasUnprocessedInventory;

@end
