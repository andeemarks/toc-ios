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
@property int dice;

-(id) initWithId:(int) myNumber;
-(id) initWithSize:(int) mySize;
-(void) increaseInventoryBy:(int) amountToIncrease;
-(int) selectInventoryToRemove;
-(BOOL) isEmpty;
@end
