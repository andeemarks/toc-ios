//
//  Station.h
//  ProductionLine
//
//  Created by Andrew Marks on 17/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property int number;
@property int size;
@property int score;

-(id) initWithId:(int) myNumber;
-(id) initWithSize:(int) mySize;
-(int) reduceInventoryBy:(int) amountToReduce;
-(void) increaseInventoryBy:(int) amountToIncrease;

@end
